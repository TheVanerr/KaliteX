// KaliteX Service Worker — v1
// Strateji: Cache-first (offline önce), Network-fallback
// CDN kaynakları ilk yüklemede önbelleğe alınır

const CACHE = 'kalitex-v2';

// Her zaman önbelleğe alınacak yerel dosyalar
const LOCAL_ASSETS = [
  './kalite.html',
  './dataX.json',
  './manifest.json',
  './icon.svg',
];

// İlk açılışta önbelleğe alınmaya çalışılacak CDN dosyaları
const CDN_ASSETS = [
  'https://cdn.tailwindcss.com/3.4.17',
  'https://cdn.jsdelivr.net/npm/lucide@0.263.0/dist/umd/lucide.min.js',
  'https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800;900&display=swap',
  'https://fonts.gstatic.com',
];

// ── Kurulum: yerel dosyaları kesin, CDN'i best-effort önbelleğe al ─────────
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE).then(async cache => {
      // Yerel dosyalar başarısız olursa kurulum durur
      await cache.addAll(LOCAL_ASSETS);
      // CDN dosyaları için hata olursa devam et
      await Promise.allSettled(
        CDN_ASSETS.map(url =>
          fetch(url, { mode: 'cors' })
            .then(r => { if (r.ok) cache.put(url, r); })
            .catch(() => null)
        )
      );
    })
  );
  // Eski SW beklemeye gerek kalmadan etkinleştir
  self.skipWaiting();
});

// ── Etkinleştirme: eski önbellekleri temizle ────────────────────────────────
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys.filter(k => k !== CACHE).map(k => caches.delete(k))
      )
    )
  );
  // Tüm sekmeleri hemen bu SW'ye bağla
  self.clients.claim();
});

// ── Fetch: Cache-first, Network-fallback ────────────────────────────────────
self.addEventListener('fetch', event => {
  const { request } = event;

  // Sadece GET isteklerini yönet
  if (request.method !== 'GET') return;

  // SDK isteklerini (platform-specific) atla — offline olunca zaten çalışmaz
  if (request.url.includes('/_sdk/')) return;

  // Supabase gibi API istekleri için Network-first (gerçek zamanlı veri önemli)
  if (request.url.includes('supabase.co')) {
    event.respondWith(
      fetch(request)
        .then(response => {
          if (response.ok) {
            const clone = response.clone();
            caches.open(CACHE).then(c => c.put(request, clone));
          }
          return response;
        })
        .catch(() => caches.match(request))
    );
    return;
  }

  // Diğer her şey için Cache-first
  event.respondWith(
    caches.match(request).then(cached => {
      if (cached) return cached;

      return fetch(request).then(response => {
        // Başarılı yanıtları önbelleğe ekle
        if (response.ok) {
          const clone = response.clone();
          caches.open(CACHE).then(c => c.put(request, clone));
        }
        return response;
      }).catch(() => {
        // Sayfa navigasyonunda offline fallback
        if (request.mode === 'navigate') {
          return caches.match('./kalite.html');
        }
      });
    })
  );
});

// ── Arkaplan sync (ileride Supabase entegrasyonu için hazır) ────────────────
self.addEventListener('sync', event => {
  if (event.tag === 'sync-forms') {
    event.waitUntil(syncPendingForms());
  }
});

async function syncPendingForms() {
  // Offline'da biriken form verilerini Supabase'e gönder
  // [Supabase entegrasyonu eklenince burası doldurulacak]
  console.log('[SW] Bekleyen formlar senkronize ediliyor...');
}
