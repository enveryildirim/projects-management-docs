# Ürün Felsefesi ve Mühendislik Anayasası

> **Bu doküman ne işe yarar?**
> Ekibin günlük kararlarını hangi ilkelere göre aldığını tanımlar — bir talep geldiğinde, bir özellik tasarlanırken, bir "hayır" denmesi gerektiğinde nasıl düşünüleceğini anlatır. Karar Verme Yetkisi ve Müşteri Talebi Rehberi dokümanlarının *dayandığı temel* budur. Tüm ekip (ürün, mühendislik, destek) için geçerlidir.

---

## 1. Temel İlke: Değeri Yaratan Koddan Ziyade Kullanımdır

Yazdığımız kod kendi başına değer taşımaz — kullanıcı onu kullanıp bir problemini çözdüğünde değer oluşur. Bu, günlük kararları şöyle yönlendirir:

* "Bunu yazdık mı?" değil, "kullanıcı bunu kullanıyor mu, işine yarıyor mu?" sorusu sorulur.
* Teknik olarak kusursuz ama kimsenin kullanmadığı bir özellik, başarısızlıktır.
* Bir özelliği bitirmek "done" değildir; kullanıcıda beklenen etkiyi yaratması "done"dır (bkz. DoD dokümanı).
* **Hipotez ve Silme Kuralı:** Her yeni özellik bir *hipotezdir*. Geliştirmeye başlamadan önce başarı metriği tanımlanır (Örn: "Bu filtreyi eklersek, destek biletleri %10 azalacak"). Özellik canlıya alındıktan sonra belirtilen süre içinde (örn. 30 gün) metrikler bu hipotezi doğrulamazsa, o kod başarısız kabul edilir ve **sistemden silinir**. Kod silmek, ürünün sağlığını koruyan erdemli bir eylemdir.

---

## 2. Kök Neden Odaklılık — "5 Neden" Kuralı

Bir problem/talep geldiğinde, yüzeydeki semptomla değil kök nedenle ilgilenilir. Müşteri çözümü değil, problemi tarif etmelidir.

**Uygulama:**

1. Sorun/talep tarif edilir.
2. "Neden?" sorusu art arda sorulur (genelde 3-5 kez), her cevap bir öncekinin nedenini açıklar.
3. Kök nedene ulaşıldığında, çözüm oraya göre tasarlanır — semptomu geçici olarak kapatan yama değil.

---

## 3. Hayır Deme Kültürü ve Ampirik Reddetme

Her talebe evet demek, ürünü yavaş yavaş dağıtır ve odağını kaybettirir. Ürünü korumak, mühendislik ve ürün ekibinin ortak sorumluluğudur.

**Ne zaman hayır denir:**

* Talep, ürünün temel yönü/hedef kullanıcısıyla çelişiyorsa.
* Talep, çok az kullanıcıyı etkileyen tek seferlik bir istekse ve genel bir çözüme genellenemiyorsa.
* Talep, teknik borç veya karmaşıklığı orantısız artıracaksa.

**Nasıl hayır denir (Fırsat Maliyeti):**

* Hayır derken duygusal veya kişisel argümanlar kullanılmaz. Reddetme kararı **Fırsat Maliyeti (Opportunity Cost)** üzerinden verilir: *"Bunu yaparsak, roadmaptaki X vizyonundan 2 hafta feragat etmiş olacağız. Bu takas, şirket hedeflerine hizmet etmiyor."*
* Sessiz reddetme yapılmaz, alternatif önerilir. Hayır, kişisel bir red değil, ürün bütünlüğünü koruma kararı olarak çerçevelenir.

---

## 4. Basitlik ve Mimari Uçuş Pisti

* İki çözüm aynı problemi çözüyorsa, daha basit olan tercih edilir. Karmaşıklık, gelecekte "belki gerekir" diye değil, şu an kanıtlanmış bir ihtiyaç için eklenir (YAGNI — "You Aren't Gonna Need It").
* **Mimari Uçuş Pisti (Architectural Runway):** Basitlik, mimariyi köşeye sıkıştırmak demek değildir (Naif Basitlik). YAGNI kuralı iş mantığı (business logic) için geçerlidir; ancak kodun mimari sınırları (interface'ler, modülerlik), yarın değişebilecekmiş gibi esnek tasarlanmalıdır. En basit çözüm, gelecekteki değişiklikleri en az maliyetle destekleyebilen çözümdür.

---

## 5. Kalite — Nasıl Elde Edilir, Nasıl Korunur?

Kalite, sona eklenen bir kontrol adımı değil, sürecin her adımına gömülü bir alışkanlıktır. "Sonra düzeltiriz" mantığı, kaliteyi maliyeti en yüksek noktada (canlı ortamda) yakalamak demektir.

* **Üretim Aşamasında:** Test, kod ile birlikte yazılır. Code review "çalışıyor mu" sorusunu değil "sürdürülebilir mi" sorusunu sorar. Belirsizlik varsa kod yazımı durdurulur.
* **Yayın Sonrasında:** Canlı ortam telemetri ile izlenir. Ertelenen teknik borç faiziyle döner. Hatalar post-mortem ile incelenir.
* **Kalitenin Sahipliği:** Kalite QA'in değil, kodu yazan herkesin sorumluluğudur. "Test bulur nasılsa" mantığı kaliteyi üretimden tüketime kaydırır.
* **Hız ve Kalite Çelişkisi:** Sürdürülebilir hız, kaliteyi atlayarak değil, kaliteyi sürece gömerek elde edilir (Shift-Left). Kısa vadeli hack'ler, uzun vadede sistemin durmasına yol açar.

---

## 6. Operasyonel Dayanıklılık ve Takım Sözleşmeleri

Bu felsefeyi dış baskılara ve iç sürtünmelere karşı koruyan yapısal kurallarımızdır:

### 6.1 Kapasite Dağılımı Sözleşmesi (Resource Allocation)

Mühendislik zamanı sadece yeni özellik geliştirmek için kullanılamaz. Ürünün uzun vadeli sağlığını korumak için, her sprint/döngü kapasitesinin **%20'si teknik borç ödemeye ve mimari iyileştirmelere**, **%10'u ise deneysel inovasyonlara** ayrılır. İş birimi bu %30'luk "motoru çalışır tutma" payına dokunamaz. Teknik borç bir backlog maddesi değil, ürünün vergisidir ve peşin ödenir.

### 6.2 "Kahramanlık" Karşıtlığı ve Ortak Mülkiyet (Anti-Hero Culture)

Sistemi gece yarısı tek başına kurtaran veya projeyi yetiştirmek için sürekli mesai yapan 'kahraman' geliştirici kültürü reddedilir. Kahramanlık, sürecin (process) çöktüğünün semptomudur. Bir modül sadece tek bir kişinin zihnindeyse o modül "tamamlanmamıştır". Kodun mülkiyeti bireylere değil takıma aittir; Code Review'lar salt onay için değil, bilgi dağıtımı (knowledge sharing) ve siloları yıkmak için yapılır.

### 6.3 Üçüncü Parti Sistemlerde Mülkiyet (Graceful Degradation)

Uygulama çöktüğünde "Ödeme API'si hata verdi, bizim suçumuz değil" argümanı geçersizdir. Dış sistemlerin başarısız olacağı baştan varsayılır. Mühendislik ekibi, dış bağımlılıklar koptuğunda uygulamanın tamamen çökmesi yerine kullanıcıya anlamlı bir kısıtlı deneyim (Graceful Degradation) sunmakla sorumludur. Kullanıcı deneyiminin nihai sorumluluğu bizdedir.

---

## 7. Şeffaflık ve Geri Bildirim

* Bir kararın gerekçesi her zaman yazılı hale getirilir (ADR, PR açıklaması, talep kayıt notu) — "neden böyle yaptık" sorusu 6 ay sonra da cevaplanabilmeli.
* Hata yapıldığında saklanmaz, açıkça paylaşılır ve öğrenilen ders kayda geçirilir (post-mortem kültürü).
* Geri bildirim kişiye değil, doğrudan işe yöneliktir.

---

*Son güncelleme: 2026-08-29 — Versiyon 2.0 — Sahibi: Tech Lead / Engineering Manager*
