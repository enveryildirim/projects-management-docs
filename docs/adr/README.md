# 🗂️ Mimari Karar Kayıtları (ADR) Arşivi

> **Bu dizinin kapsamı nedir?**
> Geri dönüş maliyeti yüksek olan mimari, altyapı ve süreç kararlarının gerekçeleriyle birlikte kalıcı arşivini barındırır. Amaç, ileride "neden böyle yapıldı?" sorusunun kurumsal hafızadan yanıtlanabilmesidir.

## Kullanım

* Yeni bir kayıt oluşturmak için: `make new-adr` (şablonu numaralandırarak kopyalar).
* Şablon: [ADR Şablonu](../process/adr-template.md)
* Hangi kararların ADR gerektirdiği: [Karar Verme Yetkisi](../process/decision-making-authority.md) — Seviye 3.
* Bir kararın geçersiz kılınması durumunda ilgili kayıt **silinmez**; durumu `Yürürlükten Kaldırıldı (Superseded)` olarak güncellenir ve yeni kayda atıf verilir.

## Kayıt Dizini

| No | Karar | Durum | Tarih |
| --- | --- | --- | --- |
| [0001](./0001-trunk-based-development.md) | Paylaşımlı `staging` ortamı yerine Trunk-Based Development ve PR Preview | ✅ Kabul Edildi | 2026-08-30 |

---
*Son Güncelleme: 2026-08-31 — Versiyon 1.0 — Doküman Sahibi: Tech Lead*
