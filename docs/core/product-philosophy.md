# Ürün Felsefesi ve Mühendislik Anayasası

> **Bu dokümanın amacı nedir?**
> Ekibimizin günlük operasyonlarında ve stratejik kararlarında esas aldığı temel prensipleri tanımlar. Yeni bir talep değerlendirilirken, özellik tasarlanırken veya bir talebin reddedilmesi gerektiğinde izlenecek metodolojiyi belirler. Karar Verme Yetkisi ve Müşteri Talebi Rehberi dokümanlarının temelini oluşturur ve tüm ekipler (ürün, mühendislik, operasyon) için bağlayıcıdır.

---

## 1. Temel İlke: Değer, Kullanım ile Yaratılır

Üretilen yazılım kodunun tek başına bir değeri yoktur; değer, kullanıcının problemi çözüldüğünde ve operasyonel fayda sağlandığında ortaya çıkar. Bu prensip operasyonlarımızı şu şekilde yönlendirir:

* "Bu geliştirmeyi tamamladık mı?" yerine, "Kullanıcılar bu özelliği aktif olarak kullanıyor mu ve operasyonel verimlilik sağlıyor mu?" sorusu esas alınır.
* Teknik açıdan kusursuz tasarlanmış ancak sahada kullanılmayan her özellik, kurumsal kaynakların israfı olarak değerlendirilir.
* Bir geliştirmenin "tamamlanmış" (Done) kabul edilmesi için yalnızca kodlanması yeterli değildir; kullanıcı tarafında hedeflenen etkiyi yaratması zorunludur (Bkz: Definition of Done - DoD dokümanı).
* **Hipotez ve Kademeli Sonlandırma Prensibi:** Geliştirilen her yeni özellik bir iş hipotezidir. Geliştirme sürecine başlanmadan önce başarı metrikleri açıkça tanımlanır (Örnek: "Yeni veri filtreleme modülünün devreye alınmasıyla destek taleplerinde %10 düşüş sağlanacaktır"). Canlıya alınma sonrasında belirlenen süre (varsayılan 30 gün) içerisinde bu hipotez verilerle doğrulanamazsa, özellik başarısız kabul edilir ve **kademeli sonlandırma (sunset) sürecine** alınır. Kullanılmayan kodun sistemden arındırılması, ürün sağlığının korunması için zaruri bir operasyondur.

  **Sonlandırma Akışı:** Kurumsal (B2B) ürünlerde canlı kullanımdaki bir modülün ihbarsız kaldırılması sözleşme ve güven riski taşır. Bu nedenle silme işlemi tek adımda değil, aşağıdaki sırayla yürütülür:

  | Aşama | Süre | Aksiyon |
  | --- | --- | --- |
  | **1. Kullanım Doğrulaması** | 30. gün | Telemetri verisiyle aktif kullanıcı sayısı tespit edilir. Aktif kullanım varsa hipotez yeniden değerlendirilir; süreç durdurulur. |
  | **2. Deprecate (Kullanımdan Kaldırma İlanı)** | 30.-60. gün | Özellik yeni kullanıcılara kapatılır, mevcut kullanıcılara arayüz üzerinden bilgilendirme ve alternatif akış sunulur. Etkilenen müşteriler varsa Ürün Yöneticisi tarafından bilgilendirilir. |
  | **3. Sunset (Devre Dışı Bırakma)** | 60.-90. gün | Özellik bayrağı (feature flag) kapatılır; kod tabanda kalır ancak erişilemez. Geri alınabilir aşamadır. |
  | **4. Kod ve Veri Arındırma** | 90. gün sonrası | Kod kaldırılır. İlgili veriler, [Veri Saklama Politikası](../process/security-and-compliance.md) uyarınca arşivlenir veya imha edilir; doğrudan `DROP` uygulanmaz (Bkz: [Expand-Contract](../process/ci-cd-deployment.md)). |

  Süreç bir [ADR](../process/adr-template.md) kaydıyla belgelenir. Regülasyona tabi projelerde (Bkz: [Profiller](./profiles.md)) 2. aşamada müşteri bildirimi **zorunludur**.

---

## 2. Kök Neden Odaklılık — "5 Neden" Metodolojisi

Müşteri talepleri veya sistem problemleri değerlendirilirken, yüzeysel semptomlar yerine problemin kök nedenine odaklanılır. Müşterilerden beklenen, çözümü değil yaşadıkları operasyonel zorluğu tanımlamalarıdır.

**Uygulama Prosedürü:**

1. İletilen problem veya talep detaylıca tanımlanır.
2. "Neden?" sorusu ardışık olarak (genellikle 3-5 iterasyon) sorularak problemin derinine inilir.
3. Kök neden tespit edildiğinde, geçici yamalar (workaround) yerine doğrudan kök nedeni ortadan kaldıracak kalıcı ve sürdürülebilir bir çözüm tasarlanır.

---

## 3. Ret Kültürü ve Analitik Geri Çevirme

İletilen her talebin onaylanması, ürün mimarisinin bozulmasına ve stratejik odağın kaybedilmesine yol açar. Ürün bütünlüğünü korumak, ürün yönetimi ve mühendislik ekiplerinin ortak kurumsal sorumluluğudur.

**Ret Kararı Alınması Gereken Durumlar:**

* Talebin, ürünün ana stratejik vizyonu veya hedef pazar segmenti ile çelişmesi.
* Talebin, kısıtlı bir kullanıcı grubunu etkileyen, genel mimariye entegre edilemeyen tek seferlik bir özellik (custom development) olması.
* İlgili geliştirmenin getireceği operasyonel faydanın, yaratacağı teknik borç ve mimari karmaşıklıkla orantısız olması.

**Ret İletişim Stratejisi (Fırsat Maliyeti):**

* Ret kararları kişisel veya duygusal argümanlara değil, kurumsal **Fırsat Maliyeti (Opportunity Cost)** analizlerine dayandırılır: *"Bu talebin gerçekleştirilmesi, stratejik yol haritamızdaki X inisiyatifinden 2 haftalık kaynak aktarımını gerektirecektir. Bu kaynak tahsisi kurumsal hedeflerimizle örtüşmemektedir."*
* Kararlar şeffaf bir şekilde gerekçelendirilir ve mümkünse alternatif iş akışları önerilir. Ret kararı, müşteri reddi değil, ürün standartlarının ve operasyonel verimliliğin korunması eylemidir.

---

## 4. Mimari Sadelik ve Geliştirme Esnekliği

* Aynı iş problemini çözen iki alternatif arasında, her zaman mimari olarak daha sade olan tercih edilir. Kod karmaşıklığı, varsayımsal gelecek senaryoları için değil, yalnızca kesin olarak doğrulanmış mevcut ihtiyaçlar doğrultusunda artırılır (YAGNI — "You Aren't Gonna Need It").
* **Mimari Esneklik (Architectural Runway):** Sadelik prensibi, ürün mimarisinin dar kapsamlı tasarlanması anlamına gelmez. İş kuralları (business logic) için geçerli olan YAGNI prensibi, sistemin temel mimari bileşenlerinde (arayüzler, modüler yapılar) gelecekteki olası ölçeklenmeleri destekleyecek esneklikte yapılandırılır. En ideal çözüm, gelecekteki iş gereksinimlerine en düşük mühendislik maliyetiyle uyum sağlayabilen çözümdür.

---

## 5. Kalite Güvencesi Sistematiği

Kalite, yazılım geliştirme yaşam döngüsünün sonuna eklenen bir denetim aşaması değil, üretim sürecinin her katmanına entegre edilmiş bir kurumsal standarttır. Kalite denetimlerinin ertelenmesi, hataların en yüksek maliyetle (canlı ortamda) tespit edilmesine neden olur.

* **Üretim Safhasında:** Birim ve entegrasyon testleri kodlama süreciyle eşzamanlı yürütülür (Bkz: [Test Stratejisi](../process/test-qa-strategy.md)). Kod incelemeleri (Code Review) salt fonksiyonelliği değil, sürdürülebilirlik ve kurumsal standartlara uyumu denetler. Gereksinimlerde belirsizlik saptanması durumunda geliştirme faaliyeti derhal durdurulur.
* **Canlı Ortamda:** Üretim (production) ortamı kapsamlı telemetri araçlarıyla sürekli monitör edilir. Teknik borçların kuruma maliyeti zamanla katlanarak artar. Meydana gelen hatalar, suçlamasız (blameless) post-mortem süreçleriyle analiz edilir.
* **Kalitenin Mülkiyeti:** Kalite güvencesi yalnızca test mühendislerinin (QA) değil, kodu üreten tüm ekibin ortak sorumluluğundadır. "Test ekibi nasılsa bulur" zihniyeti kesinlikle reddedilir.
* **Hız ve Kalite Dengesi:** Sürdürülebilir üretim hızı, kalite kontrollerinin atlanmasıyla değil, kalitenin üretim sürecinin başına çekilmesiyle (Shift-Left) sağlanır. Kısa vadeli çözümler (hack), uzun vadede kurumsal operasyonların durmasına sebebiyet verir.

---

## 6. Operasyonel Dayanıklılık ve Ekip Sözleşmeleri

Ürün felsefesini iç ve dış operasyonel risklere karşı koruyan yapısal standartlarımız aşağıdadır:

### 6.1 Kaynak Tahsisi Sözleşmesi (Resource Allocation)

Mühendislik ekiplerinin mesai kapasitesi yalnızca yeni özellik geliştirmeye tahsis edilemez. Bu tahsisin fiilen uygulanıp uygulanmadığı [Mühendislik Metrikleri](../process/engineering-metrics.md) §2 kapsamında ölçülür. Ürünün uzun vadeli mimari sağlığını korumak adına, her sprint döngüsünde toplam kapasitenin **%20'si teknik borçların eritilmesine ve mimari iyileştirmelere**, **%10'u ise AR-GE ve inovasyon faaliyetlerine** ayrılır. İş birimleri bu %30'luk altyapı koruma bütçesine müdahale edemez. Teknik borç ödemesi bir seçenek değil, sistem sürdürülebilirliğinin zorunlu vergisidir.

### 6.2 Kurumsal Mülkiyet ve Bilgi Silolarının Engellenmesi (Anti-Hero Culture)

Sistemi kriz anlarında tek başına kurtaran veya projeyi teslim etmek için sürekli fazla mesai yapan "kahraman geliştirici" kültürü kurumumuzda reddedilir. Bu durum, operasyonel süreçlerin yetersizliğinin bir göstergesidir. Bir modülün veya sistemin bilgisinin yalnızca tek bir personelin tekelinde olması, ciddi bir kurumsal risktir. Kodun mülkiyeti bireylere değil, kuruma ve ekibe aittir. Kod incelemeleri (Code review), sadece hata tespiti için değil, teknik bilginin kurum geneline yayılması (knowledge sharing) amacıyla gerçekleştirilir.

### 6.3 Üçüncü Parti Bağımlılıkların Yönetimi (Graceful Degradation)

Sistem kesintilerinde suçu üçüncü parti entegrasyonlara (Örneğin: "Ödeme altyapısı sağlayıcısı çöktü") atmak profesyonel bir yaklaşım değildir. Dış sistemlerin doğası gereği hata verebileceği varsayımıyla mimari tasarlanır. Mühendislik ekipleri, harici bağımlılıklarda yaşanacak kesintilerde uygulamanın tamamen çökmesini engellemek ve kullanıcılara kontrollü, kısıtlı bir deneyim sunmakla (Graceful Degradation) yükümlüdür. Son kullanıcı deneyiminin sorumluluğu bütünüyle kurumumuza aittir.

---

## 7. Kurumsal Şeffaflık ve Geri Bildirim Mekanizmaları

* Mimari ve stratejik kararların teknik ve ticari gerekçeleri mutlaka yazılı olarak kayıt altına alınır (ADR, PR açıklamaları, bilet logları). Kararların ardındaki kurumsal hafıza korunmalıdır.
* Operasyonel hatalar gizlenmez, şeffaflıkla paylaşılır ve edinilen kurumsal tecrübe ilgili platformlarda belgelenir.
* Geri bildirimler (feedback) daima kişilerden bağımsız, süreç ve iş kalitesine odaklı olarak verilir.

---

*Son güncelleme: 2026-08-30 — Versiyon 2.0 — Sahibi: Teknik Lider (Tech Lead) / Mühendislik Yöneticisi (Engineering Manager)*
