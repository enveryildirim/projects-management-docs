# Backend ve Veritabanı Standartları

> **Bu dokümanın amacı nedir?**
> Bu doküman, sunucu tarafı uygulama katmanı ve veri katmanına ilişkin somut teknoloji tercihlerini, migration disiplinini, yedekleme/felaket kurtarma hedeflerini ve sorgu standartlarını tanımlamayı amaçlamaktadır. Backend ve DevOps ekipleri için bağlayıcıdır.

> 🚧 **DOKÜMAN DURUMU: TASLAK — YÜRÜRLÜKTE DEĞİLDİR.**
> İçerik henüz yazılmamıştır. Bu dosya, kapsamı ve sahipliği kayda geçirmek amacıyla bilinçli olarak bir iskelet olarak tutulmaktadır. Doküman tamamlanana kadar aşağıdaki başlıklara ilişkin kararlar, ilgili Otorite onayıyla (Seviye 2) ve gerekiyorsa [ADR](../adr/README.md) kaydıyla alınır.

---

## Yazılacak Bölümler (Kapsam Tanımı)

- [ ] **1. Araç Seti ve Sürüm Kısıtları:** Çalışma zamanı, ORM/sorgu katmanı, veritabanı sürümü, migration aracı, secret tarama ve linter araçlarının somut tanımı. *(Çekirdek yönergelerdeki soyut gereksinimlerin bu yığındaki karşılıkları — bkz: [Katman Kuralı](../core/README.md).)*
- [ ] **2. Katmanlı Mimari ve Klasör Yapısı:** Servis / repository / şema katmanlarının sınırları, iş mantığının hangi katmanda bulunacağı, isimlendirme standartları.
- [ ] **3. Migration Disiplini:** [Expand-Contract](../process/ci-cd-deployment.md) örüntüsünün somut uygulaması, `DROP`/`RENAME` yasağının CI'da nasıl denetlendiği, geri alma (rollback) sınırları.
- [ ] **4. Yedekleme ve Felaket Kurtarma (Backup & DR):** RPO/RTO hedefleri, otomatik snapshot sıklığı, **periyodik geri dönme (restore) testi protokolü** — test edilmemiş yedek, yedek sayılmaz. *(Bkz: [TODO.md](../../TODO.md) §2)*
- [ ] **5. Sorgu ve Performans Standartları:** N+1 sorgu yasağı, indeks stratejisi, yavaş sorgu eşikleri ve alarm bağlantısı ([Telemetri](../process/telemetry-logging.md)).
- [ ] **6. Yetkilendirme ve Veri İzolasyonu:** Çok kiracılı (multi-tenant) veri erişiminde kiracı izolasyonu, IDOR denetimlerinin veri katmanındaki karşılığı ([Test Stratejisi](../process/test-qa-strategy.md)).
- [ ] **7. Kesinti Anında Davranış:** Devre kesici (circuit breaker), zaman aşımı (timeout) ve bağlantı havuzu (connection pool) tükenmesi senaryolarında beklenen davranış. *(Bkz: [TODO.md](../../TODO.md) §2 — Outage Mitigation)*
- [ ] **8. Veri Saklama ve İmha:** Saklama süreleri, arşivleme ve KVKK kapsamındaki imha prosedürleri ([Güvenlik ve Uyum](../process/security-and-compliance.md)).

---
*Son Güncelleme: 2026-08-31 — Versiyon 0.1 (Taslak) — Doküman Sahibi: Backend Otoritesi (O) / DevOps*
