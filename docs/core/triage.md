# Müşteri Talebi Toplama ve Değerlendirme (Triage) Prosedürü

> **Bu dokümanın amacı nedir?**
> Müşterilerden, satış ekiplerinden veya diğer paydaşlardan gelen taleplerin, mühendislik ekibine iletilmeden önce geçmesi gereken değerlendirme ve filtreleme süreçlerini tanımlamaktadır. Temel amacımız, ürünün mimari bütünlüğünü korumak ve mühendislik kaynaklarının yalnızca doğrulanmış problemlere odaklanmasını sağlamaktır.

## 1. Temel Prensip: Çözüm Odaklılık Yerine Problem Odaklılık

**Müşteriden beklenen, çözümü değil problemi tanımlamasıdır.**
Müşteriler genellikle çözüm önerileri ile (örneğin, "Şu ekrana bir buton ekleyin") gelirler. Ancak ekibimizin temel sorumluluğu, bu çözüm önerisinin ardında yatan gerçek iş ihtiyacını tespit etmektir. Uygun çözümün tasarlanması ve geliştirilmesi tamamen mühendislik ve tasarım ekiplerinin sorumluluğundadır.

## 2. Talep Kabul Kriterleri (Satış ve Destek Ekipleri İçin)

Bir talebin değerlendirme (Triage) sürecine dahil edilebilmesi için aşağıda belirtilen formatın eksiksiz doldurulması zorunludur. Gerekçelendirilmemiş veya aciliyet öne sürülerek iletilen talepler, **VIP müşteriler dahil olmak üzere hiçbir istisna yapılmaksızın** reddedilecektir.

* **Kullanıcı Problemi:** Kullanıcının mevcut durumda gerçekleştiremediği işlem nedir? (Örnek: "Toplu taburcu işlemi gerçekleştirilememektedir.")
* **İş Etkisi (Impact):** Bu problemin çözülmemesi durumunda oluşacak kayıp (zaman, finansal kaynak, müşteri memnuniyeti vb.) nedir?
* **Erişim ve Sıklık (Reach):** Bu problem kaç kullanıcı tarafından ve ne sıklıkla yaşanmaktadır?

## 3. Müşteri Görüşmesi Stratejileri (XY Problemi Çözümlemesi)

* **Saha Gözlemi (Gemba Yürüyüşü):** Müşteriye süreci nasıl yönettiğini sormak yerine, ekran paylaşımı aracılığıyla mevcut işleyişi bizzat göstermesi talep edilmelidir.
* **Kök Neden Analizi:** *"Süreçteki en büyük tekil engeli ortadan kaldırma imkanınız olsaydı, bu ne olurdu?"* yaklaşımıyla ana probleme odaklanılmalıdır.
* **Ödünleşim (Trade-off) Analizi:** Rasyonel olmayan talepleri doğrudan reddetmek yerine operasyonel maliyeti sunulmalıdır: *"Bu özelliğin eklenmesi veri giriş süresini uzatacaktır, bu durum operasyonel hızınızı olumsuz etkilemez mi?"*
* **Kısıtlamalar:** Müşterilerle arayüz detayları veya teknik implementasyon süreçleri kesinlikle tartışılmamalıdır. Efor ve kapasite analizi tamamlanmadan ASLA teslimat tarihi taahhüt edilmemelidir.

## 4. Triage Toplantısı ve Analitik Filtreleme Süreci

Haftalık olarak gerçekleştirilen Triage toplantılarında (Ürün Yöneticisi ve Teknik Lider katılımıyla), talepler aşağıdaki skorlama ve mimari standartlara göre filtrelenmektedir:

### 4.1 Matematiksel ve Mimari Filtreleme Standartları

1. **Sınıflandırma:** İletilen talep, [P0-P4 Önceliklendirme Çerçevesi](p0-p4-prioritization.md) kriterlerine göre sınıflandırılır (🚨 Kritik Hata/P0, 🐛 Standart Hata/P1-P2, ✨ Yeni Özellik/P3-P4).
2. **ICE Skorlama Metodolojisi:** Talepler; *Impact* (Etki), *Confidence* (Veriye dayalı güven) ve *Ease* (Uygulama kolaylığı) parametrelerine göre 1 ile 10 arasında değerlendirilir. Belirlenen barajın altında kalan talepler reddedilir.
3. **B2B SaaS "Özel Geliştirme" (Custom Code) Kısıtlaması:** Müşteriye özel (Örneğin: `if (hospitalId === 123)` şeklinde) mantıksal koşulların temel koda (core code) eklenmesi **kesinlikle yasaktır**. Çözüm, genel ürün vizyonuna uygun tasarlanamıyorsa veya Webhook/API mimarisiyle çözülemiyorsa reddedilecektir. Ürünümüz bir özel yazılım geliştirme platformu değildir.

### 4.2 Triage Karar Çıktıları ve Statüleri

| Karar | Aksiyon ve Müşteri İletişim Prosedürü |
| --- | --- |
| ❌ **Reddedildi (Drop)** | Talep mühendislik ekibine iletilmez. Profesyonel bir ret bildirimi iletilir: *"Ürün vizyonumuz bu süreçleri X metodolojisi ile çözmeyi hedeflemektedir; talebinizi mevcut planlarımıza dahil edemiyoruz."* |
| 🧊 **Beklemeye Alındı (Icebox)** | **TTL (Time-to-Live) Kuralı Geçerlidir:** Problem geçerlidir ancak mevcut öncelikler arasında yer almamaktadır. *Kural:* 3 ay içerisinde ICE skoru yükselmeyen veya ek talep almayan kartlar sistemden **otomatik olarak arşivlenir**. Backlog, biriktirme alanı olarak kullanılamaz. |
| ✅ **Kabul Edildi (To Refinement)** | Kök problem çözülmeye değer bulunmuştur. Talebin teknik ve arayüz analizi tamamlanarak **Definition of Ready (DoR)** kriterlerine uygun bir göreve dönüştürülür. Geliştirici yalnızca DoR kriterlerini sağlayan görevler üzerinde çalışır. İlgili görevin hangi metodoloji ile yürütüleceği **[Cynefin Çerçevesi](cynefin.md)** referans alınarak kararlaştırılır. |

## 5. Sık Karşılaşılan Durumlar ve İstisnai Süreçler

**Satış ekiplerinin müşteriye özellik taahhüdünde bulunması durumunda süreç nasıl işler?**
Ürün ve mühendislik ekiplerinin onayı (DoR süreci) olmaksızın verilen taahhütler geçersiz kabul edilir. Ürün yönetimi ilgili talebi ICE skorlamasına tabi tutar; ürün vizyonuyla örtüşmemesi halinde, durumun müşteriye izah edilmesi satış ekibinin sorumluluğundadır.

**Reddedilen bir talebin müşteri tarafından tekrar iletilmesi durumunda süreç nasıl işler?**
Talep edilen özelliğe ilişkin yeni bir analitik veri (daha yüksek Impact/Reach değerleri) sunulmadığı sürece önceki ret kararı geçerliliğini korur. Süreçlerimiz, taleplerin ısrar derecesine göre değil, veriye dayalı iş modellerine göre işletilmektedir.

---

*Son güncelleme: 2026-08-30 — Versiyon 2.1 — Sahibi: Ürün Yöneticisi (Product Manager) / Teknik Lider (Tech Lead)*