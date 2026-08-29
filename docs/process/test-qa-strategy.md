# Test ve QA Stratejisi

> **Bu doküman ne işe yarar?**
> Ürünün kalitesini güvence altına almak için nelerin test edileceğini, hangi test türlerinin kullanılacağını ve Sürekli Doğrulama (Continuous Verification) süreçlerini tanımlar. Canlı ortamda hasta verilerinin güvenliğini ve sistemin stabilitesini sağlamak tüm geliştiricilerin sorumluluğudur.

## 1. Test Piramidi ve Kapsam

Projemizde test piramidi prensibini uyguluyoruz. Testlerin çoğunluğu hızlı çalışan birim testlerinden, daha azı maliyetli uçtan uca (E2E) testlerden oluşur.

| Test Türü | Araç | Odak Noktası | Zorunluluk |
| --- | --- | --- | --- |
| **Birim (Unit) Testleri** | Vitest / Jest | İş mantığı (Business logic), utils fonksiyonları, bağımsız UI bileşenleri. | Her yeni iş mantığı için **ZORUNLU**. |
| **Entegrasyon Testleri** | React Testing Library | Bileşenlerin birbiriyle iletişimi, veritabanı sorguları (Drizzle), API route'ları. | Kritik yollar (örn: Hasta Kayıt) için **ZORUNLU**. |
| **Uçtan Uca (E2E) Testler** | Playwright / Cypress | Gerçek tarayıcı üzerinde kullanıcı senaryoları (Login, form doldurma). | Yalnızca P1 (Çok Kritik) akışlar için. |

## 2. Ne Test Edilir, Ne Test Edilmez?

**Test Edilmesi Gerekenler:**

* **Yatay Yetki Yükseltme (IDOR) Kontrolleri:** Sistemde sağlık verisi işlendiği için, bir kullanıcının kendisine ait olmayan bir kaynağa (Örn: `GET /api/patients/123`) erişmeye çalıştığında `403 Forbidden` veya `404 Not Found` aldığını doğrulayan entegrasyon testleri **ZORUNLUDUR**. Bu testler olmadan veri çeken hiçbir uç (endpoint) canlıya alınamaz.
* Karmaşık hesaplamalar yapan fonksiyonlar (Örn: İndirim hesaplama, randevu çakışma kontrolü).
* Kullanıcı giriş doğrulama (Validation) kuralları.
* Bileşenin durum (state) değişimlerine doğru tepki vermesi (Happy Path ve Error Path).

**Test Edilmemesi Gerekenler:**

* Üçüncü parti kütüphanelerin kendi iç mantıkları (Onlar zaten test edilmiştir).
* Sadece renk, padding, margin değiştiren görsel (CSS) güncellemeler.
* Hiçbir iş mantığı içermeyen, sadece UI render eden basit statik bileşenler.

## 3. Yapay Zeka (AI), Test ve Mocking Kuralları

* **AI-TDD ve Davranış Odaklı Test (BDD):** Kapsam (Coverage) yüzdeleri hedef metrik değildir (Vanity Metric); hedef, iş mantığı davranışını (Behavior) doğrulamaktır (Bkz: `ai-manifesto.md`). Geliştirici, AI'dan test yazmasını isterken kodun kendisini değil, Kabul Kriterlerini (DoR) prompt olarak verir. AI'ın yazdığı testin 'başarısız (red)' olduğu görülmeden implementasyona geçilmez.
* **Dış Servisler Mocklanır:** Testler çalışırken asla gerçek bir dış API'ye (Örn: SMS Sağlayıcı, Ödeme Geçidi) istek atılmaz. MSW (Mock Service Worker) veya test framework'ünün mock özellikleri kullanılır.
* **Gerçek Veri Yasaktır:** Testlerde gerçek hasta verisi kullanılmaz. `faker.js` gibi kütüphanelerle algoritmik sahte veriler üretilir.

## 4. QA ve Geçici Önizleme Ortamları (Preview Environments)

* **Staging Darboğazı Yoktur:** Manuel QA süreçleri `main` dalını bloklayamaz. Geleneksel ve paylaşılan "Staging" ortamında sıra beklemek yerine, her Pull Request (PR) açıldığında o dal (branch) için izole bir **Önizleme Ortamı (Preview Deployment)** otomatik olarak ayağa kalkar (Örn: Vercel/Railway PR linkleri).
* **Asenkron Doğrulama:** QA uzmanı veya Ürün Yöneticisi (PM), manuel testlerini doğrudan bu PR linki üzerinden yapar.
* **Canlıya Çıkış (Deployment):** Kendi kodunu otomatik testlerle doğrulayan (DoD) ve QA onayını alan PR `main` dalına merge edildiğinde, doğrudan Canlı (Production) ortama çıkmaya hazırdır.

## 5. Lokal ve Önizleme (Preview) Veritabanı Bariyeri:
Geliştirici ortamlarına ve PR Preview ortamlarına hiçbir koşulda canlı veritabanı yedeği (dump) doğrudan indirilemez. Tüm geliştirme ve test verileri faker.js ile sentetik olarak üretilmeli veya canlı veri kullanılacaksa CI/CD pipeline'ı üzerinde çalışan bir Data Masking/Anonymization (Örn: pgcrypto ile TC kimlik/isim karartma) betiğinden geçirilerek anonimleştirilmelidir. Bu kuralın ihlali doğrudan bir Sev-1 güvenlik olayı (Incident) olarak değerlendirilir.
---

*Son güncelleme: 2026-08-29 — Versiyon 2.0 — Sahibi: QA Lead / Tech Lead*
