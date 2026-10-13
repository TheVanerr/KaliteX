-- KaliteX — Önerilen kalite kontrol maddeleri (84 madde)
-- Supabase Dashboard → SQL Editor'de bir kez çalıştırın. Tekrar çalıştırmak güvenlidir:
-- var olan kod / atama / sıra tekrar eklenmez.
-- Çalıştırdıktan sonra KaliteX'te ⟳ ile yenileyin (açık sekme eski sırayla kaydederse
-- yeni maddeler tablonun sonuna kayabilir).

BEGIN;

-- 1) Maddeler — biçim havuzdaki mevcut maddelerle aynı (T: 10/-/!QEH, N: 10/4/-, TN: 20/-/-)
INSERT INTO kalite_parametreleri (kod, alan_turu, uzunluk, desimal, aciklama, grup, grup_kodu, updated_at) VALUES
  ('K1049', 'T', '10', '', 'KAPAK / PANO KAPISI TOPRAKLAMA ÖRGÜSÜ KONTROLÜ', 'BAĞLANTI', '!QEH', now()),
  ('K1050', 'T', '10', '', 'KABLOLAR SICAK VE HAREKETLİ PARÇALARDAN UZAK MI?', 'BAĞLANTI', '!QEH', now()),
  ('K1051', 'T', '10', '', 'KABLO BAĞLARI VE KABLO KANALI KAPAKLARI KONTROLÜ', 'BAĞLANTI', '!QEH', now()),
  ('K1052', 'T', '10', '', 'PNÖMATİK HAT VE SİLİNDİR BAĞLANTISI KONTROLÜ', 'BAĞLANTI', '!QEH', now()),
  ('K1053', 'T', '10', '', 'TESVİYE AYAKLARI / TEKERLER VE KİLİTLERİ KONTROLÜ', 'BAĞLANTI', '!QEH', now()),
  ('K1054', 'T', '10', '', 'EMİŞ / TORBA FİLTRESİ DOĞRU OTURMA KONTROLÜ', 'BAĞLANTI', '!QEH', now()),
  ('K1055', 'T', '10', '', 'KONVEYÖR BANT / ZİNCİR HİZA VE GERGİNLİK KONTROLÜ', 'BAĞLANTI', '!QEH', now()),
  ('K2032', 'T', '10', '', 'TANK SU TUTMA TESTİ (DOLU TANK 30 DK BEKLETME)', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K2033', 'T', '10', '', 'ÇALIŞMA SICAKLIĞINDA SIZINTI KONTROLÜ', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K2034', 'T', '10', '', 'POMPA MEKANİK SALMASTRA SIZINTI KONTROLÜ', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K2035', 'T', '10', '', 'TAŞMA (OVERFLOW) HATTI SIZINTI KONTROLÜ', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K2036', 'T', '10', '', 'KAPAK CONTASI OTURMA VE BUHAR KAÇAĞI KONTROLÜ', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K2037', 'T', '10', '', 'YAĞ AYIRICI BAĞLANTILARI SIZINTI KONTROLÜ', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K2038', 'T', '10', '', 'PNÖMATİK HAT HAVA KAÇAĞI KONTROLÜ', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K2039', 'T', '10', '', 'ÇALIŞMA SONRASI PANO İÇİNE SU / BUHAR GİRİŞİ KONTROLÜ', 'SIZINTI VE KAÇAK', '!QEH', now()),
  ('K3070', 'N', '10', '4', 'TOPRAKLAMA SÜREKLİLİĞİ 1. ÖLÇÜM (OHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3071', 'N', '10', '4', 'TOPRAKLAMA SÜREKLİLİĞİ 2. ÖLÇÜM (OHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3072', 'N', '10', '4', 'TOPRAKLAMA SÜREKLİLİĞİ 3. ÖLÇÜM (OHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3073', 'N', '10', '4', 'TOPRAKLAMA SÜREKLİLİĞİ 4. ÖLÇÜM (OHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3074', 'N', '10', '4', 'TOPRAKLAMA SÜREKLİLİĞİ 5. ÖLÇÜM (OHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3075', 'N', '10', '4', 'İZOLASYON DİRENCİ L1-PE (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3076', 'N', '10', '4', 'İZOLASYON DİRENCİ L2-PE (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3077', 'N', '10', '4', 'İZOLASYON DİRENCİ L3-PE (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3078', 'N', '10', '4', 'İZOLASYON DİRENCİ N-PE (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3079', 'N', '10', '4', 'İZOLASYON DİRENCİ L1-L2 (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3080', 'N', '10', '4', 'İZOLASYON DİRENCİ L1-L3 (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3081', 'N', '10', '4', 'İZOLASYON DİRENCİ L2-L3 (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3082', 'N', '10', '4', 'İZOLASYON DİRENCİ L1-N (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3083', 'N', '10', '4', 'İZOLASYON DİRENCİ L2-N (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3084', 'N', '10', '4', 'İZOLASYON DİRENCİ L3-N (MOHM)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3085', 'N', '10', '4', 'FLASH TEST L1-PE KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3086', 'N', '10', '4', 'FLASH TEST L2-PE KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3087', 'N', '10', '4', 'FLASH TEST L3-PE KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3088', 'N', '10', '4', 'FLASH TEST N-PE KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3089', 'N', '10', '4', 'FLASH TEST L1-L2 KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3090', 'N', '10', '4', 'FLASH TEST L1-L3 KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3091', 'N', '10', '4', 'FLASH TEST L2-L3 KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3092', 'N', '10', '4', 'FLASH TEST L1-N KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3093', 'N', '10', '4', 'FLASH TEST L2-N KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3094', 'N', '10', '4', 'FLASH TEST L3-N KAÇAK AKIM (mA)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3095', 'T', '10', '', 'ANA ŞALTER ASMA KİLİTLE KİLİTLENEBİLİYOR MU?', 'ELEKTRİK KUTUSU', '!QEH', now()),
  ('K3096', 'T', '10', '', 'KABLO RAKORLARI SIKILIK VE SIZDIRMAZLIK KONTROLÜ', 'ELEKTRİK KUTUSU', '!QEH', now()),
  ('K3097', 'T', '10', '', 'KLEMENS VİDALARI SIKMA (TORK) KONTROLÜ', 'ELEKTRİK KUTUSU', '!QEH', now()),
  ('K3098', 'T', '10', '', 'KABLO / KLEMENS NUMARALARI ŞEMA UYUMU KONTROLÜ', 'ELEKTRİK KUTUSU', '!QEH', now()),
  ('K3099', 'N', '10', '4', 'BESLEME GERİLİMİ ÖLÇÜMÜ (V)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3100', 'N', '10', '4', '24 V DC KUMANDA GERİLİMİ ÖLÇÜMÜ (V)', 'ELEKTRİK KUTUSU', '', now()),
  ('K3101', 'T', '10', '', 'PANO FANI / HAVALANDIRMA FİLTRESİ KONTROLÜ', 'ELEKTRİK KUTUSU', '!QEH', now()),
  ('K4052', 'T', '10', '', 'ÇALIŞIRKEN KAPAK AÇILINCA POMPA/SEPET DURUYOR MU?', 'FONKSİYON', '!QEH', now()),
  ('K4053', 'T', '10', '', 'SU SEVİYESİ DÜŞÜKKEN ISITICI ÇALIŞMIYOR MU?', 'FONKSİYON', '!QEH', now()),
  ('K4054', 'T', '10', '', 'SU SEVİYESİ DÜŞÜKKEN POMPA ÇALIŞMIYOR MU?', 'FONKSİYON', '!QEH', now()),
  ('K4055', 'T', '10', '', 'EMNİYET TERMOSTATI (AŞIRI SICAKLIK) KESME TESTİ', 'FONKSİYON', '!QEH', now()),
  ('K4056', 'T', '10', '', 'ENERJİ GELİNCE MAKİNE KENDİLİĞİNDEN ÇALIŞMIYOR MU?', 'FONKSİYON', '!QEH', now()),
  ('K4057', 'T', '10', '', 'TAM ÇEVRİM (REÇETE) DENEME YIKAMASI KONTROLÜ', 'FONKSİYON', '!QEH', now()),
  ('K4058', 'N', '10', '4', 'POMPA BASINCI (BAR)', 'FONKSİYON', '', now()),
  ('K4059', 'N', '10', '4', 'ISINMA SÜRESİ - ORTAMDAN SET SICAKLIĞA (DK)', 'FONKSİYON', '', now()),
  ('K4060', 'T', '10', '', 'NOZZLE PÜSKÜRTME DESENİ VE TIKANIKLIK KONTROLÜ', 'FONKSİYON', '!QEH', now()),
  ('K4061', 'T', '10', '', 'ANORMAL SES / TİTREŞİM KONTROLÜ', 'FONKSİYON', '!QEH', now()),
  ('K4062', 'T', '10', '', 'DENEME PARÇASI TEMİZLİK VE KURULUK KONTROLÜ', 'FONKSİYON', '!QEH', now()),
  ('K5009', 'T', '10', '', 'KESKİN KENAR VE ÇAPAK KONTROLÜ', 'GÖRSEL', '!QEH', now()),
  ('K5010', 'T', '10', '', 'KAYNAK DİKİŞİ GÖRSEL KALİTE KONTROLÜ', 'GÖRSEL', '!QEH', now()),
  ('K5011', 'T', '10', '', 'PASLANMAZ YÜZEYDE DEMİR BULAŞMASI / PAS KONTROLÜ', 'GÖRSEL', '!QEH', now()),
  ('K5012', 'T', '10', '', 'EKSİK VİDA, SOMUN VE KAPAK TAPASI KONTROLÜ', 'GÖRSEL', '!QEH', now()),
  ('K5013', 'T', '10', '', 'MAKİNE DIŞ ÖLÇÜLERİ TEKNİK RESİM UYUMU KONTROLÜ', 'GÖRSEL', '!QEH', now()),
  ('K6013', 'T', '10', '', 'ELEKTRİK TEHLİKESİ ETİKETİ PANO KAPAĞINDA MI?', 'ETİKET VE TEMİZLİK', '!QEH', now()),
  ('K6014', 'T', '10', '', 'SICAK YÜZEY UYARI ETİKETİ KONTROLÜ', 'ETİKET VE TEMİZLİK', '!QEH', now()),
  ('K6015', 'T', '10', '', 'TOPRAKLAMA (PE) SEMBOLÜ ETİKETİ KONTROLÜ', 'ETİKET VE TEMİZLİK', '!QEH', now()),
  ('K6016', 'T', '10', '', 'DÖNEN PARÇA / EL SIKIŞMA UYARI ETİKETİ KONTROLÜ', 'ETİKET VE TEMİZLİK', '!QEH', now()),
  ('K6017', 'T', '10', '', 'TİP ETİKETİ BİLGİLERİ MAKİNE İLE UYUMLU MU?', 'ETİKET VE TEMİZLİK', '!QEH', now()),
  ('K6018', 'T', '10', '', 'TANK VE HÜCREDE YABANCI MADDE KALDI MI?', 'ETİKET VE TEMİZLİK', '!QEH', now()),
  ('K6019', 'T', '10', '', 'TEST SUYU TAHLİYESİ VE KURULAMA KONTROLÜ', 'ETİKET VE TEMİZLİK', '!QEH', now()),
  ('K7005', 'T', '10', '', 'HAREKETLİ PARÇALAR NAKLİYE İÇİN SABİTLENDİ Mİ?', 'AMBALAJ', '!QEH', now()),
  ('K7006', 'T', '10', '', 'NEM ALICI (SİLİKA JEL) KONULDU MU?', 'AMBALAJ', '!QEH', now()),
  ('K7007', 'T', '10', '', 'KALDIRMA NOKTASI / YÖN İŞARETLERİ KONTROLÜ', 'AMBALAJ', '!QEH', now()),
  ('K7008', 'T', '10', '', 'DOKÜMANLAR AMBALAJA KONULDU MU?', 'AMBALAJ', '!QEH', now()),
  ('K7009', 'T', '10', '', 'PALET / KIZAK SAĞLAMLIK KONTROLÜ', 'AMBALAJ', '!QEH', now()),
  ('K8034', 'TN', '20', '', 'PLC / HMI PROGRAM VERSİYONU', 'PLC', '', now()),
  ('K8035', 'T', '10', '', 'ALARM GEÇMİŞİ VE SAYAÇLAR SIFIRLANDI MI?', 'PLC', '!QEH', now()),
  ('K8036', 'T', '10', '', 'HMI DİL SEÇENEĞİ (MÜŞTERİ DİLİ) KONTROLÜ', 'PLC', '!QEH', now()),
  ('K8037', 'T', '10', '', 'HMI ŞİFRE / YETKİ SEVİYELERİ KONTROLÜ', 'PLC', '!QEH', now()),
  ('K8038', 'T', '10', '', 'PLC PROGRAM YEDEĞİ ALINDI MI?', 'PLC', '!QEH', now()),
  ('K9015', 'T', '10', '', 'CE UYGUNLUK BEYANI VAR MI?', 'DÖKÜMANTASYON', '!QEH', now()),
  ('K9016', 'T', '10', '', 'ELEKTRİKSEL GÜVENLİK TEST RAPORU EKLENDİ Mİ?', 'DÖKÜMANTASYON', '!QEH', now()),
  ('K9017', 'T', '10', '', 'YEDEK PARÇA LİSTESİ VAR MI?', 'DÖKÜMANTASYON', '!QEH', now()),
  ('K9018', 'T', '10', '', 'BAKIM TALİMATI VAR MI?', 'DÖKÜMANTASYON', '!QEH', now())
ON CONFLICT (kod) DO NOTHING;

-- 2) Elektrik ölçüm maddeleri (25 adet) → tüm 33 modele
INSERT INTO model_atama (model_id, parametre_kod)
SELECT m, k
FROM unnest(ARRAY['lym-950', 'lym-1150', 'lym-1350', 'lym-1500', 'vdl-2500', 'vdl-3500', 'vdl-4250', 'vdl-5500', 'vdl-6500', 'kbn-1b-1650', 'kbn-1b-1850', 'kbn-1b-2050', 'kbn-2b-1650', 'kbn-2b-1850', 'kbn-2b-2050', 'rts-346-2b', 'rts-346-4b', 'pyt-40', 'pyt-90', 'pyt-750', 'pyt-800', 'mst-pro-02', 'mts-lvb-60', 'mst-lvb-100', 'ult-m40', 'ult-m60', 'ult-m80', 'ult-m100', 'ult-m140', 'ult-m400-1b-l', 'knv-30-3000-2b', 'knv-60-4250-1b', 'knv-60-6000-2b']) AS m
CROSS JOIN unnest(ARRAY['K3070', 'K3071', 'K3072', 'K3073', 'K3074', 'K3075', 'K3076', 'K3077', 'K3078', 'K3079', 'K3080', 'K3081', 'K3082', 'K3083', 'K3084', 'K3085', 'K3086', 'K3087', 'K3088', 'K3089', 'K3090', 'K3091', 'K3092', 'K3093', 'K3094']) AS k
WHERE NOT EXISTS (SELECT 1 FROM model_atama a WHERE a.model_id = m AND a.parametre_kod = k);

-- 3) Satır sırası — her grubun son maddesinin hemen altına yerleştir
--    (KaliteX sırayı __KX_ORDER__ kaydında JSON dizi olarak tutar)
DO $$
DECLARE
  arr jsonb;
  res jsonb := '[]'::jsonb;
  e text;
  ek jsonb;
BEGIN
  SELECT aciklama::jsonb INTO arr FROM kalite_parametreleri WHERE kod = '__KX_ORDER__';
  IF arr IS NULL THEN RAISE EXCEPTION '__KX_ORDER__ kaydı bulunamadı'; END IF;
  -- Yeni kodlar daha önce eklendiyse önce çıkar (tekrar çalıştırmada çift olmasın)
  SELECT coalesce(jsonb_agg(x ORDER BY i), '[]'::jsonb) INTO arr
    FROM jsonb_array_elements_text(arr) WITH ORDINALITY AS t(x, i)
    WHERE x <> ALL (SELECT jsonb_array_elements_text('["K1049", "K1050", "K1051", "K1052", "K1053", "K1054", "K1055", "K2032", "K2033", "K2034", "K2035", "K2036", "K2037", "K2038", "K2039", "K3070", "K3071", "K3072", "K3073", "K3074", "K3075", "K3076", "K3077", "K3078", "K3079", "K3080", "K3081", "K3082", "K3083", "K3084", "K3085", "K3086", "K3087", "K3088", "K3089", "K3090", "K3091", "K3092", "K3093", "K3094", "K3095", "K3096", "K3097", "K3098", "K3099", "K3100", "K3101", "K4052", "K4053", "K4054", "K4055", "K4056", "K4057", "K4058", "K4059", "K4060", "K4061", "K4062", "K5009", "K5010", "K5011", "K5012", "K5013", "K6013", "K6014", "K6015", "K6016", "K6017", "K6018", "K6019", "K7005", "K7006", "K7007", "K7008", "K7009", "K8034", "K8035", "K8036", "K8037", "K8038", "K9015", "K9016", "K9017", "K9018"]'::jsonb));
  FOR e IN SELECT x FROM jsonb_array_elements_text(arr) WITH ORDINALITY AS t(x, i) ORDER BY i LOOP
    res := res || to_jsonb(e);
    ek := CASE e
      WHEN 'K1048' THEN '["K1049", "K1050", "K1051", "K1052", "K1053", "K1054", "K1055"]'::jsonb
      WHEN 'K2031' THEN '["K2032", "K2033", "K2034", "K2035", "K2036", "K2037", "K2038", "K2039"]'::jsonb
      WHEN 'K3069' THEN '["K3070", "K3071", "K3072", "K3073", "K3074", "K3075", "K3076", "K3077", "K3078", "K3079", "K3080", "K3081", "K3082", "K3083", "K3084", "K3085", "K3086", "K3087", "K3088", "K3089", "K3090", "K3091", "K3092", "K3093", "K3094", "K3095", "K3096", "K3097", "K3098", "K3099", "K3100", "K3101"]'::jsonb
      WHEN 'K4051' THEN '["K4052", "K4053", "K4054", "K4055", "K4056", "K4057", "K4058", "K4059", "K4060", "K4061", "K4062"]'::jsonb
      WHEN 'K5008' THEN '["K5009", "K5010", "K5011", "K5012", "K5013"]'::jsonb
      WHEN 'K6012' THEN '["K6013", "K6014", "K6015", "K6016", "K6017", "K6018", "K6019"]'::jsonb
      WHEN 'K7004' THEN '["K7005", "K7006", "K7007", "K7008", "K7009"]'::jsonb
      WHEN 'K8033' THEN '["K8034", "K8035", "K8036", "K8037", "K8038"]'::jsonb
      WHEN 'K9010' THEN '["K9015", "K9016", "K9017", "K9018"]'::jsonb
      ELSE NULL END;
    IF ek IS NOT NULL THEN res := res || ek; END IF;
  END LOOP;
  UPDATE kalite_parametreleri SET aciklama = res::text, updated_at = now() WHERE kod = '__KX_ORDER__';
END $$;

COMMIT;

-- Kontrol: eklenen madde ve atama sayısı (beklenen: 84 madde, 825 atama)
SELECT
  (SELECT count(*) FROM kalite_parametreleri WHERE kod IN ('K1049', 'K1050', 'K1051', 'K1052', 'K1053', 'K1054', 'K1055', 'K2032', 'K2033', 'K2034', 'K2035', 'K2036', 'K2037', 'K2038', 'K2039', 'K3070', 'K3071', 'K3072', 'K3073', 'K3074', 'K3075', 'K3076', 'K3077', 'K3078', 'K3079', 'K3080', 'K3081', 'K3082', 'K3083', 'K3084', 'K3085', 'K3086', 'K3087', 'K3088', 'K3089', 'K3090', 'K3091', 'K3092', 'K3093', 'K3094', 'K3095', 'K3096', 'K3097', 'K3098', 'K3099', 'K3100', 'K3101', 'K4052', 'K4053', 'K4054', 'K4055', 'K4056', 'K4057', 'K4058', 'K4059', 'K4060', 'K4061', 'K4062', 'K5009', 'K5010', 'K5011', 'K5012', 'K5013', 'K6013', 'K6014', 'K6015', 'K6016', 'K6017', 'K6018', 'K6019', 'K7005', 'K7006', 'K7007', 'K7008', 'K7009', 'K8034', 'K8035', 'K8036', 'K8037', 'K8038', 'K9015', 'K9016', 'K9017', 'K9018')) AS eklenen_madde,
  (SELECT count(*) FROM model_atama WHERE parametre_kod IN ('K3070', 'K3071', 'K3072', 'K3073', 'K3074', 'K3075', 'K3076', 'K3077', 'K3078', 'K3079', 'K3080', 'K3081', 'K3082', 'K3083', 'K3084', 'K3085', 'K3086', 'K3087', 'K3088', 'K3089', 'K3090', 'K3091', 'K3092', 'K3093', 'K3094')) AS eklenen_atama;
