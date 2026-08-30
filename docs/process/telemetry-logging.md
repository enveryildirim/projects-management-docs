# Telemetri ve Loglama Standartları

> **Bu dokümanın amacı nedir?**
> Üretim (production) sistemlerimizin sağlığını izlemek, olası kesintilerin kök nedenlerini hızlı ve isabetli bir şekilde tespit etmek ve uygulama kullanım metriklerini güvenli bir biçimde takip edebilmek için log ve telemetri kayıtlarının oluşturulma standartlarını belirler.

---

## 1. Temel Prensip: Kişisel Sağlık ve Kimlik Verilerinin (PHI/PII) Maskelenmesi

Kullanıcıların veya hastaların gerçek isimleri, T.C. Kimlik Numaraları, parolaları, finansal bilgileri (kredi kartı vb.) veya hassas tıbbi verileri **HİÇBİR DURUMDA** log kayıtlarına düz metin olarak aktarılamaz.

- *Hatalı Kullanım:* `Kullanıcı kaydedildi: Ahmet Yılmaz, TC: 12345678901, Teşhis: Kanser`
- *Doğru Kullanım:* `Kullanıcı kaydı başarılı. UserID: usr_8f72a, Action: patient_register_success`

Kritik veriler, loglama sistemine iletilmeden önce mutlaka standart veri maskeleme (data masking) kütüphanelerinden geçirilerek anonimleştirilmelidir.

## 2. Log Seviyelerinin (Log Levels) Sınıflandırılması

Uygulamanın ürettiği loglar, operasyonel müdahale ve filtreleme süreçlerini optimize etmek amacıyla aşağıdaki seviyelere göre ayrıştırılır. Hata ayıklama faaliyetlerinin etkinliği için doğru log seviyesinin seçilmesi zorunludur.

| Seviye | Kullanım Senaryosu | Örnek Durum | Aksiyon Planı |
|---|---|---|---|
| **ERROR** | Sistemde kritik bir bileşen arızalandığında ve son kullanıcının işlemi kesintiye uğradığında. | Veritabanı bağlantı hatası, uygulamanın HTTP 500 yanıtı döndürmesi. | Hata takip sistemleri (Sentry vb.) alarm üretir, nöbetçi mühendis (On-call) acil müdahale gerçekleştirir. |
| **WARN** | Sistem operasyonel kalmaya devam ediyor ancak beklenmeyen veya risk potansiyeli taşıyan bir durum söz konusu. | API yanıt süresinin belirlenen eşikleri (örn: 3 saniye) aşması, rate limit sınırlarına yaklaşılması. | Durum izlenir, problemin tekrarlaması halinde planlı iş listesine (backlog) dâhil edilerek kalıcı çözüm üretilir. |
| **INFO** | Kritik iş (business) akışlarının başarıyla tamamlandığını belgelendirir. | Kullanıcının sisteme giriş yapması, faturalandırma işleminin tamamlanması. | Analitik değerlendirmeler ve denetim (audit) logları kapsamında saklanır. |
| **DEBUG** | Yalnızca yerel geliştirme veya test (staging) ortamlarında detaylı sistem analizi için kullanılır. | Bir fonksiyona iletilen parametrelerin dökümü: `{ id: 1, type: "test" }` | Üretim (Production) ortamlarında kesinlikle kapalı tutulmalıdır. |

## 3. Yapısal Loglama (Structured Logging)

Log kayıtları, aranabilirlik ve filtrelenebilirlik özelliklerini maksimize etmek için düz metin (plain text) formatında değil; Datadog, ELK, New Relic gibi merkezi log yönetim platformlarının kolayca çözümleyebileceği JSON tabanlı Yapısal Loglama (Structured Logging) formatında oluşturulmalıdır (Örn: Winston, Pino gibi kütüphaneler kullanılarak).

```javascript
// HATALI KULLANIM (Düz metin, endeksleme ve arama operasyonları için elverişsiz)
console.error("Fatura kesilirken 102 id'li kullanıcı için API hatası oluştu: Timeout");

// DOĞRU KULLANIM (Yapısal loglama, yüksek filtrelenebilirlik)
logger.error("Fatura oluşturma işlemi başarısız oldu", {
  userId: 102,
  action: "create_invoice",
  errorCode: "TIMEOUT",
  durationMs: 3500
});
```

## 4. Hata İzleme ve Yönetimi (Error Tracking)

Frontend ve Backend mimarilerinde meydana gelen "Yakalanmayan İstisnalar" (Unhandled Exceptions), otomatik olarak merkezi hata izleme platformuna (**Sentry** vb.) iletilir. Log kaydı oluşturulurken, hatanın kök neden analizini kolaylaştırmak amacıyla o anki talebe ait Request ID'si ve temel ortam/tarayıcı bilgileri log paketine mutlaka dâhil edilmelidir.

---
*Son Güncelleme: 2026-08-30 — Versiyon 1.1 — Doküman Sahibi: DevOps / Tech Lead*
