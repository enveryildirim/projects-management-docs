# Mühendislik Metrikleri ve Telemetri

> **Bu doküman ne işe yarar?**
> Playbook'taki kuralların (AI Manifesto, DoR/DoD, CI/CD) takıma sağladığı faydayı objektif olarak ölçmek için takip ettiğimiz "Kuzey Yıldızı" metriklerini tanımlar.

## 1. DORA Metrikleri (Sistem Hızı ve Stabilitesi)

Google DevOps Araştırmaları'na (DORA) dayanan bu 4 metrik, ekibin performansını ölçen ana pusulamızdır. Otomatik olarak CI/CD pipeline'ından toplanır.

| Metrik | Tanım | Hedef (Elite Seviye) | Bize Ne Söyler? |
| --- | --- | --- | --- |
| **Değişiklik Teslim Süresi (Lead Time)** | İlk commit'ten kodun canlıya (production) çıkmasına kadar geçen süre. | 1 Günden Az | DoR ve Code Review süreçlerinde (PR bekleme süresi) darboğaz olup olmadığını. |
| **Dağıtım Sıklığı (Deploy Freq.)** | Canlı ortama ne sıklıkla kod gönderildiği. | Günde Birden Fazla | CI/CD otomasyonunun ve trunk-based development'ın çalışıp çalışmadığını. |
| **Değişiklik Hata Oranı (CFR)** | Canlıya çıkan kodların yüzde kaçının hata (rollback/hotfix) yarattığı. | %0 - %15 Arası | DoD kriterleri ve test (QA) stratejimizin ne kadar sağlam olduğunu. |
| **Hizmeti Geri Yükleme (MTTR)** | Canlı ortam çöktüğünde sistemi tekrar ayağa kaldırma süresi. | 1 Saatten Az | Geri alma (Rollback) otomasyonu ve Post-Mortem kültürümüzün kalitesini. |

## 2. Playbook Sağlık (Operasyonel) Metrikleri

DORA metriklerini destekleyen, iç süreçlerimizin verimliliğini gösteren tamamlayıcı metrikler:

* **Triage Red Oranı (Drop Rate):** Triage toplantısında reddedilen veya Icebox'a atılan müşteri talebi oranı. (Bu oran çok düşükse, 'Hayır Deme Kültürü' işlemiyor demektir).
* **PR Gözden Geçirme Süresi (Review Cycle Time):** Bir PR'ın açılması ile onaylanması arasında geçen süre. SLA hedefimiz: **Maksimum 24 Saat**. Uzarsa, iletişim matrisindeki "24 Saat Otorite Fallback" kuralı ihlal ediliyor demektir.
* **AI Kaynaklı Hata Oranı (AI Defect Rate):** Canlıda tespit edilen hataların ne kadarının AI tarafından üretilen (Prompt-as-Code) kompleks mantıklardan kaynaklandığı. (AI Manifestosunun çalışıp çalışmadığını ölçer).
* **Teknik Borç Kapasitesi:** Her sprint'in %20'sinin refactor ve teknik borç ödemeye ayrılıp ayrılmadığının Jira/Linear üzerinden (Issue Types) takibi.

## 3. Anti-Metrikler (Kesinlikle Ölçülmeyecekler)

Takım kültürünü (ortak mülkiyeti) zehirleyen ve Goodhart Yasası'nı tetikleyen aşağıdaki metriklerin ölçülmesi ve performans değerlendirmesinde kullanılması **kesinlikle yasaktır**:

* **Kişisel Hız (Individual Velocity):** Story Point'ler takımın kapasite planlaması içindir, bireyleri birbiriyle yarıştırmak (Ali 10 puan yaptı, Ayşe 5) için kullanılamaz. Bu durum Pair Programming'i öldürür.
* **Yazılan Satır Sayısı (LoC):** Kod yazmak değil, problem çözmek değerlidir (Ürün Felsefesi Bölüm 1). Gerekirse 1000 satır kodu silip yerine 10 satır yazan geliştirici en yüksek değeri üretmiştir.
* **Commit Sayısı:** Bilişsel eforu yansıtmaz, sistemi yapay commit'lerle (Örn: `fix typo`) şişirmeye yol açar.

---

*Son güncelleme: 2026-08-29 — Versiyon 1.0 — Sahibi: Engineering Manager*
