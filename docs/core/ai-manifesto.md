# ai-manifesto.md

# Yapay Zeka (AI) Kodlama ve Kullanım Manifestosu

> **Bu doküman ne işe yarar?**
> Bilişsel yükü azaltmak, tekrarlayan görevleri otomatize etmek ve geliştirici deneyimini en üst düzeye çıkarmak için AI araçlarının projede nasıl güvenli, sistematik ve verimli kullanılacağını tanımlar.

---

## 1. Mülkiyet ve Sorumluluk (Pilot Sensin)

Yapay zeka araçları hızımızı artıran harika yardımcı pilotlardır, ancak sistemin ana sorumluluğu ve karar alma yetkisi insandadır.

* **Son Onay İnsandadır:** Yapay zekanın ürettiği kodun projedeki tüm sorumluluğu (güvenlik, performans, standartlara uygunluk), o kodu ana projeye ekleyen geliştiriciye aittir. AI bir danışmandır, kodun nihai sahipliği size aittir.
* **Karar Verme Devredilemez (Feraset):** AI size seçenekler sunabilir ve hesaplamalar (predict) yapabilir; ancak mimari tercihleri, iş mantığındaki ödünleşimleri (trade-off) ve "neyin geliştirileceğini" seçmek tamamen sizin mühendislik ferasetinize kalmıştır.
* **"Kötü Kodu Hızlandırma" Tuzağı:** AI, iyi yönetilmezse sadece kötü kodu (spagetti) daha hızlı üretmenize sebep olur. AI, doğru mimari prensiplerle dizginlenmeli (harnessing) ve sıkı bir şekilde yönlendirilmelidir.

## 2. Güvenlik, Uyum ve DLP (Kırmızı Çizgilerimiz)

Sağlık verisi (KVKK/HIPAA) işleyen bir sistemde güvenlik, "geliştiricinin hata yapmamasına" emanet edilemez. Davranışsal kurallar yerine sistemsel bariyerler kullanıyoruz.

* **Lisans ve Telemetri (Zero-Data Retention):** Projelerimizde sadece veri tutmama (Zero-Data Retention) garantisi veren, Enterprise veya Business lisanslı AI araçları kullanılabilir. Bireysel lisansların modeli eğiten (training opt-in) ve telemetri toplayan özellikleri **kesinlikle kapalı** tutulmalıdır.
* **DLP (Data Loss Prevention) Otomasyonu:** API anahtarları, `.env` dosyaları veya canlı hasta verilerinin AI'a sızmasını önlemek için lokal ortamlarda `TruffleHog` veya `git-secrets` tabanlı pre-commit hook'ları zorunludur. Yanlışlıkla gerçek bir TC kimlik no veya API Key koda/prompta gömüldüğünde sistem commit'i reddeder.
* **Anonim Veri Kuralı:** Test ve prompt süreçlerinde her zaman algoritmik olarak üretilmiş sahte (faker) veriler kullanılır.

## 3. Bağlam Optimizasyonu ve AI Destekli Üretim

Yapay zeka, bağlamsız kaldığında veya aşırı bilgiye maruz bırakıldığında halüsinasyon üretir.

* **Sistematik Bağlam (Otomasyon):** Her yeni projede reponun kök dizininde bir `.cursorrules` (veya `.github/copilot-instructions.md`) dosyası bulunmalıdır. Mimari yığın, isimlendirme standartları ve klasör yapısı buraya yazılır. Geliştirici her promptta mimariyi hatırlatmakla uğraşmaz, sistem bunu AI'a otomatik enjekte eder (Hidden System Prompt).
* **Bağlam Daraltma (Token Economy):** AI'a bağlam verirken implementasyon dosyalarını (`.ts`, `.tsx`) değil, **sadece arayüzleri (Interface) ve tipleri (`.d.ts`, `schema.ts`)** verin. AI'ı detaylarda boğmak yerine sözleşmelere (contracts) göre kod yazmaya zorlayın.
* **AI Destekli TDD (Test-Driven Development):** Kodu yazmadan önce testler istenir. Kabul Kriterleri (DoD) prompt olarak verilir ve AI'ın önce başarısız (red) testleri yazması sağlanır. Testler onaylandıktan sonra, AI'dan bu testleri geçecek (green) implementasyonu yazması istenir.

## 4. Kod İnceleme (Code Review) Beklentileri

AI desteğiyle yazılmış bir kod, manuel yazılmış bir koda göre farklı zafiyetler barındırır. Pull Request (PR) süreçlerindeki kurallarımız:

* **"Şüpheli Varsayılan" (Suspicious by Default) Kültürü:** AI ile üretilen kodlar sentaktik olarak kusursuz görünse de, iş mantığı açısından **potansiyel hatalı** kabul edilmelidir. İnceleyici (Reviewer); boşluklara veya değişken isimlerine değil, doğrudan **veri akışına (data flow) ve uç durumlara (edge cases)** odaklanmalıdır.
* **Tautolojik Test Tuzağından Kaçınma:** AI'ın mevcut implementasyona bakarak yazdığı testler, genellikle kodun mevcut (ve muhtemelen hatalı) durumunu doğrulayan "yalancı yeşil" testlerdir. Testler, kodun ne yaptığına değil, iş kurallarının (business logic) ne beklemesi gerektiğine göre değerlendirilmelidir.
* **"Kod Olarak Prompt" (Prompt-as-Code) Mikro-ADR:** AI kullanılarak üretilen kompleks mimari veya iş mantığı PR'larında, **kullanılan ana prompt** PR açıklama şablonuna yapıştırılmalıdır. Bu, inceleyicinin "Geliştirici ne istedi, AI ne anladı?" denklemini kurmasını sağlar.
* **Halüsinasyon ve Bağımlılık Kontrolü:** AI'ın sırf kolayına geldiği için projeye eklediği gereksiz kütüphaneler (örn. basit bir tarih işlemi için `moment.js`) ve kullanılmayan ölü fonksiyonlar tespit edilip reddedilmelidir.

## 5. Uygulama ve Kurulum Adımları (Aksiyon Listesi)

Bu manifestonun kurallarını projenizde aktif hale getirmek için aşağıdaki adımları tamamlayın.

### A. Proje/Repo Kurulumu (Tek Seferlik - Tech Lead/DevOps)

* [ ] **Sistem Promtunun Eklenmesi:** Proje kök dizininde `.cursorrules` veya `.github/copilot-instructions.md` dosyasını oluşturun. İçine mimari yığını (Next.js, Tailwind vb.), klasör yapısı kurallarını ve isimlendirme standartlarını yazın.
* [ ] **PR Şablonunun Güncellenmesi:** `.github/pull_request_template.md` dosyasını oluşturun/güncelleyin. Şablona şu iki maddeyi ekleyin:
* *"Bu PR'da karmaşık mantıklar AI ile üretildiyse ana prompt: [Buraya Yazın]"*
* *"Ölü kod ve halüsinasyon bağımlılık kontrolü yapıldı mı? [ ]"*


* [ ] **DLP Güvenlik Kancası (Pre-commit):** Projeye `husky` ve (tercihen) `trufflehog` veya `git-secrets` entegre edin. API anahtarlarının commit edilmesini engelleyecek kancayı (hook) yapılandırın.
* [ ] **Sahte Veri (Mock) Altyapısı:** AI promptlarında kullanılmak üzere projeye `faker.js` veya benzeri bir sahte veri üretim kütüphanesi kurun ve bir örnek mock veri klasörü (`/mocks`) oluşturun.

### B. Geliştirici Aksiyonları (Onboarding ve Günlük Kullanım)

* [ ] **Lisans ve Telemetri Kontrolü:** Kullandığınız yapay zeka aracının (Cursor, Copilot, ChatGPT) ayarlarından "Telemetry" ve "Use my data to train models" (Verilerimi model eğitimi için kullan) seçeneklerini **kapatın** veya şirketinizin sağladığı Enterprise hesabına giriş yapın.
* [ ] **Bağlam Yönetimi Pratiği:** IDE üzerinde AI kullanırken tüm dosyaları bağlama dahil etme alışkanlığını bırakın. Sadece `.d.ts`, `types.ts` veya `schema.ts` dosyalarını etiketleyerek (örn. `@schema.ts`) soru sormayı pratik edin.
* [ ] **AI-TDD Denemesi:** Bir sonraki küçük taskınızda, kodu yazdırmadan önce AI'a DoD (Bitti Kriterleri) listesini verip başarısız testleri (red phase) yazdırmayı deneyin.

# Kaynaklar

* [AI Neyi Bilir? ∘ Akın Kaldıroğlu](https://www.youtube.com/watch?v=XIaytbzA0rU)

---

*Son güncelleme: 2026-08-29 — Versiyon 2.0 — Sahibi: Tech Lead / Engineering Manager*




