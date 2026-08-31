# RACI Matrisi ve Roller

> **Bu Dokümanın Amacı**
> Ekip içerisindeki görev, yetki ve sorumluluk sınırlarını yoruma mahal vermeyecek netlikte belirleyerek süreç verimliliğini artırmayı hedefler. Bu doküman, [Karar Verme Yetkisi](./decision-making-authority.md) prensiplerinin operasyonel süreçlere uygulanmış pratik bir özetidir. Teknik alan bazlı karar mercileri için bkz: [Yetkinlik Matrisi](./competency-matrix.md).

## 1. Rollerin Tanımları

* **R (Responsible - Sorumlu):** İlgili görevi fiilen icra eden, kodu geliştiren veya tasarımı oluşturan kişidir. Bir görev kapsamında birden fazla "R" atanabilir.
* **A (Accountable - Hesap Veren):** İşin doğru standartlarda ve zamanında tamamlanmasından nihai olarak sorumlu olan ve "R"nin çıktılarını onaylayan kişidir. Altın kural: Her görevde **yalnızca bir adet** "A" bulunmalıdır. (Detaylı bilgi için bkz: [Karar Verme Yetkisi](./decision-making-authority.md))
* **C (Consulted - Danışılan):** Karar alma aşamasından veya geliştirme sürecinden önce uzmanlık görüşüne başvurulan kişidir (Çift yönlü iletişim gerektirir).
* **I (Informed - Bilgilendirilen):** Karar alındıktan veya ilgili iş canlı ortama aktarıldıktan sonra sonuç hakkında bilgi verilen kişidir (Tek yönlü iletişim gerektirir).

## 2. Yazılım Ekibi İçin Örnek RACI Matrisi

| Süreç / Görev | Ürün Yöneticisi (PM) | Tech Lead / Senior | Geliştirici (Dev) | QA / Test Uzmanı | Müşteri / Paydaş |
| --- | --- | --- | --- | --- | --- |
| **[Müşteri Talebi (Triage) Analizi](../core/triage.md)** | A, R | C | I | I | C |
| **[DoR Kriterlerini Hazırlamak](../core/dor.md)** | A, R | C | I | C | I |
| **Özelliği Geliştirmek (Kod Yazımı)** | I | A | R | I | I |
| **Kod İncelemesi (Code Review) Yapmak** | I | A, R | C | I | I |
| **[Kalite Kontrol (Test) ve Onay (DoD)](../core/dod.md)** | I | C | I | A, R | I |
| **Canlı Ortama Alma (Deployment)** | C | A, R | I | C | I |
| **[Yeni Mimari/Kütüphane Seçimi (ADR)](./decision-making-authority.md)** | I | A, R | C | I | I |

## 3. Uygulama Pratikleri

* **"C" Rolünün Optimizasyonu:** Süreçlerde çok fazla kişiye danışmak karar alma mekanizmasını yavaşlatabilir. Yalnızca ilgili konuda derin uzmanlığı bulunan kişiler "C" olarak konumlandırılmalıdır.
* **"A" ve "R" Rollerinin Konsolidasyonu:** Kapsamı dar görevlerde işi icra eden (R) ile nihai sorumlu (A) aynı kişi olabilir (Örneğin: Tech Lead unvanlı personelin kendi geliştirdiği kodu canlı ortama aktarması).
* **Matrisin Şeffaflaştırılması:** Bu tablonun, [Oryantasyon](./onboarding-and-setup.md) dokümanlarının ilk bölümünde yer alması zorunludur. Böylece yeni katılan ekip üyeleri, süreç aksaklıklarında ulaşmaları gereken kişileri (QA) veya mimari önerilerde ikna etmeleri gereken mercileri (Tech Lead) ilk günden itibaren net bir şekilde bileceklerdir.

---

*Son Güncelleme: 2026-08-31 — Versiyon 1.1 — Doküman Sahibi: Engineering Manager / Tech Lead*
