# Olay Müdahale ve Post-Mortem Rehberi (Incident Response)

> **Bu doküman ne işe yarar?**
> Canlı sistem (Production) çöktüğünde veya veri ihlali yaşandığında paniği ve koordinasyonsuzluğu engeller. Kriz anındaki rolleri, iletişim kurallarını ve olay çözüldükten sonra yapılacak "Suçlamasız (Blameless) Post-Mortem" şablonunu belirler.

---

## 1. Olay Sınıflandırması (Severity Levels)

Her hata kriz değildir. Olayın şiddetine göre aksiyon alınır:

* **Sev-1 (Kritik Kesinti / Veri İhlali):** Sistem tamamen çöktü, ana iş akışları (örn: hasta kaydı, ödeme alma) çalışmıyor veya güvenlik/KVKK ihlali var. **Aksiyon:** İlgili herkes anında uyanır/işi bırakır, War Room (Savaş Odası) açılır.
* **Sev-2 (Kısmi Kesinti):** Sistemin önemli bir parçası çalışmıyor ama geçici bir çözüm (workaround) var veya kullanıcıların sadece küçük bir yüzdesi etkileniyor. **Aksiyon:** Sorumlu ekip aynı gün içinde müdahale eder.
* **Sev-3 (Minör Hata):** Fonksiyonel olmayan bir hata, yavaşlık veya yanlış UI. **Aksiyon:** Standart backlog'a `bug` olarak eklenir, mevcut sprint'i bölmez.

## 2. Kriz Anı Kuralları (Golden Rules of the War Room)

Sev-1 bir olay patlak verdiğinde (PagerDuty çaldığında) aşağıdaki 3 kural koşulsuz işletilir:

1. **Önce Kanamayı Durdur (Mitigation > Resolution):** Kriz anında kod refactor edilmez, kök neden aranmaz. Öncelik sistemi ayağa kaldırmaktır. Çözüm "önceki versiyona tek tuşla rollback yapmak" ise derhal yapılır (Bkz: `ci-cd-deployment.md`). Kök neden, sistem düzeldikten sonra aranır.
2. **Kahramanlık Yasaktır (No Solo Operations):** Kimse tek başına sunucuya bağlanıp (SSH) veya veritabanında doğrudan SQL çalıştırıp durumu kurtarmaya çalışamaz. Atılan her komut, War Room (Slack) kanalına yazılmalıdır.
3. **Koordineli İletişim:** Olay anında "Ne zaman düzelir?", "Ne oldu?" gibi sorularla mühendisleri darlamak yasaktır. İletişimi "Communicator" (İletişim Sorumlusu) yönetir.

## 3. Olay Rolleri

Bir Sev-1 anında Slack kanalında ilk katılanlar hızla şu rolleri paylaşır (Unvanlardan bağımsızdır):

* **Incident Commander (Olay Komutanı):** Operasyonu yönetir. Koda dokunmaz, log okumaz. Karar verir, yetkilendirme yapar ve tartışmaları sonlandırır. "Şimdi Rollback yapıyoruz" deme yetkisi ondadır.
* **Lead Resolver (Çözümcü):** Kodu, logları ve metrikleri inceleyen, terminal başında olan ana mühendistir.
* **Communicator (İletişim Sorumlusu):** Ürün veya Destek ekibinden biridir. Müşterilere, üst yönetime ve paydaşlara "Şu an sorunun farkındayız, müdahale ediyoruz" şeklinde periyodik güncellemeler (15-30 dakikada bir) geçer.

## 4. Suçlamasız (Blameless) Post-Mortem Şablonu

Kriz çözülüp kanama durdurulduktan sonra, **maksimum 48 saat içinde** Olay Komutanı aşağıdaki Post-Mortem belgesini oluşturur ve ekiple 30 dakikalık bir toplantı yapar.

> 💡 **Kural:** Post-Mortem'lerde isim kullanılmaz (Ali bozdu denmez). Hata yapan kişi değil; testlerin, CI/CD'nin ve mimarinin o hatanın canlıya çıkmasına *nasıl izin verdiği* sorgulanır. "Geliştirici dikkat etmeliydi" bir kök neden değildir; "Linter ve test kalkanı bu vakayı kapsayamadı" bir kök nedendir.

### 📝 Post-Mortem Formatı

**1. Özet (Context):**

* Tarih, Süre, Etkilenen Kullanıcı Oranı ve Finansal/Operasyonel Kayıp.
* Olay tek cümlede nedir? *(Örn: Veritabanı migration hatası nedeniyle API 45 dakika down oldu).*

**2. Olayın Zaman Çizelgesi (Timeline):**

* `14:00` - Sorun ilk kim/ne (Datadog, Müşteri) tarafından fark edildi?
* `14:05` - İlk kim müdahale etti?
* `14:20` - Rollback kararı alındı.
* `14:25` - Sistem tekrar stabil.

**3. Kök Neden Analizi (5 Whys):**

* *Neden sistem çöktü?* -> Hatalı SQL migration'ı canlıya çıktı.
* *Neden hatalı SQL canlıya çıktı?* -> Review sürecinde kimse o kolonu sildiğimizi fark etmedi.
* *Neden fark edilmedi?* -> CI/CD pipeline'ında DROP komutlarını engelleyen bir kural yoktu. (Expand-Contract kuralı ihlal edildi).
* *KÖK NEDEN:* Otomatize edilmiş yıkıcı migration engelleme sistemimizin olmaması.

**4. Aksiyon Maddeleri (Action Items):**
(Sadece "dikkat edeceğiz" demek yasaktır, kodu/süreci değiştirecek Jira taskları açılmalıdır).

* [ ] CI/CD botuna `DROP` ve `RENAME` tespit edildiğinde PR'ı bloke etme kuralı eklenecek. (Atanan: DevOps Ekibi)
* [ ] Kapatılan kolonlar için Expand-Contract stratejisi `ci-cd-deployment.md` içine kural olarak yazılacak. (Atanan: Tech Lead)

---

*Son güncelleme: 2026-08-29 — Sahibi: Engineering Manager / SRE*