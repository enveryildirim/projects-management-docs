# Mühendislik Metrikleri ve Telemetri Standartları

> **Bu dokümanın amacı nedir?**
> Bu belge, kurumsal prensiplerimizin (AI Manifesto, DoR/DoD, CI/CD) yazılım geliştirme ekiplerimize sağladığı verimliliği objektif olarak ölçmek amacıyla takip ettiğimiz temel performans göstergelerini ("Kuzey Yıldızı" metrikleri) tanımlamaktadır.

## 1. DORA Metrikleri (Sistem Hızı ve Kararlılığı)

Google DevOps Araştırmaları'na (DORA) dayanan bu dört temel metrik, mühendislik ekiplerimizin performansını ölçümlediğimiz ana göstergelerdir. Bu veriler CI/CD süreçlerinden otomatik olarak derlenmektedir.

| Metrik | Tanım | Hedeflenen Performans (Elit Seviye) | Ölçümlediği Boyut |
| --- | --- | --- | --- |
| **Değişiklik Teslim Süresi (Lead Time for Changes)** | Bir kod taahhüdünün (commit) üretim ortamına (production) ulaşmasına kadar geçen toplam süre. | < 1 Gün | DoR (Definition of Ready) ve Kod İnceleme (Code Review) süreçlerindeki olası darboğazlar. |
| **Dağıtım Sıklığı (Deployment Frequency)** | Üretim ortamına gerçekleştirilen başarılı dağıtım sıklığı. | Günde Birden Fazla | CI/CD otomasyon verimliliği ve trunk-based development pratiklerinin etkinliği. |
| **Değişiklik Başarısızlık Oranı (Change Failure Rate - CFR)** | Üretim ortamına aktarılan güncellemelerin hata (rollback/hotfix gerektiren) yaratma oranı. | %0 - %15 Arası | DoD (Definition of Done) kriterleri ve QA stratejimizin güvenilirliği. |
| **Hizmet Kurtarma Süresi (Mean Time to Restore - MTTR)** | Üretim ortamında yaşanan bir kesintinin ardından sistemin yeniden tam operasyonel hale gelme süresi. | < 1 Saat | Sürüm geri alma (Rollback) otomasyonunun ve Post-Mortem kültürümüzün kalitesi. |

## 2. Operasyonel Sağlık Metrikleri

DORA metriklerini destekleyen ve iç süreçlerimizin operasyonel verimliliğini yansıtan tamamlayıcı performans göstergelerimiz şunlardır:

* **Triage İptal Oranı (Drop Rate):** Triage toplantıları neticesinde reddedilen veya bekleme listesine (Icebox) alınan taleplerin oranı. Bu oranın çok düşük olması, organizasyonun odaklanma ve önceliklendirme stratejilerinde zafiyet olduğuna işaret eder.
* **PR İnceleme Süresi (Review Cycle Time):** Bir PR'ın oluşturulması ile nihai onay alması arasında geçen süre. SLA hedefimiz: **Maksimum 24 Saat**. Bu sürenin aşılması, yetki ve karar alma mekanizmalarında tanımlanan eskalasyon kurallarının ihlal edildiğini gösterir.
* **Yapay Zeka Kaynaklı Hata Oranı (AI Defect Rate):** Üretim ortamında tespit edilen hataların ne kadarının AI asistanları (Prompt-as-Code vs.) tarafından üretilen karmaşık mantıklardan kaynaklandığının oranı. Bu metrik, yapay zeka entegrasyon kurallarımızın (AI Manifesto) etkinliğini ölçer.
* **Teknik Borç Yönetim Kapasitesi:** Her sprint döngüsünün %20'lik diliminin kod iyileştirmelerine (refactoring) ve teknik borç ödemelerine ayrılıp ayrılmadığının proje yönetim araçları (Jira/Linear vb.) üzerinden takibi.

## 3. İzlenmemesi Gereken Metrikler (Anti-Metrikler)

Takım kültürüne zarar veren, ortak mülkiyet (collective ownership) bilincini zedeleyen ve Goodhart Yasası'nı tetikleme riski barındıran aşağıdaki metriklerin ölçülmesi ve bireysel performans değerlendirmelerinde kullanılması **kesinlikle yasaktır**:

* **Bireysel Hız (Individual Velocity):** Story Point'ler efor ve takımın genel kapasite planlaması için kullanılmalıdır. Bireysel karşılaştırmalar yapmak amacıyla kullanılması Eşli Programlama (Pair Programming) dinamiklerine zarar verir.
* **Yazılan Satır Sayısı (Lines of Code - LoC):** Organizasyonumuzda değer, yazılan kod satırıyla değil, çözülen problemin niteliğiyle ölçülür. Gerektiğinde karmaşık yapıları sadeleştirerek kod tabanını küçülten mühendislik yaklaşımları en yüksek değeri temsil eder.
* **Taahhüt (Commit) Sayısı:** Bilişsel eforu yansıtmayan bir metriktir. Geliştiricileri sistemi yapay commit'lerle (Örn: basit yazım düzeltmeleri) şişirmeye teşvik edebilir.

---

*Son Güncelleme: 2026-08-30 — Versiyon 1.1 — Doküman Sahibi: Engineering Manager*
