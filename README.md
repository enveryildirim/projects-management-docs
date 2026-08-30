# 📘 Mühendislik Yönetişim Çerçevesi (Engineering Governance Framework)

Bu depo, salt okunur bir bilgi kaynağı (wiki) olmanın ötesinde; yazılım ekibimizin kültürel prensiplerini, karar alma mekanizmalarını ve teknik standartlarını (Golden Path) fiziksel olarak denetleyen ve uygulatan **çalıştırılabilir bir kurumsal işletim sistemidir**.

Sistemimiz, kuralların uygulanmasını kişisel inisiyatiflere bırakmamaktadır. CI/CD kancaları (hooks), Pull Request şablonları, Otonom Denetçiler (Gatekeepers) ve otomasyon betikleri (scripts) vasıtasıyla operasyonel süreçler sistematik olarak yürütülmektedir.

## 🏗️ Sistem Mimarisi (Dizin Yapısı)

Sistemimiz, teknolojik bağımlılıkları (tight coupling) minimize etmek amacıyla modüler bir mimariyle tasarlanmıştır:

* 📂 **`/docs/core/` (Çekirdek Yönergeler):** Teknoloji bağımsızdır. Kurumumuz bünyesindeki tüm yazılım ekiplerini (Web, Mobil, AI) kapsar. Ürün felsefesi, DoR/DoD (Hazır Olma ve Tamamlanma Kriterleri) kapıları, kriz yönetimi ve yapay zeka kullanım standartlarını içermektedir.
* 📂 **`/docs/stacks/` (Teknoloji Eklentileri):** Yalnızca spesifik bir teknoloji yığınında görev alan ekipleri bağlar (Örn: `web-frontend.md` dokümanı Next.js ve Tailwind standartlarını belirler). Teknoloji güncellemeleri yalnızca ilgili eklentiyi (plugin) etkiler, çekirdek yapı (core) bu durumdan etkilenmez.
* 📂 **`/docs/process/` (Operasyonel Akış):** Ekip içi iletişim protokollerini, toplantı katılım/ret haklarını, RACI matrisini ve DORA metriklerini detaylandırır.
* ⚙️ **`.github/` ve `scripts/` (Politika Otomasyonu - Policy-as-Code):** DoD/DoR şablonlarını, OPA/Conftest politikalarını ve AI Gatekeeper botlarının CI/CD yapılandırmalarını barındırır.

---

## 🚀 Başlangıç ve Entegrasyon (Sistemin Devreye Alınması)

Bu çerçevenin yeni bir projeye entegre edilmesi sürecinde manuel adımlardan kaçınılmalı ve aşağıdaki otomasyon yönergeleri izlenmelidir:

### 1. Sisteme Giriş (Soğuk Başlangıç)

Ekibimize yeni katılan personelin veya yeni bir projenin başlatılması aşamasında incelenmesi gereken *temel* referans dokümanı aşağıda belirtilmiştir:
👉 **[00-Onboarding ve Kurulum Rehberi](https://www.google.com/search?q=./docs/core/00-onboarding.md)**
*(İlgili belge, `make setup` komutu aracılığıyla yerel ortamın sentetik, KVKK uyumlu verilerle saniyeler içerisinde nasıl ayağa kaldırılacağını detaylandırmaktadır).*

### 2. Denetim Mekanizmalarının (Gatekeepers) Aktivasyonu

Sistem işleyişi insan onayından bağımsız olarak kurgulanmıştır:

* Depo (Repository) ayarları üzerinden (Branch Protection) `CODEOWNERS` onayları zorunlu hale getirilmelidir.
* Proje dizinindeki `ISSUE_TEMPLATE.md` dosyası, [Triage](https://www.google.com/search?q=./docs/core/triage.md) ve [DoR](https://www.google.com/search?q=./docs/core/dor.md) formatlarına tam uyumlu olacak şekilde yapılandırılmalıdır.
* CI/CD boru hatlarında (pipeline) TruffleHog (Güvenlik sızıntı taraması) ve Linter adımları süreç durdurucu (blocking) kontroller olarak tanımlanmalıdır.

### 3. Kural Revizyon (RFC) Süreci

Mevcut dokümantasyon statik bir yapı değildir. Verimsiz olduğu değerlendirilen bir kuralın güncellenmesi veya yeni bir teknolojinin önerilmesi talepleri anlık iletişim kanalları (Slack vb.) üzerinden değil, doğrudan resmi Pull Request (PR) süreci işletilerek yapılmalıdır.
👉 **[Protokol Güncelleme (RFC) Yönergesi](https://www.google.com/search?q=./docs/core/rfc-update-protocol.md)**

---

## 📚 Doküman Dizini

### 🧠 Core (Çekirdek Kurallar ve Geçiş Kapıları)

* [00 - Onboarding ve Kurulum Rehberi](https://www.google.com/search?q=./docs/core/00-onboarding.md)
* [Ürün Felsefesi ve Geliştirme Yaklaşımı](https://www.google.com/search?q=./docs/core/product-philosophy.md)
* [Yapay Zeka (AI) Manifestosu](https://www.google.com/search?q=./docs/core/ai-manifesto.md)
* [Müşteri Talebi ve Triage Filtresi](https://www.google.com/search?q=./docs/core/triage.md)
* [Definition of Ready (DoR) - Girdi Kriterleri](https://www.google.com/search?q=./docs/core/dor.md)
* [Definition of Done (DoD) - Çıktı Kriterleri](https://www.google.com/search?q=./docs/core/dod.md)
* [Olay Müdahale ve Değerlendirme (Incident Response)](https://www.google.com/search?q=./docs/core/incident-response.md)
* [Protokol Güncelleme Yönergesi (RFC)](https://www.google.com/search?q=./docs/core/rfc-update-protocol.md)
* [Cynefin Çerçevesi (Proje Yönetim Metodolojisi)](https://www.google.com/search?q=./docs/core/cynefin.md)
* [P0-P4 Önceliklendirme Kriterleri](https://www.google.com/search?q=./docs/core/p0-p4-prioritization.md)

### ⚙️ Process (Operasyon ve Yönetişim)

* [Mimari Karar Kayıtları (ADR) Şablonu](https://www.google.com/search?q=./docs/process/adr-template.md)
* [İletişim, Toplantı ve Asenkron Günlük İletişim](https://www.google.com/search?q=./docs/process/communication-and-meetings.md)
* [Karar Verme Yetki Matrisi (Seviye 1-2-3)](https://www.google.com/search?q=./docs/process/decision-making-authority.md)
* [Yetkinlik Matrisi ve Sorumluluklar (CODEOWNERS)](https://www.google.com/search?q=./docs/process/competency-and-raci.md)
* [Mühendislik Metrikleri (DORA)](https://www.google.com/search?q=./docs/process/engineering-metrics.md)
* [Güvenlik ve Uyum Standartları (DevSecOps)](https://www.google.com/search?q=./docs/process/security-and-compliance.md)

### 💻 Stacks (Teknik Standartlar ve Uygulama)

* [CI/CD ve Sürekli Dağıtım (Kesintisiz Geçiş)](https://www.google.com/search?q=./docs/stacks/ci-cd-deployment.md)
* [Test Stratejisi ve Veri Yönetimi](https://www.google.com/search?q=./docs/stacks/test-qa-strategy.md)
* [Tasarım Sistemi ve UI Referansı (Next.js/Tailwind)](https://www.google.com/search?q=./docs/stacks/web-frontend.md)

---

*Bu mimari yapı, Ampirik Süreç Kontrolü (Empirical Process Control) prensipleri esas alınarak tasarlanmış olup ilgili standartlar çerçevesinde yönetilmektedir.*