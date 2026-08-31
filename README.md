# 📘 Mühendislik Yönetişim Çerçevesi (Engineering Governance Framework)

> **Bu deponun amacı nedir?**
> Bu depo, yazılım ekiplerimizin kültürel prensiplerini, karar alma mekanizmalarını ve teknik standartlarını (Golden Path) tanımlayan bir **mühendislik yönetişim playbook'udur**. Amacı; yeni bir projeye hızlı başlamayı, önceki projelerden edinilen tecrübenin aktarılmasını ve ekibin ortak bir mühendislik zihniyetinde (mindset) buluşmasını sağlamaktır. Dokümantasyon "Kod Olarak Dokümantasyon" (Docs-as-Code) prensibiyle yönetilir ve her değişiklik [RFC süreci](docs/process/rfc-update-protocol.md) ile yürütülür.

---

## 🎯 Temel Tasarım İlkesi: Kural, Uygulanabildiği Ölçüde Kuraldır

Kuralların kişisel inisiyatife bırakıldığı sistemlerde erozyon kaçınılmazdır (Kırık Cam Teorisi). Bu nedenle çerçevemizin nihai hedefi, her yönergeyi kademeli olarak otomatik bir denetime (Policy-as-Code) bağlamaktır. Aşağıdaki tablo, bu dönüşümün **mevcut gerçek durumunu** şeffaf biçimde göstermektedir:

| Katman | Kapsam | Durum |
| --- | --- | --- |
| **Doküman Katmanı** | Felsefe, süreç, kalite kapıları, teknik standartlar | ✅ Aktif |
| **Denetim Betikleri** | `scripts/check-docs.sh` — kırık bağlantı, indeks boşluğu, eksik sahiplik denetimi | ✅ Aktif (`make check`) |
| **Depo Şablonları** | PR şablonu (DoD), Issue şablonları (DoR/Triage), `CODEOWNERS` | ✅ Aktif |
| **CI Bariyerleri (Playbook)** | Doküman denetiminin PR'da süreç durdurucu (blocking) çalışması | ✅ Aktif |
| **CI Bariyerleri (Ürün Depoları)** | Secret taraması (TruffleHog), linter, test, build — DoD'nin otomasyonu | 🟡 Ürün deposu başına kurulur (Bkz: [CI/CD](docs/process/ci-cd-deployment.md)) |
| **Politika Motoru** | OPA / Conftest ile altyapı politikalarının denetimi | ⚪ Planlandı |
| **Otonom Denetçiler (AEGS)** | Kural bekçiliği yapan çoklu-ajan sistemi | ⚪ Tasarım aşamasında (Bkz: [HLD](plans/agents-design.md)) |

> 💡 Bu tablo bilinçli olarak dokümanın en üstünde tutulmaktadır. Henüz otomasyona bağlanmamış bir kural, ekipten "uyulacağı varsayılan" değil "hatırlatılması gereken" bir kural olarak beklenmelidir.

## 🏗️ Sistem Mimarisi (Dizin Yapısı)

Çerçeve, teknolojik bağımlılıkları (tight coupling) minimize etmek amacıyla modüler bir yapıda tasarlanmıştır:

* 📂 **[`docs/core/`](docs/core/README.md) — Çekirdek Yönergeler:** Teknoloji bağımsızdır. Tüm yazılım ekiplerini (Web, Mobil, AI) kapsar. Ürün felsefesi, DoR/DoD kapıları, önceliklendirme, kriz yönetimi ve yapay zeka kullanım standartlarını içerir.
* 📂 **[`docs/process/`](docs/process/README.md) — Operasyonel Akış:** İletişim protokolleri, karar yetkileri, RACI matrisi, CI/CD, test stratejisi, güvenlik ve DORA metriklerini detaylandırır.
* 📂 **[`docs/stacks/`](docs/stacks/README.md) — Teknoloji Eklentileri:** Yalnızca ilgili yığında çalışan ekipleri bağlar. Teknoloji güncellemeleri yalnızca ilgili eklentiyi etkiler; çekirdek yapı bu durumdan etkilenmez.
* 📂 **[`docs/adr/`](docs/adr/README.md) — Mimari Karar Kayıtları:** Geri dönüş maliyeti yüksek kararların gerekçeleriyle birlikte arşivi.
* 📂 **`plans/` — Çalışma Planları:** Henüz yürürlüğe girmemiş tasarım ve denetim dokümanları.
* ⚙️ **`.github/` ve `scripts/` — Politika Otomasyonu:** PR/Issue şablonları, `CODEOWNERS`, denetim betikleri ve CI iş akışları.

---

## 🚀 Başlangıç

### 1. Sisteme Giriş (Soğuk Başlangıç)

Ekibe yeni katılan personel veya yeni bir proje için tek referans doküman:
👉 **[Oryantasyon ve Sistem Kurulum Rehberi](docs/process/onboarding-and-setup.md)**

### 2. Uygulama Profilinin Seçilmesi

Bu çerçevenin tamamı her projeye uygulanmaz. 20 dokümanlık tam kapsam, 3 kişilik kısa vadeli bir proje için sürdürülemez ağırlıktadır. Projeye başlarken uygun profil seçilmelidir:
👉 **[Uygulama Profilleri: Lite / Standard / Regulated](docs/core/profiles.md)**

### 3. Denetim Mekanizmalarının Aktivasyonu

* Depo ayarları üzerinden (Branch Protection) `CODEOWNERS` onayları zorunlu hale getirilmelidir.
* `.github/ISSUE_TEMPLATE/` şablonları [Triage](docs/core/triage.md) ve [DoR](docs/core/dor.md) formatlarıyla uyumlu olacak şekilde yapılandırılmalıdır.
* CI/CD boru hatlarında secret taraması ve linter adımları süreç durdurucu (blocking) kontrol olarak tanımlanmalıdır.
* Playbook deposunun kendi tutarlılığı için `make check` komutu CI'da çalıştırılmalıdır.

### 4. Kural Revizyon (RFC) Süreci

Dokümantasyon statik bir yapı değildir. Verimsiz olduğu değerlendirilen bir kuralın güncellenmesi talebi anlık iletişim kanalları üzerinden değil, resmî PR süreci işletilerek iletilir.
👉 **[Protokol Güncelleme (RFC) Yönergesi](docs/process/rfc-update-protocol.md)**

---

## 📚 Doküman Dizini

### 🧠 Core — Çekirdek Kurallar ve Geçiş Kapıları

| Doküman | Kapsam |
| --- | --- |
| [Uygulama Profilleri](docs/core/profiles.md) | Lite / Standard / Regulated — hangi doküman hangi projede zorunlu |
| [Ürün Felsefesi ve Mühendislik Anayasası](docs/core/product-philosophy.md) | Değer, ret kültürü, YAGNI, kaynak tahsisi sözleşmesi |
| [Ürün Vizyon Panosu](docs/core/vision-board.md) | Hedef kitle, iş ihtiyaçları ve stratejik hedef şablonu |
| [Yapay Zeka (AI) Manifestosu](docs/core/ai-manifesto.md) | Mülkiyet, DLP, bağlam optimizasyonu, AI kod inceleme standartları |
| [Müşteri Talebi ve Triage Filtresi](docs/core/triage.md) | Talep kabul kriterleri, ICE skorlama, ret prosedürü |
| [Definition of Ready (DoR)](docs/core/dor.md) | Girdi kriterleri — geliştirmeye başlama kapısı |
| [Definition of Done (DoD)](docs/core/dod.md) | Çıktı kriterleri — üretime çıkma kapısı |
| [P0-P4 Önceliklendirme Çerçevesi](docs/core/p0-p4-prioritization.md) | Aciliyet/etki sınıflandırması ve beklenen yanıt süreleri |
| [Cynefin Çerçevesi](docs/core/cynefin.md) | Proje tipine göre metodoloji seçimi (Waterfall / Kanban / Scrum / Kriz) |
| [Olay Müdahale ve Post-Mortem](docs/core/incident-response.md) | Severity seviyeleri, kriz rolleri, suçlamasız inceleme şablonu |

### ⚙️ Process — Operasyon ve Yönetişim

| Doküman | Kapsam |
| --- | --- |
| [Oryantasyon ve Sistem Kurulumu](docs/process/onboarding-and-setup.md) | 1. gün / 1. hafta / 1. ay hedefleri — **oryantasyonun tek kaynağı** |
| [Yerel Kurulum Eki](docs/process/local-setup.md) | Manuel kurulum adımları ve sorun giderme tabloları |
| [Dokümantasyon Standartları](docs/process/documentation-standards.md) | Doküman formatı, sahiplik, versiyonlama, dizin yapısı |
| [İletişim ve Toplantı Manifestosu](docs/process/communication-and-meetings.md) | Ret hakkı, odak günü, asenkron iletişim, kanal SLA matrisi |
| [Karar Verme Yetkisi (Decision Rights)](docs/process/decision-making-authority.md) | Seviye 1-2-3 kararlar, eskalasyon, otorite devri |
| [Yetkinlik ve Etki Alanı Matrisi](docs/process/competency-matrix.md) | Otorite / Uzman / Geliştirici / Öğrenen ve `CODEOWNERS` temeli |
| [RACI Matrisi ve Roller](docs/process/raci-matrix.md) | Süreç bazlı sorumluluk dağılımı |
| [Protokol Güncelleme (RFC)](docs/process/rfc-update-protocol.md) | Playbook'un kendi değişim yönetimi |
| [Mimari Karar Kaydı (ADR) Şablonu](docs/process/adr-template.md) | Karar kaydı formatı |
| [CI/CD ve Dağıtım Stratejisi](docs/process/ci-cd-deployment.md) | Trunk-based akış, Expand-Contract, kesintisiz geçiş, rollback |
| [Test ve Kalite Güvence Stratejisi](docs/process/test-qa-strategy.md) | Test piramidi, IDOR denetimi, preview ortamları, mocking |
| [Güvenlik ve Uyum (DevSecOps)](docs/process/security-and-compliance.md) | Secret yönetimi, KVKK/GDPR, zafiyet taraması, erişim kontrolü |
| [Telemetri ve Loglama Standartları](docs/process/telemetry-logging.md) | PII/PHI maskeleme, log seviyeleri, yapısal loglama |
| [Mühendislik Metrikleri (DORA)](docs/process/engineering-metrics.md) | DORA metrikleri, operasyonel sağlık ve anti-metrikler |

### 💻 Stacks — Teknoloji Standartları

| Doküman | Kapsam |
| --- | --- |
| [Web Frontend (Next.js / Tailwind)](docs/stacks/web-frontend.md) | Tasarım sistemi, render stratejileri, bileşen karar ağacı |
| [Backend ve Veritabanı](docs/stacks/backend-db.md) | 🚧 Taslak — yedekleme/DR, migration ve veri katmanı standartları |

### 🗂️ Arşiv ve Planlar

| Doküman | Kapsam |
| --- | --- |
| [Mimari Karar Kayıtları (ADR) Arşivi](docs/adr/README.md) | Alınmış kararların gerekçeli kayıtları |
| [Stratejik Birikim Listesi](TODO.md) | Açık süreç ihtiyaçları ve okuma referansları |
| [Denetim Raporu ve Düzeltme Planı](plans/review-action-plan.md) | 2026-08-31 yapısal denetim bulguları |
| [AEGS — Otonom Yönetişim Sistemi (HLD)](plans/agents-design.md) | Çoklu-ajan denetim sistemi yüksek seviye tasarımı |

---

## 🧰 Depo Bakım Komutları

```bash
make check        # Tüm doküman denetimlerini çalıştırır (CI ile aynı)
make check-links  # Kırık iç bağlantıları tespit eder
make check-index  # README indeksi ile dosya sistemi tutarlılığını denetler
make check-meta   # Sahiplik, versiyon, amaç bloğu ve tek-H1 kuralı eksiklerini listeler
make check-layers # docs/core/ teknoloji bağımsızlığını denetler (katman kuralı)
make new-adr      # Şablondan numaralandırılmış yeni bir ADR oluşturur
```

---

*Bu çerçeve, Ampirik Süreç Kontrolü (Empirical Process Control) prensipleri esas alınarak tasarlanmıştır.*

*Son Güncelleme: 2026-08-31 — Versiyon 3.0 — Doküman Sahibi: Engineering Manager*
