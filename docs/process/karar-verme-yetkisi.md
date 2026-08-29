# Karar Verme Yetkisi (Decision Rights)

> **Bu doküman ne işe yarar?**
> Ekip içinde kimin, hangi kararı, kimden onay almadan verebileceğini tanımlar. Amaç: Her küçük kararın toplantıya taşınmasını önlemek, aynı zamanda büyük kararların tek kişinin inisiyatifine kalmasını engellemek.

## 1. Neden Bu Doküman Gerekli?

Süreç dokümanları (DoD, PR kuralları) "ne yapılmalı"yı anlatır ama "buna kim karar verir" sorusunu cevaplamaz.
> 💡 **Temel Felsefe:** Ekibimizde kararlar, **kişilerin İK unvanlarına göre değil, Yetkinlik Matrisindeki etki alanına (Otorite) göre** alınır. Sınırları net çizilmiş otonomi esastır. 

## 2. Karar Seviyeleri

### Seviye 1 — Serbest (Onay gerekmez)
Geliştirici tek başına karar verir, PR review'da bilgi amaçlı belirtir.
* **Kapsam:** Fonksiyon/değişken isimlendirme, davranış değiştirmeyen küçük refactor'lar, test yazma stratejisi, kod stili.

### Seviye 2 — Onay Gerekir (Otorite Onaylar)
PR sürecinin bir parçası olarak, o alanın "Otoritesi (O)" (Bkz. Yetkinlik Matrisi) tarafından onaylanmalıdır.

| Karar Alanı | Onay Veren |
|---|---|
| Yeni bir npm/pip paketi / kütüphane ekleme | İlgili Alanın Otoritesi (O) |
| Veritabanı şeması değişikliği (yeni tablo/kolon) | Veritabanı Otoritesi |
| API sözleşmesi (contract) değişikliği | Backend ve Frontend Otoriteleri |
| Performans/güvenlik etkisi olan refactor | İlgili Alanın Otoritesi (O) |
| CI/CD pipeline değişikliği | DevOps Otoritesi |

### Seviye 3 — Ekip Kararı (ADR Gerekir)
Geri dönüşü zor, birden fazla ekibi etkileyen kararlar sözlü alınamaz; bir **ADR (Architecture Decision Record)** yazılır.
* **Kapsam:** Yeni programlama dili/framework geçişi, monolith → microservice geçişi, 3. parti kritik servis (ödeme/veritabanı) seçimi, playbook/süreç değişiklikleri.

## 4. Anlaşmazlık Durumu (Escalation) ve Fallback

* **Seviye 2 Anlaşmazlığı:** Otorite ile geliştirici uzlaşamazsa, Tech Lead / Engineering Manager nihai kararı verir ve PR'a yazar.
* **Seviye 3 Anlaşmazlığı:** Tartışma 24 saati geçerse, karar en üst teknik sorumluya eskale edilir. Uzlaşamama bahanesiyle süreç süresiz kilitlenemez.
* **Otorite Yokluğu (Fallback Kuralı):** Kararı vermesi gereken Otorite (O) izindeyse veya 24 saat içinde yanıt veremiyorsa, karar yetkisi o alanın "Uzmanlarına (U)" devredilir. Sistem onay bekleyerek durdurulamaz.