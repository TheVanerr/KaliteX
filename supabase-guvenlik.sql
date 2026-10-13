-- KaliteX — Güvenlik: veritabanına sadece düzenleyici hesabı yazabilsin
-- Supabase Dashboard → SQL Editor'de bir kez çalıştırın. Tekrar çalıştırmak güvenlidir.
--
-- Ne yapar:
--   1) kx_is_editor() fonksiyonu: düzenleyici e-postası tek yerde tanımlı.
--      Yeni düzenleyici eklemek için sadece bu listeye e-posta ekleyin.
--   2) kx_ayarlar tablosu: personel listesi ve test cihazı kalibrasyon bilgileri.
--   3) Formlar ve havuz tablolarındaki TÜM eski kuralları silip yeniden kurar:
--        okuma  → herkes (uygulamanın salt okunur modu çalışmaya devam eder)
--        yazma  → sadece düzenleyici (ekleme / güncelleme / silme)
--      Eski kurallar adıyla silinmezse eski "giriş yapan herkes yazabilir" kuralı
--      yenisiyle birlikte geçerli kalırdı; bu yüzden hepsi silinir.

BEGIN;

CREATE OR REPLACE FUNCTION public.kx_is_editor()
RETURNS boolean
LANGUAGE sql
STABLE
AS $$
  SELECT coalesce(auth.jwt() ->> 'email', '') IN (
    'fatihgural80@gmail.com'
  )
$$;

CREATE TABLE IF NOT EXISTS public.kx_ayarlar (
  anahtar    text PRIMARY KEY,
  deger      jsonb NOT NULL DEFAULT '{}'::jsonb,
  updated_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT ON public.kx_ayarlar TO anon, authenticated;
GRANT INSERT, UPDATE, DELETE ON public.kx_ayarlar TO authenticated;

DO $$
DECLARE
  t text;
  r record;
BEGIN
  FOREACH t IN ARRAY ARRAY['kf_forms', 'kalite_parametreleri', 'model_atama', 'projeler', 'proje_atama', 'kx_ayarlar'] LOOP
    IF to_regclass('public.' || t) IS NULL THEN
      RAISE NOTICE 'Tablo bulunamadı, atlandı: %', t;
      CONTINUE;
    END IF;
    FOR r IN SELECT policyname FROM pg_policies WHERE schemaname = 'public' AND tablename = t LOOP
      EXECUTE format('DROP POLICY %I ON public.%I', r.policyname, t);
    END LOOP;
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
    EXECUTE format('CREATE POLICY kx_okuma ON public.%I FOR SELECT USING (true)', t);
    EXECUTE format('CREATE POLICY kx_ekleme ON public.%I FOR INSERT TO authenticated WITH CHECK (public.kx_is_editor())', t);
    EXECUTE format('CREATE POLICY kx_guncelleme ON public.%I FOR UPDATE TO authenticated USING (public.kx_is_editor()) WITH CHECK (public.kx_is_editor())', t);
    EXECUTE format('CREATE POLICY kx_silme ON public.%I FOR DELETE TO authenticated USING (public.kx_is_editor())', t);
  END LOOP;
END $$;

COMMIT;

-- İSTEĞE BAĞLI — formları sadece düzenleyici okusun.
-- Depo herkese açık olduğu için Supabase anahtarı da açık; bu satırlar çalıştırılmazsa
-- formlar (personel adları dahil) anahtarı bilen herkes tarafından okunabilir.
-- Çalıştırırsanız giriş yapmamış (salt okunur) kullanıcılar formları ve raporu göremez.
-- DROP POLICY IF EXISTS kx_okuma ON public.kf_forms;
-- CREATE POLICY kx_okuma ON public.kf_forms FOR SELECT USING (public.kx_is_editor());

-- Kontrol: her tabloda 4 kural görünmeli (kx_okuma, kx_ekleme, kx_guncelleme, kx_silme)
SELECT tablename, policyname, cmd
FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('kf_forms', 'kalite_parametreleri', 'model_atama', 'projeler', 'proje_atama', 'kx_ayarlar')
ORDER BY tablename, policyname;
