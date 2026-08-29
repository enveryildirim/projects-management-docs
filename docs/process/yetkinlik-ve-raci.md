# Yetkinlik ve RACI Matrisi
# Yetkinlik ve Etki Alanı Matrisi

> **Bu doküman ne işe yarar?**
> Hangi teknolojide kimin karar verici (Otorite), kimin danışman (Uzman), kimin öğrenci olduğunu şeffaflaştırır. Ayrıca `.github/CODEOWNERS` dosyamızın temelini oluşturur.

## 1. Yetkinlik Seviyeleri

* **Otorite (O):** O alanın karar merciidir. Seviye 2 kararlarında son onayı verir. Her teknik alanın sadece bir Otoritesi olmalıdır.
* **Uzman (U):** Derin pratik bilgiye sahiptir. Otorite ulaşılamaz olduğunda kararları devralır (Fallback).
* **Geliştirici (G):** Bağımsız kod yazabilir ancak mimari tasarımlara yön vermez.
* **Öğrenen (Ö):** Öğrenmek ve gelişmek isteyen, Pair Programming ile desteklenen kişi.

## 2. Örnek Yetkinlik ve Etki Alanı Matrisi (Dinamik Harita)

| Teknik Alan (Domain) | Ali | Ayşe | Can | Zeynep |
| --- | --- | --- | --- | --- |
| **Next.js & App Router** | G | **O** | U | Ö |
| **Drizzle ORM & Postgres** | **O** | Ö | U | G |
| **LLM & Prompt Mühendisliği** | Ö | G | G | **O** |
| **Docker, CI/CD Pipeline** | U | Ö | **O** | G |

## 3. Sistem Pratikleri ve Otomasyon

* **Otomatize Edilmiş Reviewer (CODEOWNERS):** Geliştirici "Buna kim bakabilir?" diye sormaz. Projedeki `CODEOWNERS` dosyası, değiştirilen dizine göre PR Reviewer atamasını matristeki Otoritelere (O) otomatik olarak yapar.
* **İç Mentörlük:** "Öğrenen (Ö)", o konunun "Uzmanı (U)" ile eşleştirilerek Pair Programming yapar.
* **Unvansız Liderlik:** Sadece 6 aylık tecrübesi olan bir geliştirici, ekibin geri kalanından daha çok araştırdığı spesifik bir aracın tek "Otoritesi" olabilir.

---

### 🚀 Sisteme Entegre Edilecek Kurulum Aksiyonları (To-Do)

* [ ] **CODEOWNERS Otomasyonu:** Repo kök dizininde (veya `.github/` altında) bir `CODEOWNERS` dosyası oluşturun. Matristeki Otoriteleri dosya yollarıyla eşleştirin.
*(Örnek: `src/db/** @ali` veya `src/app/** @ayse`)*
* [ ] **Şube Koruma Kuralları (Branch Protection):** GitHub/GitLab repo ayarlarında "Require review from Code Owners" (Kod sahiplerinden onay zorunluluğu) seçeneğini aktif edin.
* [ ] **Timeout Politikası İlinişi:** Ekip iletişim kanalında (Slack/Teams), "24 Saat Otorite Fallback" kuralını duyurun ve Otoriteye 24 saat içinde ulaşılamazsa ilgili Uzmanın (U) onayıyla PR'ın merge edilebileceği bilgisini sabitleyin.
# RACI Matrisi ve Roller

> **Bu doküman ne işe yarar?**
> Ekip içindeki görev ve yetki sınırlarını yoruma kapalı bir şekilde belirleyerek "bu benim işim değildi" veya "bana neden haber verilmedi" bahanelerini ortadan kaldırır. Bu doküman, [Karar Verme Yetkisi](./karar-verme-yetkisi.md) prensiplerinin günlük işlere uygulanmış pratik bir özetidir.

## 1. Rollerin Anlamları

* **R (Responsible - Sorumlu):** İşi fiilen yapan, kodu yazan, tasarımı çizen kişidir. Bir görevde birden fazla kişi "R" olabilir.
* **A (Accountable - Hesap Veren):** İşin doğru ve zamanında yapılmasından nihai sorumlu olan ve "R"nin işini onaylayan kişidir. Altın kural: Her görevde **sadece bir tane** "A" olmalıdır. (Detaylar için bkz: [Karar Verme Yetkisi](./karar-verme-yetkisi.md))
* **C (Consulted - Danışılan):** Karar almadan veya kodu yazmadan önce fikri alınan, uzmanlığına başvurulan kişidir (Çift yönlü iletişim).
* **I (Informed - Bilgilendirilen):** Karar alındıktan veya iş canlıya çıktıktan sonra sadece sonucun iletildiği kişidir (Tek yönlü iletişim).

## 2. Yazılım Ekibi İçin Örnek RACI Matrisi

| Süreç / Görev | Ürün Yöneticisi (PM) | Tech Lead / Senior | Geliştirici (Dev) | QA / Test Uzmanı | Müşteri / Paydaş |
| --- | --- | --- | --- | --- | --- |
| **[Müşteri Talebi (Triage) Analizi](./musteri-talep-rehberi.md)** | A, R | C | I | I | C |
| **[DoR Kriterlerini Hazırlamak](./dor.md)** | A, R | C | I | C | I |
| **Özelliği Geliştirmek (Kod Yazımı)** | I | A | R | I | I |
| **Code Review (Kod İnceleme) Yapmak** | I | A, R | C | I | I |
| **[Kalite Kontrol (Test) ve Onay (DoD)](./dod.md)** | I | C | I | A, R | I |
| **Canlıya Alma (Deployment)** | C | A, R | I | C | I |
| **[Yeni Mimari/Kütüphane Seçimi (ADR)](./karar-verme-yetkisi.md)** | I | A, R | C | I | I |

## 3. Uygulama Pratikleri

* **Çok Fazla "C" Kullanmayın:** Herkese danışmak sistemi yavaşlatır. Sadece o konuda gerçekten uzmanlığı olanları "C" yapın.
* **"A" ve "R" Aynı Kişi Olabilir:** Küçük görevlerde işi yapan (R) ile nihai sorumlu (A) aynı kişi olabilir (Örn: Tech Lead'in kendi kodunu canlıya alması).
* **Matrisi Şeffaflaştırın:** Bu tabloyu [Onboarding](./onboarding.md) (Oryantasyon) dokümanlarının en başına koyun. Yeni gelen kişi, bir test patladığında kime gideceğini (QA) veya mimari bir önerisi olduğunda kimi ikna edeceğini (Tech Lead) ilk günden bilsin.

