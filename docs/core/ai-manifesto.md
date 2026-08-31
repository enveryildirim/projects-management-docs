# Yapay Zeka (AI) Kodlama ve Kullanım Manifestosu

> **Bu dokümanın amacı nedir?**
> Bilişsel yükü en aza indirmek, tekrarlayan görevleri otomatize etmek ve geliştirici deneyimini en üst düzeye çıkarmak amacıyla yapay zeka araçlarının projelerimizde nasıl güvenli, sistematik ve verimli bir şekilde kullanılacağını standartlaştırmaktır.

---

## 1. Mülkiyet ve Sorumluluk

Yapay zeka araçları geliştirme süreçlerimizi hızlandıran değerli yardımcı pilotlar olsalar da, sistemin nihai sorumluluğu ve karar alma yetkisi tamamen mühendislik ekiplerimize aittir.

* **Nihai Onay Mühendise Aittir:** Yapay zeka tarafından üretilen kodun (güvenlik, performans, standartlara uygunluk gibi) tüm sorumluluğu, ilgili kodu ana projeye entegre eden geliştiriciye aittir. Yapay zeka bir danışman statüsündedir; kodun nihai mülkiyeti ekibimizdedir.
* **Karar Verme Süreçleri Devredilemez:** Yapay zeka çeşitli seçenekler sunabilir ve tahminsel hesaplamalar yapabilir; ancak mimari tercihlerin belirlenmesi, iş mantığındaki ödünleşimlerin (trade-off) yönetilmesi ve geliştirilecek unsurların seçimi tamamen mühendislik ferasetimize tabidir.
* **Kalitesiz Kodun Hızlandırılması Riski:** Yapay zeka sistemleri doğru yönetilmediği takdirde, mimari açıdan zayıf (spagetti) kodların daha hızlı üretilmesine yol açabilir. Bu nedenle, yapay zeka araçları sağlam mimari prensiplerle çerçevelenmeli ve titizlikle yönlendirilmelidir.

## 2. Güvenlik, Uyumluluk ve Veri Kaybını Önleme (DLP)

Hassas verilerin işlendiği sistemlerde güvenlik, yalnızca bireysel dikkate bırakılamaz. Süreçlerimizi davranışsal kurallar yerine sistemsel kısıtlamalarla güvence altına alıyoruz.

* **Lisanslama ve Telemetri (Sıfır Veri Tutma):** Projelerimizde yalnızca veri tutmama (Zero-Data Retention) garantisi sunan, Kurumsal (Enterprise/Business) lisanslı yapay zeka araçlarının kullanımına izin verilmektedir. Bireysel lisanslara ait olan ve modelleri eğiten (training opt-in) ile telemetri toplayan özelliklerin **kesinlikle devre dışı** bırakılması zorunludur.
* **DLP (Veri Kaybını Önleme) Otomasyonu:** API anahtarlarının, ortam değişkeni dosyalarının veya canlı verilerin yapay zekaya sızmasını önlemek amacıyla yerel ortamlarda secret tarama tabanlı pre-commit hook'larının kullanımı zorunludur (araç seçimi için bkz: [Güvenlik ve Uyum](../process/security-and-compliance.md)). Yanlışlıkla gerçek bir hassas verinin koda veya komuta (prompt) eklenmesi durumunda sistem ilgili commit işlemini reddedecektir.
* **Anonim Veri Kullanımı:** Test ve komut (prompt) süreçlerinde istisnasız olarak algoritmik olarak üretilmiş sahte (mock/faker) veriler kullanılmalıdır.

## 3. Bağlam Optimizasyonu ve Yapay Zeka Destekli Üretim

Yapay zeka sistemleri, bağlamsız bırakıldığında veya aşırı bilgi yüklemesine maruz kaldığında hatalı çıktılar (halüsinasyon) üretebilmektedir.

* **Sistematik Bağlam (Otomasyon):** Her yeni projenin kök dizininde, kullanılan yapay zeka aracının okuduğu bir **bağlam dosyası** (araç bağımsız ifadeyle: proje kural dosyası) bulundurulması zorunludur. Mimari yığın, isimlendirme standartları ve klasör yapısı bu dosyada tanımlanır. Araç bazlı dosya adları ilgili [Stack dokümanında](../stacks/README.md) belirtilir. Bu sayede, sistem ilgili mimari bağlamı yapay zekaya otomatik olarak entegre eder (Hidden System Prompt).
* **Bağlam Daraltma (Token Optimizasyonu):** Yapay zekaya bağlam sağlanırken implementasyon dosyaları yerine, **yalnızca arayüz (interface), tip ve şema tanımları** sunulmalıdır. Yapay zeka, detaylara boğulmak yerine sözleşmelere (contracts) dayalı kod üretimine yönlendirilmelidir.
* **Yapay Zeka Destekli TDD (Test Odaklı Geliştirme):** Kodlama aşamasından önce testlerin oluşturulması esastır. Kabul Kriterleri (Definition of Done - DoD) girdi olarak sunulur ve yapay zekanın öncelikle başarısız (red) testleri yazması sağlanır. Testler onaylandıktan sonra, bu testleri başarıyla geçecek (green) implementasyonun üretilmesi talep edilir.

## 4. Kod İnceleme (Code Review) Standartları

Yapay zeka desteğiyle üretilen kodlar, manuel olarak yazılan kodlara kıyasla farklı potansiyel riskler barındırabilmektedir. Pull Request (PR) süreçlerindeki kurallarımız aşağıda belirtilmiştir:

* **Sorgulayıcı Yaklaşım (Suspicious by Default):** Yapay zeka tarafından üretilen kodlar sözdizimsel olarak kusursuz görünse dahi, iş mantığı açısından **potansiyel olarak hatalı** varsayılmalıdır. İnceleyici (Reviewer), kodun biçimsel özelliklerinden ziyade doğrudan **veri akışına (data flow) ve uç durumlara (edge cases)** odaklanmalıdır.
* **Totolojik Test Riskinden Kaçınma:** Yapay zekanın mevcut implementasyona dayanarak oluşturduğu testler, genellikle kodun mevcut (ve muhtemel hatalı) durumunu doğrulayan yanıltıcı testlerdir. Testler, kodun mevcut işleyişine göre değil, iş kurallarının (business logic) gereksinimlerine göre değerlendirilmelidir.
* **"Kod Olarak Komut" (Prompt-as-Code) Mikro-ADR:** Yapay zeka kullanılarak üretilen karmaşık mimari veya iş mantığı PR'larında, **kullanılan ana komut (prompt)** PR açıklama şablonuna eklenmelidir. Bu uygulama, inceleyicinin beklenti ve çıktı arasındaki ilişkiyi daha iyi analiz etmesini sağlar.
* **Halüsinasyon ve Bağımlılık Denetimi:** Yapay zekanın projeye eklediği gereksiz kütüphaneler (örneğin basit bir tarih işlemi için `moment.js` kullanımı) ve kullanılmayan atıl fonksiyonlar tespit edilerek PR süreci reddedilmelidir.

## 5. Uygulama ve Kurulum Prosedürleri

Bu manifestoda belirtilen standartların projenizde aktif hale getirilmesi için aşağıdaki adımların tamamlanması gerekmektedir.

### A. Proje/Depo Kurulumu (Tek Seferlik - Teknik Lider / DevOps Sorumluluğunda)

* [ ] **Sistem Komutunun Eklenmesi:** Proje kök dizininde, kullanılan yapay zeka aracının okuduğu bağlam dosyasını oluşturunuz. İlgili mimari yığını, klasör yapısı kurallarını ve isimlendirme standartlarını bu dosyada tanımlayınız.
* [ ] **PR Şablonunun Güncellenmesi:** `.github/pull_request_template.md` dosyasını oluşturunuz veya güncelleyiniz. Şablona aşağıdaki iki maddenin eklenmesi zorunludur:
  * *"Bu PR'da karmaşık iş mantıkları yapay zeka ile üretildiyse kullanılan ana komut (prompt): [Buraya Yazınız]"*
  * *"Atıl kod ve halüsinasyon bağımlılık kontrolü gerçekleştirildi mi? [ ]"*
* [ ] **DLP Güvenlik Kancası (Pre-commit):** Projeye bir pre-commit kanca yöneticisi ve secret tarama aracı entegre ediniz. Hassas verilerin commit edilmesini engelleyecek kancayı yapılandırınız (araç seçimi için bkz: [Güvenlik ve Uyum](../process/security-and-compliance.md)).
* [ ] **Sahte Veri (Mock) Altyapısı:** Yapay zeka komutlarında kullanılmak üzere projeye bir sahte veri üretim kütüphanesi kurunuz ve örnek bir mock veri klasörü oluşturunuz.

### B. Geliştirici Aksiyonları (Oryantasyon ve Günlük Kullanım)

* [ ] **Lisans ve Telemetri Kontrolü:** Kullandığınız yapay zeka aracının (Cursor, Copilot, ChatGPT vb.) ayarlarından telemetri ve model eğitimi için veri paylaşımı (Telemetry / Use my data to train models) seçeneklerini **devre dışı bırakınız** veya şirketimizin sağladığı Kurumsal (Enterprise) hesap ile giriş yapınız.
* [ ] **Bağlam Yönetimi Pratiği:** IDE üzerinde yapay zeka kullanırken tüm dosyaları bağlama dahil etme uygulamasından kaçınınız. Yalnızca tip ve şema (sözleşme) dosyalarını etiketleyerek komut oluşturmayı standart hale getiriniz.
* [ ] **AI-TDD Uygulaması:** Bir sonraki geliştirme görevinizde, kod üretimine geçmeden önce yapay zekaya Bitti Kriterleri (DoD) listesini sunarak başarısız testlerin (red phase) oluşturulmasını sağlayınız.

## 6. Kaynaklar

* [AI Neyi Bilir? ∘ Akın Kaldıroğlu](https://www.youtube.com/watch?v=XIaytbzA0rU)

---

*Son güncelleme: 2026-08-30 — Versiyon 2.0 — Sahibi: Teknik Lider (Tech Lead) / Mühendislik Yöneticisi (Engineering Manager)*
