# 💻 Stacks — Teknoloji Eklentileri

> **Bu dizinin kapsamı nedir?**
> Bu dizindeki dokümanlar yalnızca ilgili teknoloji yığınında çalışan ekipleri bağlar. Somut araç, kütüphane ve framework tercihleri **yalnızca burada** tanımlanır; böylece bir teknoloji değişikliği çekirdek yönergeleri ([`docs/core/`](../core/README.md)) geçersiz kılmaz.

| Doküman | Kapsam | Durum |
| --- | --- | --- |
| [Web Frontend (Next.js / Tailwind)](./web-frontend.md) | Tasarım sistemi, render stratejileri, bileşen karar ağacı, erişilebilirlik | ✅ Aktif |
| [Backend ve Veritabanı](./backend-db.md) | Veri katmanı, migration, yedekleme/DR, sorgu standartları | 🚧 Taslak |

## Yeni Bir Stack Dokümanı Eklenmesi

Yeni bir teknoloji yığını devreye alındığında (örn. mobil, veri boru hattı), bu dizine ilgili doküman eklenir ve içeriğinde asgari olarak şu başlıklar bulunur:

- [ ] Araç seti ve sürüm kısıtları
- [ ] Çekirdek yönergelerin bu yığındaki somut karşılıkları (linter, test aracı, secret tarayıcı, mock kütüphanesi)
- [ ] Klasör yapısı ve isimlendirme standartları
- [ ] Yeni bileşen/modül ekleme karar ağacı
- [ ] Yapay zeka araçları için bağlam dosyası içeriği (Bkz: [AI Manifestosu](../core/ai-manifesto.md) §3)

Yeni stack dokümanı eklenmesi Seviye 3 karardır ve [ADR](../adr/README.md) kaydı gerektirir.

---
*Son Güncelleme: 2026-08-31 — Versiyon 1.0 — Doküman Sahibi: Tech Lead*
