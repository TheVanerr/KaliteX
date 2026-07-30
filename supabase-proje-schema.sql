-- KaliteX — Proje Havuzu tabloları
-- Supabase Dashboard → SQL Editor'de bir kez çalıştırın.

-- Projeler (sidebar + Proje Havuzu sütunları)
CREATE TABLE IF NOT EXISTS projeler (
  id          text PRIMARY KEY,
  label       text NOT NULL,
  status      text NOT NULL DEFAULT 'active',  -- active | archived
  sort_order  int  NOT NULL DEFAULT 0,
  created_at  timestamptz NOT NULL DEFAULT now()
);

-- Proje ↔ parametre atamaları (model_atama ile aynı mantık)
CREATE TABLE IF NOT EXISTS proje_atama (
  project_id     text NOT NULL REFERENCES projeler(id) ON DELETE CASCADE,
  parametre_kod  text NOT NULL,
  PRIMARY KEY (project_id, parametre_kod)
);

CREATE INDEX IF NOT EXISTS proje_atama_kod_idx ON proje_atama (parametre_kod);

-- RLS (model_atama ile uyumlu — anon okur, giriş yapan yazar)
ALTER TABLE projeler ENABLE ROW LEVEL SECURITY;
ALTER TABLE proje_atama ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "projeler_select" ON projeler;
CREATE POLICY "projeler_select" ON projeler FOR SELECT USING (true);

DROP POLICY IF EXISTS "projeler_insert" ON projeler;
CREATE POLICY "projeler_insert" ON projeler FOR INSERT WITH CHECK (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "projeler_update" ON projeler;
CREATE POLICY "projeler_update" ON projeler FOR UPDATE USING (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "projeler_delete" ON projeler;
CREATE POLICY "projeler_delete" ON projeler FOR DELETE USING (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "proje_atama_select" ON proje_atama;
CREATE POLICY "proje_atama_select" ON proje_atama FOR SELECT USING (true);

DROP POLICY IF EXISTS "proje_atama_insert" ON proje_atama;
CREATE POLICY "proje_atama_insert" ON proje_atama FOR INSERT WITH CHECK (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "proje_atama_delete" ON proje_atama;
CREATE POLICY "proje_atama_delete" ON proje_atama FOR DELETE USING (auth.role() = 'authenticated');
