# Olay Müdahale ve Hata Sonrası İnceleme (Incident Response & Post-Mortem) Prosedürü

> **Bu dokümanın amacı nedir?**
> Canlı sistemlerde (Production) yaşanabilecek kesintiler veya veri ihlalleri durumunda kriz yönetimini standartlaştırmaktır. Bu prosedür, kriz anındaki görev dağılımlarını, iletişim protokollerini ve olay çözümlendikten sonra gerçekleştirilecek "Suçlamasız (Blameless) Post-Mortem" süreçlerini düzenler.

---

## 1. Olay Sınıflandırması (Severity Levels)

Her sistem uyarısı bir kriz olarak değerlendirilmez. Meydana gelen olayın şiddetine göre (Bkz: [P0-P4 Önceliklendirme Çerçevesi](p0-p4-prioritization.md)) aşağıdaki aksiyon planları devreye alınır:

* **Sev-1 / P0 (Kritik Kesinti / Veri İhlali):** Sistemin bütünüyle çökmesi, kritik iş akışlarının (örneğin hasta kayıt sistemleri veya tahsilat altyapısı) durması veya güvenlik/KVKK ihlali durumlarıdır. **Aksiyon Planı:** İlgili tüm personel mesai saati gözetmeksizin duruma müdahale eder ve derhal Kriz Masası (War Room) oluşturulur.
* **Sev-2 / P1 (Kısmi Kesinti):** Sistemin kritik bir modülünün işlevini yitirmesi, ancak alternatif bir sürecin (workaround) bulunması veya kullanıcı tabanının yalnızca belirli bir segmentinin etkilenmesi durumudur. **Aksiyon Planı:** Sorumlu mühendislik ekibi aynı iş günü içerisinde çözüm üretmekle mükelleftir.
* **Sev-3 / P2 (Minör Hata):** Temel fonksiyonları etkilemeyen performans sorunları, arayüz hataları veya minör pürüzlerdir. **Aksiyon Planı:** Standart ürün birikim listesine (backlog) hata (bug) olarak kaydedilir, aktif sprint döngüsünü kesintiye uğratmaz.

## 2. Kriz Yönetimi Kuralları (Golden Rules of the War Room)

Bir Sev-1 olayı meydana geldiğinde (uyarı sistemleri tetiklendiğinde), aşağıdaki kurallar tavizsiz olarak uygulanır:

1. **Öncelikli Olarak Sistemin Stabilizasyonu (Mitigation > Resolution):** Kriz anında kod mimarisi iyileştirilmez (refactor) veya kök neden analizi yapılmaz. Birinci öncelik sistemin operasyonel hale getirilmesidir. Eğer çözüm "önceki stabil sürüme geri dönmek (rollback)" ise, bu işlem derhal gerçekleştirilir. Kök neden analizi, sistem stabilizasyonu sağlandıktan sonra icra edilir.
2. **Bireysel İnisiyatif Kısıtlaması (No Solo Operations):** Hiçbir personel tek başına sunuculara bağlanarak (SSH) veya veritabanı üzerinde doğrudan komut çalıştırarak sisteme müdahale edemez. Uygulanan her işlem ve komut, Kriz Masası (Slack vb.) kanalında şeffaf bir şekilde belgelenmelidir.
3. **Koordineli İletişim Protokolü:** Olay anında müdahale ekiplerinden sürekli durum güncellemesi talep etmek operasyonu yavaşlatır. Tüm iletişim ve bilgilendirme süreçleri, atanmış olan "İletişim Sorumlusu (Communicator)" tarafından yürütülür.

## 3. Olay Müdahale Rolleri

Bir Sev-1 durumu oluştuğunda, kurumsal unvanlardan bağımsız olarak müdahale ekibi hızlıca aşağıdaki rolleri üstlenir:

* **Olay Komutanı (Incident Commander):** Kriz operasyonunu yönetir. Koda doğrudan müdahale etmez veya log analizi yapmaz. Durum değerlendirmesi yapar, görevlendirmeleri koordine eder ve kararları onaylar (Örneğin sürüm geri alma kararı). Nihai yetki bu roldedir.
* **Çözüm Yöneticisi (Lead Resolver):** Sistem loglarını, metrikleri ve kod yapısını inceleyen, teknik müdahaleyi gerçekleştiren baş mühendistir.
* **İletişim Sorumlusu (Communicator):** Genellikle Ürün veya Destek ekiplerinden bir profesyoneldir. Paydaşlara, üst yönetime ve müşterilere periyodik olarak (15-30 dakikada bir) durum güncellemelerini iletmekle yükümlüdür.

## 4. Suçlamasız İnceleme (Blameless Post-Mortem) Şablonu

Kriz kontrol altına alınıp sistem stabilize edildikten sonra, **en geç 48 saat içerisinde** Olay Komutanı aşağıdaki Post-Mortem raporunu hazırlar ve ilgili ekiplerle bir değerlendirme toplantısı düzenler.

> 💡 **Kurumsal Prensip:** İnceleme raporlarında kişi isimleri yer almaz. Odak noktası hatalı işlemi yapan birey değil; sistemin, test süreçlerinin veya CI/CD altyapısının bu hatanın canlı ortama geçmesine *nasıl izin verdiğidir*. "Personel daha dikkatli olmalıydı" kabul edilebilir bir kök neden değildir; "Test altyapısı bu senaryoyu kapsamamıştır" geçerli bir kök nedendir.

### 📝 Post-Mortem Rapor Formatı

**1. Yönetici Özeti (Context):**

* Olay tarihi, toplam kesinti süresi, etkilenen kullanıcı oranı ve tahmini operasyonel/finansal kayıp.
* Olayın teknik özeti. *(Örnek: Hatalı veritabanı şema güncellemesi (migration) sebebiyle API servisleri 45 dakika boyunca erişilemez duruma gelmiştir).*

**2. Zaman Çizelgesi (Timeline):**

* `14:00` - Kesinti izleme sistemleri (Örn: Datadog) tarafından tespit edildi.
* `14:05` - İlk müdahale ekibi Kriz Masasında toplandı.
* `14:20` - Sürüm geri alma (Rollback) kararı onaylandı ve uygulandı.
* `14:25` - Sistem metrikleri normale döndü.

**3. Kök Neden Analizi (5 Whys Metodolojisi):**

* *Sistem neden çöktü?* -> Hatalı SQL migration işlemi canlı ortama uygulandı.
* *Hatalı SQL neden canlı ortama geçti?* -> Kod inceleme (Review) sürecinde kritik bir kolonun silindiği tespit edilemedi.
* *Bu durum neden otomasyon tarafından tespit edilmedi?* -> CI/CD süreçlerinde DROP komutlarını engelleyen bir güvenlik kuralı bulunmuyordu.
* *KÖK NEDEN:* Yıkıcı veritabanı işlemlerini otomatik olarak engelleyecek sistemsel bir bariyerin eksikliği.

**4. Düzeltici ve Önleyici Faaliyetler (Action Items):**
(Sadece soyut taahhütler kabul edilmez, operasyonel süreçleri iyileştirecek somut görev kayıtları oluşturulmalıdır).

* [ ] CI/CD süreçlerine, `DROP` ve `RENAME` tespit edildiğinde süreci durduran güvenlik kuralı eklenecektir. (Sorumlu: DevOps Ekibi)
* [ ] Veritabanı şema değişiklikleri için "Genişlet-Daralt (Expand-Contract)" stratejisi ilgili dokümantasyonlara kural olarak eklenecektir. (Sorumlu: Teknik Lider)

---

*Son güncelleme: 2026-08-30 — Sahibi: Mühendislik Yöneticisi (Engineering Manager) / SRE*