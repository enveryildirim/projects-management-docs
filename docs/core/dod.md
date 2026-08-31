# Bitti Kriterleri (Definition of Done - DoD)

> **Bu dokümanın amacı nedir?**
> Geliştirilen bir kod bloğunun eksiksiz, güvenlik standartlarına uygun ve üretim ortamına (Production) aktarılmaya tam olarak hazır olduğunu güvence altına almaktır. Bu kontrol listesi, kurumumuzun Pull Request (PR) şablonlarının değişmez çekirdeğini oluşturmaktadır.

> 💡 **Kurumsal Sistem Kuralı:** "Kodu yazdım ve çalışıyor" beyanı, geliştirmenin tamamlandığı (Done) anlamına gelmez. Aşağıda belirtilen kriterler, otomasyon sistemleri ve manuel Kod İnceleme (Code Review) süreçleriyle doğrulanmadan hiçbir kod ana dala (merge) aktarılamaz.

## 1. 💻 Kod Kalitesi, Yapay Zeka Standartları ve Uyumluluk

- [ ] **Kabul Kriterleri (Acceptance Criteria):** Görev kartında (ticket) tanımlanan tüm iş ve teknik kabul kriterleri eksiksiz olarak karşılanmıştır.
- [ ] **Statik Kod Analizi ve Atıl Kod Temizliği:** Projenin yığınında tanımlı linter ve biçimlendirici (formatter) uyarıları tamamen giderilmiştir (araç tanımları için bkz: ilgili [Stack dokümanı](../stacks/README.md)). Uygulama içerisinde bırakılmış geçici hata ayıklama çıktıları kaldırılmıştır. Yapay zeka araçları tarafından üretilmiş ancak sistemde aktif olarak kullanılmayan atıl (dead) fonksiyonlar ve gereksiz bağımlılıklar (halüsinasyon kütüphaneler) reddedilerek sistemden arındırılmıştır.
- [ ] **Yapay Zeka Komut Şeffaflığı (Prompt-as-Code):** Kompleks iş mantıklarının veya kritik mimari bileşenlerin üretiminde yapay zeka araçları kullanılmış ise, süreci yönlendiren ana komut (prompt) PR açıklamasına zorunlu olarak eklenmiştir.

## 2. 🧪 Test Otomasyonu, Veri Güvenliği ve Sistem Dayanıklılığı

- [ ] **AI-TDD ve İş Mantığı (Business Logic) Testleri:** Kodun sadece mevcut çalışmasını doğrulayan (totolojik) testler değil, yazılımın karşılaması gereken iş kurallarını (business logic) sınayan kapsamlı birim (unit) ve entegrasyon testleri yazılmış ve başarıyla sonuçlanmıştır.
- [ ] **Veri Kaybı Önleme (DLP) ve Kriptografik Güvenlik:** API anahtarları, veritabanı erişim kimlik bilgileri veya gerçek müşteri/hasta verileri kod içerisine gömülmemiştir (hardcoded). Yerel ortamda çalışan secret tarama kancaları (pre-commit hooks) başarılı bir şekilde geçilmiştir (Bkz: [Güvenlik ve Uyum](../process/security-and-compliance.md)).
- [ ] **Sistem Dayanıklılığı (Graceful Degradation):** Harici servis sağlayıcılar (API'ler) çöktüğünde veya veritabanı yanıt süreleri uzadığında, sistemin tamamen işlevsiz hale gelmesi (crash) engellenmiş; kullanıcıya anlaşılır, profesyonel bir hata mesajı sunularak kısıtlı deneyim sağlayacak önlemler kodlanmıştır.

## 3. 🔄 İnceleme (Code Review) ve Sürekli Entegrasyon (CI/CD)

- [ ] **CI/CD İş Akışı Onayı:** Otomatik test paketleri, sistem derleme (build) işlemleri ve güvenlik açığı taramaları entegrasyon sunucusunda (GitHub Actions vb.) sıfır hata ile tamamlanmıştır.
- [ ] **Ortak Mülkiyet ve Kurumsal İnceleme (Anti-Hero Onayı):** Bilgi silolarının oluşmasını engellemek amacıyla, kod parçası sadece teknik liderler tarafından değil, ekip içerisinde ilgili modüle en az aşina olan mühendislerden birinin de dahil olduğu bir heyet tarafından incelenmiş ve kurumsal onay almıştır.
- [ ] **Sürüm Senkronizasyonu:** Geliştirme dalı (branch), ana sürüm dalı (`main`/`master`) ile güncel ve çakışmasız (conflict-free) durumdadır.

## 4. 📦 İzlenebilirlik, Dokümantasyon ve Dağıtım Güvenliği

- [ ] **Telemetri ve Sistem Loglaması:** Kurumsal Ürün Felsefemizde yer alan "Hipotezi Doğrulama" prensibi gereğince, yeni geliştirilen modülün kullanıcı davranışlarını anonim olarak ölçümleyecek analitik ve telemetri metrikleri koda entegre edilmiştir.
- [ ] **Kurumsal Dokümantasyon ve ADR:** Sisteme yeni `.env` parametreleri eklenmiş, yeni bir dış bağımlılık (kütüphane vb.) kullanılmış veya stratejik bir mimari değişiklik yapılmış ise, bu durum Mimari Karar Kayıtlarına (ADR - Architecture Decision Records) işlenmiştir.
- [ ] **Veritabanı Geri Alma (Rollback) Planı:** Veritabanı şemasında herhangi bir değişiklik (migration) gerçekleştirildiyse, olası canlı ortam krizlerine karşı bu değişikliğin nasıl geri alınacağı (rollback) tasarlanmış ve test edilmiştir.

---

*Son güncelleme: 2026-08-30 — Sahibi: Mühendislik Yöneticisi (Engineering Manager) / Teknik Lider (Tech Lead)*
