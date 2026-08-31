# Test ve Kalite Güvence (QA) Stratejisi

> **Dokümanın Amacı**
> İşbu doküman, ürün kalitesini güvence altına almak maksadıyla uygulanacak test metodolojilerini, kapsam dahilindeki bileşenleri ve Sürekli Doğrulama (Continuous Verification) süreçlerini regüle etmektedir. Üretim ortamında (production) işlenen hasta verilerinin gizliliğini/güvenliğini korumak ve sistem stabilitesini sürdürülebilir kılmak, tüm mühendislik ekibinin asli sorumluluğudur.

## 1. Test Piramidi ve Kapsam Yönetimi

Organizasyonumuzda genel geçer test piramidi prensipleri benimsenmektedir. Test otomasyon süreçlerinin ağırlıklı bölümü yüksek performanslı birim testlerine (Unit Testing), daha sınırlı ve stratejik bölümü ise kaynak maliyeti yüksek olan uçtan uca (E2E) testlere ayrılmıştır.

| Test Kategorisi | Kullanılan Araçlar | Odak Noktası | Zorunluluk Durumu |
| --- | --- | --- | --- |
| **Birim (Unit) Testleri** | Vitest / Jest | İş mantığı (Business logic), yardımcı (utility) fonksiyonlar, bağımsız arayüz (UI) bileşenleri. | Yeni eklenen her iş mantığı için **ZORUNLUDUR**. |
| **Entegrasyon Testleri** | React Testing Library | Bileşenler arası etkileşim, veritabanı sorguları (Drizzle), API yönlendirmeleri (routes). | Kritik operasyonel süreçler (Örn: Hasta Kayıt işlemleri) için **ZORUNLUDUR**. |
| **Uçtan Uca (E2E) Testler** | Playwright / Cypress | Gerçek tarayıcı ortamında uçtan uca kullanıcı senaryoları (Sisteme giriş, form doldurma işlemleri). | Yalnızca P0/P1 seviyesindeki kritik süreç akışlarında uygulanır (Bkz: [P0-P4](../core/p0-p4-prioritization.md)). |

## 2. Test Edilmesi Gereken ve Kapsam Dışı Bırakılan Unsurlar

**Kapsama Dahil Edilmesi Zorunlu Hususlar:**

* **Yatay Yetki Yükseltme (IDOR) Güvenlik Kontrolleri:** Sistem altyapısında hassas sağlık verileri işlendiğinden dolayı; bir kullanıcının yetki alanı dışındaki bir kaynağa (Örn: `GET /api/patients/123`) erişim girişiminin `403 Forbidden` veya `404 Not Found` yanıtlarıyla engellendiğini doğrulayan entegrasyon testlerinin yazılması **ZORUNLUDUR**. Bu güvenlik testlerini içermeyen hiçbir veri erişim ucu (endpoint) canlı ortama taşınamaz.
* Karmaşık iş mantığı barındıran algoritmik hesaplamalar (Örn: İndirim tahsisleri, randevu çakışma validasyonları).
* Kullanıcı girdilerinin doğrulanmasına (Validation) yönelik kurallar.
* Bileşenlerin, durum (state) değişikliklerine karşı beklenen tepkileri (İdeal Senaryo/Happy Path ve Hata Senaryosu/Error Path).

**Kapsam Dışı Bırakılan Hususlar:**

* Üçüncü parti kütüphanelerin (third-party) kendi iç mekanizmaları (İlgili paketlerin halihazırda test edildiği varsayılmaktadır).
* Yalnızca renk, boşluk (padding/margin) gibi görsel düzenlemeleri barındıran (CSS) güncellemeler.
* İş mantığı içermeyen, salt arayüz (UI) render işlemi gerçekleştiren basit ve statik bileşenler.

## 3. Yapay Zeka (AI) Destekli Test ve Sahte Veri (Mocking) Protokolleri

* **AI Destekli TDD (Test-Driven Development) ve BDD (Behavior-Driven Development):** Test kapsam (Coverage) oranları kurumumuzda birincil hedef metrik (gösteriş metriği / vanity metric) olarak değerlendirilmez; asıl amaç iş mantığının (Behavior) doğrulanmasıdır (Bkz: [AI Manifestosu](../core/ai-manifesto.md)). Mühendisler, yapay zeka araçlarından test kodlaması talep ederken referans olarak kodun kendisini değil, Kabul Kriterlerini (DoR) sağlamalıdır. Üretilen testin "başarısız (red)" durumu gözlemlenmeden uygulama (implementation) aşamasına geçilmesi kural ihlali sayılır.
* **Dış Servislerin Simüle Edilmesi (Mocking):** Test süreçlerinde hiçbir gerçek dış API servisine (Örn: SMS entegratörleri, Ödeme geçitleri) istek gönderilemez. MSW (Mock Service Worker) araçları veya ilgili test framework'ünün mock yapıları kullanılmalıdır.
* **Gerçek Veri Kullanımının Yasaklanması:** Test ortamlarında gerçek hasta/kullanıcı verilerinin kullanılması kesinlikle yasaktır. `faker.js` ve benzeri kütüphaneler aracılığıyla algoritmik sahte veriler üretilmelidir.

## 4. Kalite Güvence (QA) ve İzole Önizleme Ortamları (Preview Environments)

* **Staging Darboğazlarının Giderilmesi:** Manuel kalite güvence (QA) test süreçlerinin `main` dalını (branch) bloklamasına müsaade edilmez. Geleneksel, paylaşımlı "Staging" ortamlarındaki bekleme sürelerini ortadan kaldırmak maksadıyla, açılan her Pull Request (PR) için o geliştirme dalına özel izole bir **Önizleme Ortamı (Preview Deployment)** otomatik olarak oluşturulur (Örn: Vercel/Railway PR ortamları).
* **Asenkron Doğrulama Süreci:** QA uzmanları veya Ürün Yöneticileri (PM), manuel doğrulama işlemlerini doğrudan ilgili PR için oluşturulan önizleme bağlantısı üzerinden yürütür.
* **Üretime Sevk (Deployment):** Kod standartlarını karşılayan (DoD), otomatik testleri geçen ve QA onayını tamamlayan her PR `main` dalına birleştirildiğinde, doğrudan üretim ortamına (Production) çıkmaya hazır kabul edilir.

## 5. Yerel ve Önizleme (Preview) Veritabanı Güvenlik Bariyeri

Geliştirici bilgisayarlarına veya PR Preview ortamlarına hiçbir surette üretim (production) veritabanı yedeği (dump) doğrudan kopyalanamaz/indirilemez. Tüm geliştirme ve test verileri, ya `faker.js` gibi araçlarla tamamen sentetik olarak üretilmeli ya da canlı verinin kullanılması zorunlu olduğu hallerde CI/CD boru hattı (pipeline) üzerinde koşan bir Veri Maskeleme/Anonimleştirme betiğinden (Örn: pgcrypto yardımıyla kimlik ve isim karartma işlemleri) geçirilerek anonim hale getirilmelidir. Bu protokolün ihlali, kurum güvenlik politikaları gereği doğrudan en yüksek kritiklik seviyesinde (Sev-1 Incident) bir güvenlik vakası olarak işleme alınır.

---

*Son güncelleme: 2026-08-29 — Versiyon 2.0 — Sorumlu: QA Lead / Tech Lead*
