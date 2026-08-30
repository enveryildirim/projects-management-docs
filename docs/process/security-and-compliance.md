# Güvenlik ve Uyum Standartları (DevSecOps)

> **Bu dokümanın amacı nedir?**
> Güvenliği, yazılım geliştirme döngüsünün son aşamasında yapılan bir "denetim" olmaktan çıkarıp, sürecin en başından itibaren (Shift-Left) standart bir mühendislik pratiği haline getirmektir. Aşağıdaki kurallar, müşteri verilerinin gizliliğini ve şirket altyapısının güvenliğini sağlamak için istisnasız uygulanmalıdır.

---

## 1. Kimlik Bilgileri ve Sızıntı Önleme (Secret Management)

Kurumumuzda kaynak kodun barındırıldığı depolara (repository) hiçbir kimlik bilgisinin sızmaması esastır.

* **Katı Kural:** Kaynak koda API anahtarları, şifreler, erişim token'ları, özel anahtarlar (private keys) veya veritabanı bağlantı dizeleri (connection string) **kesinlikle yazılamaz ve commit edilemez.**
* **Otomasyon ve Engelleme:** CI/CD süreçlerimizde TruffleHog (veya benzeri statik analiz araçları) aktif olarak çalışır. Kod içerisinde bir "secret" formatı tespit edildiğinde, Pull Request (PR) süreci otomatik olarak bloke edilir. Tespit edilen bir sızıntı durumunda, ilgili kimlik bilgisi (credential) derhal iptal edilmeli (revoke) ve yenilenmelidir.

## 2. Veri Gizliliği (KVKK / GDPR Uyumu)

Müşteri ve kullanıcılarımıza ait gerçek verilerin korunması en üst düzey önceliğimizdir.

* **Veri İzolasyonu:** Üretim (Production) ortamındaki gerçek kullanıcı verileri (PII - Kişisel Olarak Tanımlanabilir Bilgiler), test, staging veya lokal geliştirme ortamlarına hiçbir şekilde kopyalanamaz veya taşınamaz.
* **Sentetik Veri Kullanımı:** Lokal ortam kurulumları (Örn: `make setup`) ve entegrasyon testleri, yalnızca anonimleştirilmiş, maskelenmiş veya sentetik olarak üretilmiş sahte veriler kullanılarak gerçekleştirilmelidir.

## 3. Zafiyet Yönetimi ve Sürekli Tarama (Vulnerability Management)

Yazılım tedarik zinciri (supply chain) ve kendi geliştirdiğimiz kodlar, sürekli olarak zafiyetlere karşı denetlenir.

* **Bağımlılık Taraması (SCA):** Kullanılan üçüncü parti kütüphaneler, açık kaynaklı paketler (npm, pip vb.) ve Docker imajları, bilinen zafiyetlere karşı (Örn: Dependabot veya Snyk aracılığıyla) sürekli olarak taranır. Kritik veya yüksek (Critical/High) seviye zafiyet barındıran kütüphanelerin projeye dahil edilmesi CI/CD tarafından engellenir.
* **Statik Kod Analizi (SAST):** Geliştirilen kodlar, birleştirilmeden (merge) önce statik güvenlik analizinden (Örn: SonarQube) geçirilir. SQL Injection, XSS ve benzeri yaygın web zafiyetlerini (OWASP Top 10) barındıran kodların canlı ortama geçişine izin verilmez.

## 4. Erişim ve Yetkilendirme Standartları (Access Control)

Sistem erişimlerinde asgari gereklilik prensibi uygulanır.

* **En Düşük Yetki Prensibi (Principle of Least Privilege):** Tüm mühendisler, servis hesapları (service accounts) ve uygulamalar, sadece kendi işlevlerini yerine getirebilmeleri için gereken minimum yetki düzeyine sahip olmalıdır. 
* **Denetim ve İzlenebilirlik:** Sistem üzerindeki kritik erişimler, rol tabanlı erişim kontrolü (RBAC) ile yönetilmeli ve altyapı kodları (Infrastructure as Code - IaC) üzerinden versiyonlanarak takip edilmelidir.

---
*İlgili politikalar, tüm ekiplerin güvenli kod geliştirme süreçlerine uyumunu garanti altına almak amacıyla düzenli olarak güncellenecektir.*

