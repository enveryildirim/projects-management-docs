# Sürekli Entegrasyon, Sürekli Dağıtım (CI/CD) ve Dağıtım Stratejisi

> **Bu dokümanın amacı nedir?**
> Bu belge, geliştirilen kaynak kodun mühendis ortamından üretim (production) sunucularına güvenli, otomatik ve kesintisiz bir biçimde aktarılmasını sağlayan ardışık düzen (pipeline) kurallarını tanımlamaktadır.

---

**Temel Hedefimiz:** Kurumumuzda gelenekselleşmiş olan dağıtım risklerini minimize ederek, insan faktöründen kaynaklanabilecek hataları ortadan kaldırmak; kodun üretim ortamına aktarımını tam otomatik hale getirmek ve kritik durumlarda güvenli bir şekilde eski sürüme dönüş (rollback) kabiliyetini sağlamaktır.

## 1. Versiyon Kontrolü ve İzole Önizleme (Preview) Akışı

Projelerimizde süreç darboğazlarına ve karmaşık GitFlow yapılarına mahal vermemek adına **Gerçek Trunk-Based Development** modeli benimsenmiştir.

| Dal (Branch) Adı | Kullanım Amacı | Kurallar |
| --- | --- | --- |
| `main` | Üretim Ortamı (Production) | Doğrudan kod taahhüdü (commit) yapılamaz. Yalnızca doğrulanmış ve onaylanmış Değişiklik Talepleri (Pull Request - PR) birleştirilebilir (merge). `main` dalı her daim **dağıtıma hazır (deployable)** statüsünde olmalıdır. |
| `feat/x`, `fix/y` | Geliştirme ve Önizleme | Geliştiriciler tarafından spesifik görevler için oluşturulur. PR oluşturulduğu anda ilgili dala özgü **Geçici Önizleme Ortamı (Preview Deployment)** otomatik olarak başlatılır. |

*(Not: Organizasyonumuzda statik bir `staging` dalı **bulunmamaktadır**. Manuel Kalite Güvence (QA) testleri doğrudan ilgili PR'a ait Preview URL'si üzerinden gerçekleştirilir.)*

## 2. Sürekli Entegrasyon ve Güvenlik (CI - Continuous Integration)

Bir PR oluşturulduğunda, GitHub Actions otomasyonu derhal tetiklenir. Aşağıda belirtilen adımlardan herhangi birinin başarısız olması durumunda PR süreci bloke edilir:

* [ ] **Veri Sızıntısı Önleme (DLP) ve Sır Taraması (Shift-Left Security):** TruffleHog/GitGuardian entegrasyonu çalıştırılır. Koda kazara eklenmiş API anahtarları, maskelenmemiş gerçek hasta/kullanıcı verileri veya kimlik numaraları tespit edilirse PR reddedilir (Bkz: `ai-manifesto.md`).
* [ ] **Linter ve Atıl Kod Analizi:** Yapay zeka araçları tarafından üretilmiş olabilecek kullanılmayan fonksiyonlar ile ESLint ve Prettier standart uyumsuzlukları taranır.
* [ ] **Birim (Unit) ve Entegrasyon Testleri:** İş mantığını ve Yatay Yetki Yükseltme (IDOR) gibi kritik güvenlik zafiyetlerini doğrulayan otomatik testler icra edilir (Bkz: `test-qa-strategy.md`).
* [ ] **Derleme (Build) Doğrulaması:** `pnpm build` komutu aracılığıyla TypeScript derleme süreçleri ve tip güvenliği denetlenir.

## 3. Veritabanı Göçleri (Migrations) ve "Expand-Contract" Örüntüsü

Eski sürüme güvenli dönüş (rollback) operasyonlarının başarıyla yürütülebilmesi için, veritabanı şemasının daima bir önceki uygulama versiyonuyla **geriye dönük uyumlu (backward compatible)** olması zorunludur.

* CI/CD süreçleri kapsamında üretim veritabanına otomatik göç (`db:migrate`) işlemleri uygulanır.
* 🚨 **Yıkıcı Değişiklik Kısıtlaması:** Tek bir PR kapsamında tablo silme (DROP) veya kolon ismi değiştirme (RENAME) operasyonları kesinlikle YASAKTIR.
* **Expand-Contract Örüntüsü:** Bir veri kolonunda değişiklik yapılması gerektiğinde; ilk aşamada yeni kolon sisteme eklenir (Expand) ve uygulama hem eski hem de yeni kolona veri yazacak şekilde güncellenir. Sonraki dağıtımlarda mevcut veriler yeni kolona taşınır. Nihai aşamada ise artık kullanılmayan eski kolon sistemden kaldırılır (Contract). Bu strateji, acil durumlarda kodun geri alınması gerektiğinde sistemin veri kaybı veya çökme yaşamadan işleyişini sürdürmesini sağlar.

## 4. Sürekli Dağıtım (CD) ve Kesintisiz Geçiş (Zero-Downtime)

Kod inceleme süreçleri tamamlanıp PR onaylandıktan ve "Preview" ortamında QA testlerinden başarıyla geçtikten sonra, dağıtım süreci tam otomatik olarak ilerler.

* **Üretim (Production) Ortamına Dağıtım:** PR `main` dalına birleştirildiği (merge) an, sistem otomatik olarak yeni bir "Release Tag" (Örn: `v1.2.0`) oluşturur ve güncel versiyonu üretim sunucularına aktarır.
* **Kesintisiz Geçiş (Zero-Downtime Deployment):** Docker konteynerizasyon teknolojisi sayesinde yeni uygulama versiyonu arka planda başlatılır. Konteynerin `healthcheck` sinyali başarılı dönene dek tüm ağ trafiği eski versiyon üzerinden akmaya devam eder. Yeni sistem tam operasyonel hale geldiğinde, Yük Dengeleyici (Load Balancer) trafiği güvenli bir şekilde yeni versiyona yönlendirir.

## 5. Acil Durum Yönetimi ve Sürüm Geri Alma (Rollback)

Üretim ortamına aktarılan kodda kritik bir zafiyet veya hata tespit edilmesi durumunda uygulanacak prosedür:

1. **Manuel Müdahale Yasağı:** Kriz anlarında üretim sunucularına doğrudan bağlanarak (SSH üzerinden vs.) kod düzenlemesi yapmak kesinlikle yasaktır (No hotfixing in production).
2. **Otomatik Sürüm Geri Alma (Rollback):** CI/CD ardışık düzeni üzerinden tek bir komut ile onaylanmış en son stabil sürüme (Örn: `v1.1.9`) dönülür. Veritabanı yönetiminde *Expand-Contract* örüntüsü uygulandığı için sistem herhangi bir veri tutarsızlığı yaşamadan operasyonlarına devam eder.
3. **Kök Neden Analizi (Root Cause Analysis):** Sistem hızlıca stabil duruma getirildikten sonra, hatanın kök nedeni yerel geliştirme ortamında tespit edilir. Gerekli Olay Sonrası İnceleme (Post-Mortem) toplantısı gerçekleştirilerek (Bkz: `communication-and-meetings.md`), çözüm yeni bir PR süreci ile sisteme dâhil edilir.

---

*Son Güncelleme: 2026-08-30 — Versiyon 2.0 — Doküman Sahibi: DevOps / Tech Lead*