# ADR-0001: Paylaşımlı `staging` Ortamı Yerine Trunk-Based Development ve PR Preview

* **Tarih:** 2026-08-30
* **Karar Alıcılar:** Tech Lead, DevOps Otoritesi, QA Lead
* **Durum:** Kabul Edildi (Accepted)

## 2. Bağlam ve Problem (Context)

Geleneksel GitFlow ve paylaşımlı `staging` dalı modelinde, manuel Kalite Güvence (QA) testleri tek bir ortak ortam üzerinde yürütülmektedir. Bu durum iki yapısal darboğaz üretir:

* **Sıraya girme (queueing):** Aynı anda test edilmek isteyen birden fazla özellik `staging` ortamını sırayla kullanmak zorunda kalır. QA süresi, geliştirme süresinden bağımsız olarak Değişiklik Teslim Süresini (Lead Time) doğrudan uzatır.
* **Karşılıklı kirlenme (cross-contamination):** Paylaşımlı ortamda A özelliğinin hatası, B özelliğinin testini bloke eder. Hatanın hangi değişiklikten kaynaklandığı belirsizleşir.
* **Dal sapması (branch drift):** Uzun ömürlü `develop`/`staging` dalları ile `main` arasındaki fark büyüdükçe birleştirme (merge) çatışmaları ve "staging'de çalışıyordu" vakaları artar.

Bu karar alınmazsa, [Mühendislik Metrikleri](../process/engineering-metrics.md) dokümanında hedeflenen "Değişiklik Teslim Süresi < 1 gün" ve "Dağıtım Sıklığı: günde birden fazla" hedeflerine ulaşılması yapısal olarak mümkün değildir.

## 3. Değerlendirilen Seçenekler (Considered Options)

1. **GitFlow + paylaşımlı `staging` dalı (mevcut yaygın pratik):** Ekiplerin aşina olduğu, ek altyapı gerektirmeyen model. *Dezavantaj:* Yukarıda tanımlanan üç darboğazın tamamını barındırır; sürüm dalı bakımı sürekli efor gerektirir.
2. **Trunk-Based Development + PR başına izole Preview ortamı (seçilen):** Kısa ömürlü özellik dalları, `main`'in daima dağıtıma hazır tutulması ve her PR için otomatik oluşturulan geçici ortam. *Dezavantaj:* Preview altyapısı ve ortam başına maliyet gerektirir; veritabanı şema değişikliklerinde geriye dönük uyumluluk disiplini zorunlu hale gelir.
3. **Trunk-Based + tek paylaşımlı `staging` ortamı:** Dal sapması çözülür ancak sıraya girme ve karşılıklı kirlenme problemleri devam eder.

## 4. Alınan Karar (Decision)

* **Seçilen Çözüm:** Seçenek 2 — Gerçek Trunk-Based Development. Statik `staging` dalı kaldırılmıştır. Manuel QA doğrulaması, her PR için otomatik oluşturulan izole Preview URL'si üzerinden yürütülür.
* **Gerekçe:** Sıraya girme maliyeti, ekip büyüklüğüyle doğrusal değil çarpımsal artmaktadır; Preview ortamlarının altyapı maliyeti ise ortam başına sabit ve öngörülebilirdir. Seçenek 2, Lead Time hedefini yapısal olarak mümkün kılan tek alternatiftir. Seçenek 3, problemin yalnızca üçte birini çözdüğü için elenmiştir.
* **Zorunlu Eşlik Eden Kısıt:** Rollback kabiliyetinin korunabilmesi için veritabanı şeması daima bir önceki uygulama sürümüyle geriye dönük uyumlu olmalıdır. Bu nedenle **Expand-Contract** örüntüsü ve tek PR içinde `DROP`/`RENAME` yasağı bu kararın ayrılmaz parçasıdır.

## 5. Sonuçlar ve Etkiler (Consequences)

**Olumlu Etkiler**
* QA doğrulaması `main` dalını bloke etmez; paralel özellik geliştirme kapasitesi ekip büyüklüğüne oranlanır.
* Her PR izole ve tekrar üretilebilir bir ortamda test edilir; hata atfı netleşir.
* Kısa ömürlü dallar sayesinde birleştirme çatışmaları ve entegrasyon riski azalır.

**Olumsuz Etkiler / Kısıtlar**
* Preview ortamı başına altyapı maliyeti doğar; atıl ortamların periyodik temizliği gerekir (Bkz: [TODO](../../TODO.md) — FinOps).
* Veritabanı şema değişiklikleri artık tek adımda yapılamaz; Expand-Contract disiplini mühendislik ekibi için ek bilişsel yük oluşturur.
* Özellik bayrağı (feature flag) altyapısı zorunlu hale gelir: tamamlanmamış işin `main`'de bulunabilmesi buna bağlıdır.
* Preview ortamlarına üretim verisi kopyalanması kesin olarak yasaklanmalıdır (Bkz: [Test ve QA Stratejisi](../process/test-qa-strategy.md) §5).

## 6. Referanslar

* [CI/CD ve Dağıtım Stratejisi](../process/ci-cd-deployment.md) — bu kararın operasyonel uygulaması
* [Test ve Kalite Güvence Stratejisi](../process/test-qa-strategy.md) §4 — Preview ortamlarında QA akışı
* [Mühendislik Metrikleri](../process/engineering-metrics.md) — kararın doğrulanacağı DORA hedefleri

---
*Son Güncelleme: 2026-08-31 — Versiyon 1.0 — Doküman Sahibi: Tech Lead*
