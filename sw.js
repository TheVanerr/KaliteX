// KaliteX Service Worker — v9
// Strateji:
//   - kalite.html + manifest.json + ikonlar: Network-first (her zaman güncel gelir)
//   - CDN (Tailwind, Lucide, Fonts): Cache-first
//   - Supabase REST API: Network-first, offline'da cache'den dön

  const CACHE = 'kalitex-v13';

const LOCAL_ASSETS = [
  './',
  './kalite.html',
  './manifest.json',
  './icon.svg',
  './icon-192.png',
  './icon-512.png',
];

const CDN_ASSETS = [
  'https://cdn.tailwindcss.com/3.4.17',
  'https://cdn.jsdelivr.net/npm/lucide@0.263.0/dist/umd/lucide.min.js',
  'https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800;900&display=swap',
];

// ── Kurulum ─────────────────────────────────────────────────────────────────
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE).then(async cache => {
      await cache.addAll(LOCAL_ASSETS);
      await Promise.allSettled(
        CDN_ASSETS.map(url =>
          fetch(url, { mode: 'cors' })
            .then(r => { if (r.ok || r.type === 'opaque') cache.put(url, r); })
            .catch(() => null)
        )
      );
    })
  );
  self.skipWaiting();
});

// ── Etkinleştirme ────────────────────────────────────────────────────────────
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))
    )
  );
  self.clients.claim();
});

// ── Fetch ────────────────────────────────────────────────────────────────────
self.addEventListener('fetch', event => {
  const { request } = event;
  if (request.method !== 'GET') return;

  const url = request.url;

  // Supabase AUTH — her zaman network (offline'da login zaten olmaz, session localStorage'da)
  if (url.includes('supabase.co/auth/')) return;

  // Supabase REST — network-first, offline'da cache'den dön
  if (url.includes('supabase.co')) {
    event.respondWith(
      fetch(request)
        .then(res => {
          if (res.ok) {
            const clone = res.clone();
            caches.open(CACHE).then(c => c.put(request, clone));
          }
          return res;
        })
        .catch(() => caches.match(request))
    );
    return;
  }

  // kalite.html, manifest ve ikonlar — network-first: her zaman güncel gelsin
  if (url.endsWith('/kalite.html') || url.endsWith('/KaliteX/') || url.endsWith('/KaliteX')
      || url.endsWith('/manifest.json') || url.endsWith('/icon-192.png') || url.endsWith('/icon-512.png') || url.endsWith('/icon.svg')) {
    event.respondWith(
      fetch(request)
        .then(res => {
          if (res.ok) {
            const clone = res.clone();
            caches.open(CACHE).then(c => c.put(request, clone));
          }
          return res;
        })
        .catch(() => caches.match('./kalite.html'))
    );
    return;
  }

  // Diğer her şey (SVG, manifest, CDN, fontlar): cache-first, dinamik cache
  event.respondWith(
    caches.match(request).then(cached => {
      if (cached) return cached;

      return fetch(request).then(res => {
        // Başarılı yanıtları ve opaque (no-cors font) yanıtları cache'le
        if (res.ok || res.type === 'opaque') {
          const clone = res.clone();
          caches.open(CACHE).then(c => c.put(request, clone));
        }
        return res;
      }).catch(() => {
        // Sayfa navigasyonunda offline fallback — ana sayfayı döndür
        if (request.mode === 'navigate') {
          return caches.match('./kalite.html');
        }
      });
    })
  );
});

// ── Arkaplan sync ────────────────────────────────────────────────────────────
self.addEventListener('sync', event => {
  if (event.tag === 'sync-forms') event.waitUntil(syncPendingForms());
});

async function syncPendingForms() {
  console.log('[KaliteX SW] Bekleyen formlar kontrol ediliyor...');
}
