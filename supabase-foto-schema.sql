-- KaliteX — Form fotoğrafları (Supabase Storage)
-- Supabase Dashboard → SQL Editor'de bir kez çalıştırın.
-- Fotoğraflar özel (public olmayan) "kf-photos" alanında tutulur;
-- sadece düzenleyici hesabı okuyup yazabilir.

-- Alan: özel, dosya başı en fazla 5 MB, sadece JPEG
-- (uygulama fotoğrafları yüklemeden önce ~200 KB'a küçültür)
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('kf-photos', 'kf-photos', false, 5242880, ARRAY['image/jpeg'])
ON CONFLICT (id) DO UPDATE
  SET public = false,
      file_size_limit = EXCLUDED.file_size_limit,
      allowed_mime_types = EXCLUDED.allowed_mime_types;

-- Erişim kuralları — e-posta kalite.html'deki ALLOWED_EDITORS ile aynı olmalı
DROP POLICY IF EXISTS "kf_photos_select" ON storage.objects;
CREATE POLICY "kf_photos_select" ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'kf-photos' AND (auth.jwt() ->> 'email') = 'fatihgural80@gmail.com');

DROP POLICY IF EXISTS "kf_photos_insert" ON storage.objects;
CREATE POLICY "kf_photos_insert" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'kf-photos' AND (auth.jwt() ->> 'email') = 'fatihgural80@gmail.com');

-- Aynı dosyayı tekrar yükleme (yarıda kalan yüklemenin yeniden denenmesi) için gerekli
DROP POLICY IF EXISTS "kf_photos_update" ON storage.objects;
CREATE POLICY "kf_photos_update" ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'kf-photos' AND (auth.jwt() ->> 'email') = 'fatihgural80@gmail.com')
  WITH CHECK (bucket_id = 'kf-photos' AND (auth.jwt() ->> 'email') = 'fatihgural80@gmail.com');

DROP POLICY IF EXISTS "kf_photos_delete" ON storage.objects;
CREATE POLICY "kf_photos_delete" ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'kf-photos' AND (auth.jwt() ->> 'email') = 'fatihgural80@gmail.com');
