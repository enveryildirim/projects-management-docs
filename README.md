# 📘 Mühendislik Yönetişim Çerçevesi (Engineering Governance Framework)

Bu depo, salt okunur bir wiki değil; yazılım ekibimizin kültürel prensiplerini, karar alma mekanizmalarını ve teknik sınırlarını (Golden Path) fiziksel olarak denetleyen **çalıştırılabilir bir işletim sistemidir**.

Sistem; kuralları insan iradesine (okuyup hatırlamaya) bırakmaz. CI/CD kancaları, PR şablonları, Otonom Ajanlar (Gatekeepers) ve otomasyon betikleri ile süreçleri dayatır.

## 🏗️ Sistem Mimarisi (Klasör Yapısı)

Sistem, teknoloji bağımlılığını (tight coupling) önlemek için modüler tasarlanmıştır:

* 📂 **`/docs/core/` (Çekirdek Anayasa):** Teknoloji bağımsızdır. Şirketin tüm yazılım ekiplerini (Web, Mobil, AI) bağlar. Ürün felsefesi, DoR/DoD kapıları, kriz yönetimi ve yapay zeka sınırlarını içerir.
* 📂 **`/docs/stacks/` (Teknoloji Eklentileri):** Sadece belirli bir teknoloji yığınında çalışanları bağlar (Örn: `web-frontend.md` Next.js ve Tailwind kurallarını içerir). Teknoloji değişirse sadece buradaki eklenti (plugin) değişir, core etkilenmez.
* 📂 **`/docs/process/` (Operasyonel Akış):** Ekip içi iletişimi, toplantı ret haklarını, RACI matrisini ve DORA metriklerini tanımlar.
* ⚙️ **`.github/` & `scripts/` (Policy-as-Code):** DoD/DoR şablonları, OPA/Conftest politikaları ve AI Gatekeeper botlarının CI/CD yapılandırmaları.

---

## 🚀 Başlangıç ve Entegrasyon (Sistemi Ayağa Kaldırmak)

Bu çerçeveyi yeni bir projeye klonladığınızda, sistemi manuel olarak "okutmaya" çalışmayın, aşağıdaki otomasyon adımlarını izleyin:

### 1. Soğuk Başlangıç (Sıfır Kurulum)

Ekibe yeni biri katıldığında veya projeyi ilk kez ayağa kaldırırken okunacak *tek* belge:
👉 **[00-Onboarding ve Kurulum Rehberi](https://www.google.com/search?q=./docs/core/00-onboarding.md)**
*(Bu belge `make setup` komutu ile lokal ortamın sentetik KVKK-uyumlu veriyle nasıl saniyeler içinde kurulacağını anlatır).*

### 2. Kural Duvarlarının (Gatekeepers) Aktif Edilmesi

Sistemin çalışması için insan onayı beklenmez:

* Depo ayarlarından (Branch Protection) `CODEOWNERS` onayını zorunlu kılın.
* Projedeki `ISSUE_TEMPLATE.md` dosyasını [Triage](https://www.google.com/search?q=./docs/core/triage.md) ve [DoR](https://www.google.com/search?q=./docs/core/dor.md) formatına göre ayarlayın.
* CI/CD pipeline'ında TruffleHog (Sızıntı taraması) ve Linter adımlarını bloke edici (blocking) olarak yapılandırın.

### 3. Kural Değiştirme (RFC Süreci)

Bu depo statik bir dogma değildir. Kötü çalışan bir kuralı değiştirmek veya yeni bir teknoloji önermek istiyorsanız Slack'ten yazmayın; bir PR açın.
👉 **[Playbook Güncelleme (RFC) Protokolü](https://www.google.com/search?q=./docs/core/rfc-guncelleme-protokolu.md)**

---

## 📚 Doküman Dizini

### 🧠 Core (Çekirdek Kurallar ve Kapılar)

* [00 - Onboarding ve Kurulum Rehberi](https://www.google.com/search?q=./docs/core/00-onboarding.md)
* [Ürün Felsefesi ve Geliştirme Zihniyeti](https://www.google.com/search?q=./docs/core/urun-felsefesi.md)
* [Yapay Zeka (AI) Manifestosu](https://www.google.com/search?q=./docs/core/ai-manifesto.md)
* [Müşteri Talebi ve Triage Filtresi](https://www.google.com/search?q=./docs/core/triage.md)
* [Definition of Ready (DoR) - Girdi Kapısı](https://www.google.com/search?q=./docs/core/dor.md)
* [Definition of Done (DoD) - Çıktı Kapısı](https://www.google.com/search?q=./docs/core/dod.md)
* [Olay Müdahale ve Post-Mortem (Incident Response)](https://www.google.com/search?q=./docs/core/incident-response.md)
* [Playbook Güncelleme Protokolü (RFC)](https://www.google.com/search?q=./docs/core/rfc-guncelleme-protokolu.md)

### ⚙️ Process (Operasyon ve Yönetişim)

* [İletişim, Toplantı ve Asenkron Daily](https://www.google.com/search?q=./docs/process/iletisim-ve-toplanti.md)
* [Karar Verme Yetkisi (Seviye 1-2-3)](https://www.google.com/search?q=./docs/process/karar-verme-yetkisi.md)
* [Yetkinlik Matrisi ve Otoriteler (CODEOWNERS)](https://www.google.com/search?q=./docs/process/yetkinlik-ve-etki-alani.md)
* [Mühendislik Metrikleri (DORA)](https://www.google.com/search?q=./docs/process/engineering-metrics.md)

### 💻 Stacks (Teknik Bariyerler ve Uygulama)

* [CI/CD ve Sürekli Dağıtım (Zero-Downtime)](https://www.google.com/search?q=./docs/stacks/ci-cd-deployment.md)
* [Test Stratejisi ve Veri Yönetişimi](https://www.google.com/search?q=./docs/stacks/test-qa-strategy.md)
* [Tasarım Sistemi ve UI Altın Yolu (Next.js/Tailwind)](https://www.google.com/search?q=./docs/stacks/web-frontend.md)

---

*Bu mimari, Ampirik Süreç Kontrolü (Empirical Process Control) ilkelerine göre tasarlanmış ve yönetilmektedir.*