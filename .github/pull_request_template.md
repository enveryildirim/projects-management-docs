## Değişikliğin Özeti

<!-- Ne değişti ve neden? Kod "ne" yapıldığını gösterir; bu alan "neden" yapıldığını açıklar. -->

**İlgili görev / issue:** <!-- örn. PROJ-123 veya #45 -->

**Değişiklik türü:**
- [ ] `feat` — yeni özellik
- [ ] `fix` — hata düzeltmesi
- [ ] `refactor` — davranış değiştirmeyen iyileştirme
- [ ] `docs` — dokümantasyon
- [ ] `chore` / `ci` — altyapı, otomasyon, birikim listesi

**Karar seviyesi** (Bkz: [Karar Verme Yetkisi](../docs/process/decision-making-authority.md)):
- [ ] Seviye 1 — otonom karar, bilgilendirme amaçlı
- [ ] Seviye 2 — Otorite (O) onayı gerekiyor: `@___`
- [ ] Seviye 3 — ADR kaydı gerekiyor / eklendi: `docs/adr/____`

---

## Definition of Done Kontrol Listesi

> 💡 Otomatik denetimlerin (CI) kapsadığı maddeler ayrıca işaretlenmez; CI sonucu esastır. Aşağıdaki liste yalnızca **otomasyonla saptanamayan** maddeleri içerir. Tam liste: [DoD](../docs/core/dod.md)

**Kapsam ve doğruluk**
- [ ] Görev kartındaki tüm kabul kriterleri karşılanmıştır.
- [ ] Testler kodun mevcut halini değil, **iş kuralını** doğrulamaktadır (totolojik test yok).
- [ ] Uç durumlar (boş veri, yükleniyor, hata) ele alınmıştır.

**Dayanıklılık ve geri alma**
- [ ] Harici servis çöktüğünde sistem tamamen işlevsiz kalmıyor; kullanıcıya anlaşılır bir kısıtlı deneyim sunuluyor.
- [ ] Veritabanı şema değişikliği varsa **geriye dönük uyumludur** (Expand-Contract) ve tek PR içinde `DROP`/`RENAME` içermez.
- [ ] Geri alma (rollback) yolu bilinmektedir.

**İzlenebilirlik**
- [ ] Yeni modülün kullanımını ölçecek telemetri eklenmiştir (hipotez doğrulaması için).
- [ ] Loglara kişisel/hassas veri düz metin olarak yazılmamaktadır.
- [ ] Yeni ortam değişkeni, yeni bağımlılık veya mimari değişiklik varsa dokümantasyon/ADR güncellenmiştir.

**Yapay zeka şeffaflığı** (Bkz: [AI Manifestosu](../docs/core/ai-manifesto.md))
- [ ] Karmaşık iş mantığı veya kritik bileşen yapay zeka ile üretilmemiştir **VEYA** kullanılan ana komut (prompt) aşağıya eklenmiştir.
- [ ] Atıl kod ve halüsinasyon bağımlılık kontrolü yapılmıştır (kullanılmayan fonksiyon / gereksiz kütüphane yok).

<details>
<summary>Kullanılan ana komut (prompt)</summary>

```text
(varsa buraya yazınız)
```
</details>

---

## İnceleyene Not

<!-- Dikkat edilmesi gereken bir ödünleşim (trade-off), bilinçli olarak ertelenmiş bir iyileştirme veya
     özellikle gözden geçirilmesini istediğiniz bir bölüm varsa buraya yazınız. -->
