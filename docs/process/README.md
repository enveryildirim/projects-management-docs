# ⚙️ Process — Operasyonel Akış ve Yönetişim

> **Bu dizinin kapsamı nedir?**
> Bu dizindeki dokümanlar, çekirdek yönergelerin günlük operasyona nasıl döküldüğünü tanımlar: iletişim protokolleri, karar yetkileri, sorumluluk dağılımı, dağıtım ve test süreçleri, güvenlik standartları ve ölçüm mekanizmaları.

| Doküman | Kapsam | Profil |
| --- | --- | --- |
| [Oryantasyon ve Sistem Kurulumu](./onboarding-and-setup.md) | 1. gün / 1. hafta / 1. ay — **oryantasyonun tek kaynağı** | Tümü |
| [Yerel Kurulum Eki](./local-setup.md) | Manuel kurulum adımları ve sorun giderme | Tümü |
| [Dokümantasyon Standartları](./documentation-standards.md) | Doküman formatı, sahiplik, versiyonlama, commit hijyeni | Standard+ |
| [İletişim ve Toplantı Manifestosu](./communication-and-meetings.md) | Ret hakkı, odak günü, asenkron iletişim, kanal SLA'ları | Standard+ |
| [Karar Verme Yetkisi (Decision Rights)](./decision-making-authority.md) | Seviye 1-2-3, otorite ataması, HIPPO kuralı, eskalasyon | Standard+ |
| [Yetkinlik ve Etki Alanı Matrisi](./competency-matrix.md) | Otorite / Uzman / Geliştirici / Öğrenen — `CODEOWNERS` temeli | Standard+ |
| [RACI Matrisi ve Roller](./raci-matrix.md) | Süreç bazlı sorumluluk dağılımı | Regulated |
| [Protokol Güncelleme (RFC)](./rfc-update-protocol.md) | Playbook'un kendi değişim yönetimi | Standard+ |
| [Mimari Karar Kaydı (ADR) Şablonu](./adr-template.md) | Karar kaydı formatı — arşiv: [`docs/adr/`](../adr/README.md) | Standard+ |
| [CI/CD ve Dağıtım Stratejisi](./ci-cd-deployment.md) | Trunk-based, Expand-Contract, kesintisiz geçiş, rollback | Tümü |
| [Test ve Kalite Güvence Stratejisi](./test-qa-strategy.md) | Test piramidi, IDOR denetimi, preview ortamları | Standard+ |
| [Güvenlik ve Uyum (DevSecOps)](./security-and-compliance.md) | Secret yönetimi, KVKK/GDPR, SCA/SAST, erişim kontrolü | Tümü |
| [Telemetri ve Loglama Standartları](./telemetry-logging.md) | PII/PHI maskeleme, log seviyeleri, yapısal loglama | Standard+ |
| [Mühendislik Metrikleri (DORA)](./engineering-metrics.md) | DORA, operasyonel sağlık metrikleri, anti-metrikler | Standard+ |

---
*Son Güncelleme: 2026-08-31 — Versiyon 1.0 — Doküman Sahibi: Engineering Manager*
