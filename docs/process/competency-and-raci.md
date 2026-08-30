# Yetkinlik ve RACI Matrisi
# Yetkinlik ve Etki Alanı Matrisi

> **Bu Dokümanın Amacı**
> Bu doküman, çeşitli teknoloji alanlarında kurum içi karar vericilerin (Otorite), danışmanların (Uzman) ve gelişim aşamasındaki çalışanların (Öğrenen) rollerini şeffaf bir biçimde tanımlamayı amaçlamaktadır. Aynı zamanda `.github/CODEOWNERS` dosyamızın yapısal temelini oluşturur.

## 1. Yetkinlik Seviyeleri

* **Otorite (O):** İlgili teknik alanın nihai karar merciidir. Seviye 2 kapsamındaki kararlarda son onayı verme yetkisine sahiptir. Her teknik alan için yalnızca bir Otorite belirlenmelidir.
* **Uzman (U):** İlgili alanda derin pratik bilgi ve tecrübeye sahiptir. Otorite konumundaki kişiye ulaşılamadığı durumlarda karar alma sürecini devralır (Yedekleme/Fallback).
* **Geliştirici (G):** Bağımsız olarak kod geliştirme yetkinliğine sahiptir; ancak mimari tasarım kararlarına doğrudan yön vermez.
* **Öğrenen (Ö):** İlgili alanda bilgi ve becerilerini geliştirmeyi hedefleyen, Eşli Programlama (Pair Programming) pratikleriyle desteklenen ekip üyesidir.

## 2. Örnek Yetkinlik ve Etki Alanı Matrisi (Dinamik Harita)

| Teknik Alan (Domain) | Ali | Ayşe | Can | Zeynep |
| --- | --- | --- | --- | --- |
| **Next.js & App Router** | G | **O** | U | Ö |
| **Drizzle ORM & Postgres** | **O** | Ö | U | G |
| **LLM & Prompt Mühendisliği** | Ö | G | G | **O** |
| **Docker, CI/CD Pipeline** | U | Ö | **O** | G |

## 3. Sistem Pratikleri ve Otomasyon

* **Otomatize Edilmiş Gözden Geçirme (CODEOWNERS):** Geliştirme sürecinde "Bu kod değişikliğini kim inceleyebilir?" sorusu ortadan kaldırılmıştır. Proje genelinde yer alan `CODEOWNERS` dosyası, değişiklik yapılan dizinleri baz alarak Pull Request (PR) inceleme atamalarını doğrudan matriste tanımlı Otoritelere (O) otomatik olarak gerçekleştirir.
* **Kurum İçi Mentörlük:** "Öğrenen (Ö)" rolündeki çalışanlarımız, ilgili alanın "Uzmanı (U)" ile eşleştirilerek Eşli Programlama (Pair Programming) seanslarına dahil edilir.
* **Unvansız Liderlik:** Kurumumuzda yetkinlik, kıdemden bağımsız değerlendirilir. Altı aylık deneyime sahip bir geliştirici, ekibin geri kalanından daha derinlemesine bilgi sahibi olduğu spesifik bir teknolojide "Otorite" rolünü üstlenebilir.

---

### 🚀 Sisteme Entegre Edilecek Kurulum Aksiyonları (Görevler)

* [ ] **CODEOWNERS Otomasyonu:** Depo kök dizininde (veya `.github/` klasörü altında) bir `CODEOWNERS` dosyası oluşturulmalıdır. Matriste belirlenen Otoriteler, ilgili dosya yollarıyla eşleştirilmelidir. *(Örnek: `src/db/** @ali` veya `src/app/** @ayse`)*
* [ ] **Dal Koruma Kuralları (Branch Protection):** GitHub/GitLab depo ayarları üzerinden "Require review from Code Owners" (Kod sahiplerinden onay zorunluluğu) seçeneği aktif edilmelidir.
* [ ] **Zaman Aşımı Politikası:** Ekip içi iletişim kanallarında (Slack/Teams vb.) "24 Saat Otorite Devri (Fallback)" kuralı duyurulmalıdır. Otoriteye 24 saat içerisinde ulaşılamadığı durumlarda, PR onay işlemlerinin ilgili Uzman (U) inisiyatifiyle tamamlanabileceği bilgisi ilgili kanallara sabitlenmelidir.

# RACI Matrisi ve Roller

> **Bu Dokümanın Amacı**
> Ekip içerisindeki görev, yetki ve sorumluluk sınırlarını yoruma mahal vermeyecek netlikte belirleyerek süreç verimliliğini artırmayı hedefler. Bu doküman, [Karar Verme Yetkisi](./decision-making-authority.md) prensiplerinin operasyonel süreçlere uygulanmış pratik bir özetidir.

## 1. Rollerin Tanımları

* **R (Responsible - Sorumlu):** İlgili görevi fiilen icra eden, kodu geliştiren veya tasarımı oluşturan kişidir. Bir görev kapsamında birden fazla "R" atanabilir.
* **A (Accountable - Hesap Veren):** İşin doğru standartlarda ve zamanında tamamlanmasından nihai olarak sorumlu olan ve "R"nin çıktılarını onaylayan kişidir. Altın kural: Her görevde **yalnızca bir adet** "A" bulunmalıdır. (Detaylı bilgi için bkz: [Karar Verme Yetkisi](./decision-making-authority.md))
* **C (Consulted - Danışılan):** Karar alma aşamasından veya geliştirme sürecinden önce uzmanlık görüşüne başvurulan kişidir (Çift yönlü iletişim gerektirir).
* **I (Informed - Bilgilendirilen):** Karar alındıktan veya ilgili iş canlı ortama aktarıldıktan sonra sonuç hakkında bilgi verilen kişidir (Tek yönlü iletişim gerektirir).

## 2. Yazılım Ekibi İçin Örnek RACI Matrisi

| Süreç / Görev | Ürün Yöneticisi (PM) | Tech Lead / Senior | Geliştirici (Dev) | QA / Test Uzmanı | Müşteri / Paydaş |
| --- | --- | --- | --- | --- | --- |
| **[Müşteri Talebi (Triage) Analizi](./musteri-talep-rehberi.md)** | A, R | C | I | I | C |
| **[DoR Kriterlerini Hazırlamak](./dor.md)** | A, R | C | I | C | I |
| **Özelliği Geliştirmek (Kod Yazımı)** | I | A | R | I | I |
| **Kod İncelemesi (Code Review) Yapmak** | I | A, R | C | I | I |
| **[Kalite Kontrol (Test) ve Onay (DoD)](./dod.md)** | I | C | I | A, R | I |
| **Canlı Ortama Alma (Deployment)** | C | A, R | I | C | I |
| **[Yeni Mimari/Kütüphane Seçimi (ADR)](./decision-making-authority.md)** | I | A, R | C | I | I |

## 3. Uygulama Pratikleri

* **"C" Rolünün Optimizasyonu:** Süreçlerde çok fazla kişiye danışmak karar alma mekanizmasını yavaşlatabilir. Yalnızca ilgili konuda derin uzmanlığı bulunan kişiler "C" olarak konumlandırılmalıdır.
* **"A" ve "R" Rollerinin Konsolidasyonu:** Kapsamı dar görevlerde işi icra eden (R) ile nihai sorumlu (A) aynı kişi olabilir (Örneğin: Tech Lead unvanlı personelin kendi geliştirdiği kodu canlı ortama aktarması).
* **Matrisin Şeffaflaştırılması:** Bu tablonun, [Oryantasyon](./onboarding-and-setup.md) dokümanlarının ilk bölümünde yer alması zorunludur. Böylece yeni katılan ekip üyeleri, süreç aksaklıklarında ulaşmaları gereken kişileri (QA) veya mimari önerilerde ikna etmeleri gereken mercileri (Tech Lead) ilk günden itibaren net bir şekilde bileceklerdir.
