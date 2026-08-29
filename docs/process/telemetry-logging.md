# Telemetri ve Loglama Standartları

> **Bu doküman ne işe yarar?**
> Canlı sistemin sağlığını izlemek, çökmelerin kök nedenini hızlıca bulmak ve kullanıcı davranışlarını takip etmek için log ve telemetri kayıtlarının nasıl oluşturulması gerektiğini belirler.

---

## 1. Altın Kural: Kişisel Sağlık Verisi (PHI/PII) Maskeleme

**HİÇBİR ZAMAN** gerçek hasta isimleri, TC Kimlik Numaraları, şifreler, kredi kartı bilgileri veya tıbbi teşhis detayları loglara basılamaz.
- *Yanlış Log:* `Hasta kaydedildi: Ahmet Yılmaz, TC: 12345678901, Teşhis: Kanser`
- *Doğru Log:* `Hasta kaydedildi. UserID: usr_8f72a, Action: patient_register_success`

Kritik veriler sisteme loglanmadan önce masking (maskeleme) kütüphanelerinden geçirilmelidir.

## 2. Log Seviyeleri (Log Levels)

Sistemin ürettiği loglar aşağıdaki seviyelere göre ayrıştırılır. Hata ayıklarken filtrelemeyi kolaylaştırmak için doğru seviyeyi seçmek zorunludur.

| Seviye | Ne Zaman Kullanılır? | Örnek Durum | Aksiyon |
|---|---|---|---|
| **ERROR** | Sistemde bir şeyler kırıldığında ve kullanıcının işlemi yarıda kaldığında. | Veritabanı bağlantısı koptu, API 500 döndü. | Sentry alarm üretir, nöbetçi dev müdahale eder. |
| **WARN** | Sistem çalışmaya devam ediyor ama beklenmeyen/riskli bir durum var. | API yanıtı 3 saniyeyi aştı, rate limit sınırına yaklaşıldı. | İzlenir, tekrar ederse planlı iş olarak çözülür. |
| **INFO** | Önemli iş (business) akışlarının başarılı tamamlandığını belirtir. | Kullanıcı giriş yaptı, fatura başarıyla kesildi. | Analitik ve denetim (audit) için saklanır. |
| **DEBUG** | Sadece lokal geliştirmede veya staging ortamında kullanılır, detaya inmek içindir. | Fonksiyona giren parametreler: `{ id: 1, type: "test" }` | Canlı (Production) ortamda kapalı tutulmalıdır. |

## 3. Yapısal Loglama (Structured Logging)

Loglar düz metin olarak değil, JSON formatında, makinelerin (ve Datadog, ELK, New Relic gibi araçların) kolayca okuyabileceği yapıda (Structured Logging) olmalıdır. (Örn: Winston veya Pino kütüphaneleri ile).

```javascript
// YANLIŞ (Düz metin, arama yapmak zor)
console.error("Fatura kesilirken 102 id'li kullanıcı için API hatası oluştu: Timeout");

// DOĞRU (Yapısal log, filtrelemek kolay)
logger.error("Fatura oluşturma başarısız", {
  userId: 102,
  action: "create_invoice",
  errorCode: "TIMEOUT",
  durationMs: 3500
});
```

## 4. Hata İzleme (Error Tracking)

Frontend ve Backend tarafında oluşan "Unhandled Exception" (yakalanmayan hatalar) otomatik olarak **Sentry** (veya benzeri bir araca) gönderilir. Hata loglanırken kullanıcının o anki Request ID'si ve temel tarayıcı bilgileri eklenerek kök neden analizi kolaylaştırılır.

---
*Son güncelleme: 2026-08-29 — Versiyon 1.0 — Sahibi: DevOps / Tech Lead*

