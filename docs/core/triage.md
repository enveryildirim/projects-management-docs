# Müşteri Talebi Toplama ve Değerlendirme (Triage) Rehberi

> **Bu doküman ne işe yarar?**
> Müşteriden, satış ekibinden veya paydaşlardan gelen bir talebin ekibin önüne düşmeden önce geçeceği "güvenlik duvarını" tanımlar. Amacımız; ürünü "özel yazılım çöplüğüne" dönmekten kurtarmak ve geliştiricinin sadece doğrulanmış problemlere kod yazmasını sağlamaktır.

## 1. Temel Prensip: Çözüm Değil, Problem

**Müşteri çözümü değil, problemi tarif eder.**
Müşteri *"Şu ekrana bir buton ekleyin"* (Çözüm) der. Ancak görevimiz o butonun ardındaki gerçek ihtiyacı bulmaktır. Çözümü üretmek mühendislik ve tasarım ekibinin işidir. *"Müşteri daha hızlı bir at istedi, ona otomobil verdik."*

## 2. Talep Kabul Şartları (Satış ve Destek Ekipleri İçin)

Bir talebin değerlendirme (Triage) sürecine girebilmesi için, aşağıdaki formatın doldurulması zorunludur. *"Müşteriye söz verdik, acil buton ekleyelim"* şeklinde gelen talepler **hiçbir istisna yapılmaksızın (VIP dahil)** reddedilir.

* **Kullanıcı Sorunu:** Kullanıcı şu anda neyi yapamıyor? (Örn: "Toplu taburcu işlemi yapamıyor")
* **İş Etkisi (Impact):** Bu sorun çözülmezse ne kaybediyoruz? Zaman mı, para mı, müşteri mi?
* **Sıklık (Reach):** Bu sorunu kaç kullanıcı, ne sıklıkla yaşıyor?

## 3. Müşteri Görüşmesi Taktikleri (XY Problemi Çözümü)

* **Gemba Yürüyüşü (Gözlem):** Müşteriye "Nasıl yapıyorsunuz?" diye sormak yerine, *"Bana ekranınızı paylaşarak gösterir misiniz?"* deyin.
* **Sihirli Değnek Sorusu:** *"Süreçteki tek bir engeli yok etme hakkınız olsa bu ne olurdu?"*
* **Takas (Trade-off) Sunumu:** Mantıksız bir talepte reddetmek yerine maliyeti gösterin: *"Bunu eklersek veri giriş süreniz 3 saniye uzayacak, bu hızı düşürmez mi?"*
* **YASAKLAR:** Müşteriye UI detayı sorulmaz ("Dropdown mu olsun?"). Teknik implementasyon detayı (React, SQL) tartışılmaz. Efor analizi yapılmadan ASLA tarih sözü verilmez.

## 4. Triage Toplantısı ve Ampirik Filtreleme

Haftalık Triage toplantısında (PM, Tech Lead katılımıyla) talepler aşağıdaki skorlamaya ve mimari kurallara göre filtrelenir:

### 4.1 Matematiksel ve Mimari Filtreler

1. **Sınıflandırma:** (🚨 Kritik Bug, 🐛 Normal Bug, ✨ Yeni Özellik)
2. **ICE Skorlaması:** Talepler; *Impact* (Etki), *Confidence* (Veriye dayalı güven) ve *Ease* (Geliştirme kolaylığı) parametrelerine göre 1-10 arası puanlanır. Skoru düşük işler elenir.
3. **B2B SaaS "Özel Geliştirme" (Custom Code) Yasağı:** VIP bir müşteri sadece kendisine özel bir kural isterse, core koda müşteri ID'sine bağlı (Örn: `if (hospitalId === 123)`) şart blokları **eklenemez**. Çözüm genel kullanıma uygun tasarlanmıyorsa veya Webhook/API ile çözülemiyorsa reddedilir. Ürün bir "özel yazılım ajansı" değildir.

### 4.2 Triage Karar Çıktıları (Etiketler)

| Karar | Aksiyon ve Müşteri İletişimi |
| --- | --- |
| ❌ **Reddedildi (Drop)** | Ekibe gitmez. Gerekçeli ret yazılır: *"Ürün vizyonumuz bu süreçleri X ile çözmeyi hedefliyor, talebinizi planlarımıza dahil edemiyoruz."* |
| 🧊 **Buzdolabı (Icebox)** | **TTL Kuralı Geçerlidir:** Sorun mantıklı ama şu an öncelik değil. *Kural:* 3 ay içinde ICE skoru yükselmeyen veya başka müşterilerden talep almayan Icebox kartları sistemden **otomatik silinir/arşivlenir**. Backlog çöplük değildir. |
| ✅ **Kabul (To Refinement)** | Kök sorun çözülmeye değerdir. Talebin arayüzü ve teknik analizi yapılıp **Definition of Ready (DoR)** kriterlerine uygun bir karta dönüştürülür. Geliştirici sadece DoR'u karşılayan işi kodlar. |

## 5. Sık Sorulan Durumlar

**Satış Ekibi müşteriye özellik sözü vermişse ne olur?**
Ürün ve mühendislik ekibinin onayı (DoR) olmadan verilen sözler geçersizdir. Ürün yönetimi, bu talebi ICE skorlamasına sokar; eğer ürün vizyonuna uymuyorsa, satış ekibi durumu müşteriye açıklamakla yükümlüdür.

**Talep reddedildi ama müşteri tekrar getiriyor?**
Yeni bir veri (daha yüksek Impact/Reach) yoksa önceki karar korunur. Süreç, kimin daha çok ısrar ettiğine göre değil, verilere göre çalışır.

---

*Son güncelleme: 2026-08-29 — Versiyon 2.1 — Sahibi: Product Manager / Tech Lead*