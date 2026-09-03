# 📋 Proje Yönetimi & Süreç İyileştirme — Stratejik Birikim Listesi

> **Bu dokümanın amacı nedir?**
> Playbook'un açık kalan süreç ihtiyaçlarını, gelişim alanlarını ve dayanak okuma referanslarını kategorize etmektir. Kalıcı bir birikim listesidir; yürütülmekte olan yapısal düzeltmeler için bkz: [Denetim Raporu ve Düzeltme Planı](plans/review-action-plan.md).

> ⚠️ **Commit Hijyeni:** Bu listeye madde eklemek bir dokümanın yazılması değildir. Yalnızca bu dosyayı değiştiren commit'ler `chore:` öneki ile etiketlenir ve "doküman eklendi" beyanı içeremez. Bkz: [Dokümantasyon Standartları](docs/process/documentation-standards.md) §5.

## 1. Dokümantasyon, Kültür ve Sahiplik
- [x] **Çapraz Referanslar:** Dokümanlar arası atıflar tıklanabilir göreli bağlantılara çevrildi; kırık bağlantılar `make check-links` ile CI'da denetleniyor.
- [x] **Sahiplik (Ownership):** Her doküman `Doküman Sahibi` footer'ı taşıyor (`make check-meta` denetler); `CODEOWNERS` rol tabanlı olarak dolduruldu. *Kalan adım: yer tutucu rollerin gerçek kullanıcı adlarıyla değiştirilmesi ve Branch Protection aktivasyonu.*
- [x] **Uyum — Playbook Katmanı:** `scripts/check-docs.sh` ile kırık bağlantı, indeks boşluğu, eksik sahiplik, amaç bloğu ve katman kuralı (core teknoloji bağımsızlığı) ihlalleri her PR'da süreç durdurucu olarak denetleniyor.
- [ ] **Uyum — Ürün Depoları Katmanı:** DoD/DoR maddelerinin ürün depolarında otomatik denetlenmesi (secret taraması, linter, test, SCA/SAST) her depoda ayrıca kurulmalıdır. Bkz: [CI/CD](docs/process/ci-cd-deployment.md) §2.
- [x] **Önyargı Yönetimi (HIPPO):** [Karar Verme Yetkisi](docs/process/decision-making-authority.md) §3 ve §3.1 altında otorite atama/itiraz/geri alma prosedürü ile "karar hakkı gerekçe beyanı" zorunluluğu tanımlandı; kullanım sıklığı [metrik](docs/process/engineering-metrics.md) olarak izleniyor.

## 2. Eksik Süreçler ve Yeni Doküman İhtiyaçları
- [x] **Güvenlik ve Uyum (DevSecOps):** Veri gizliliği, sızma testi pratikleri ve güvenlik standartları (Örn: [TruffleHog](https://github.com/trufflesecurity/trufflehog) ile secret sızıntılarını engelleme).
- [x] **Mimari Karar Kayıtları (ADR):** Backend, veritabanı veya sistem mimarisi kararlarının nasıl alınacağı ve belgeleneceği için standart bir ADR şablonu oluşturmak.
- [ ] **Yedekleme ve Felaket Kurtarma (Backup & Disaster Recovery):** Veritabanı ve sistem yedekleme sıklığı, RPO/RTO hedefleri, otomatik snapshot süreçleri ve periyodik geri dönme (restore) test protokollerinin dokümante edilmesi (Örn: `docs/stacks/backend-db.md` veya bağımsız bir yönerge).
- [ ] **Kesinti Anında Ürün Davranışı ve Müdahale Stratejileri (Outage Mitigation & Runbooks):** Kesinti durumunda sistemin nasıl tepki vereceğini ve mühendislik müdahale hiyerarşisini belirlemek:
  - **Sürüm Geri Alma (Rollback):** Hangi durumlarda anında geri alma uygulanır, veritabanı migration içeren sürümlerde rollback sınırları nelerdir?
  - **Özellik Kapatma (Feature Flags / Kill Switch):** Hatanın yeni bir özellikten kaynaklandığı senaryolarda yeni deployment yapmadan özelliği anında devre dışı bırakma altyapısı.
  - **Kademeli/Kısıtlı Hizmet (Graceful Degradation & Degraded Mode):** Çöken/yavaşlayan modülleri (raporlama, arama, 3. parti entegrasyonlar vb.) izole edip ana akışı (login, ödeme, kritik kayıt) ayakta tutma.
  - **Devre Kesici (Circuit Breaker) & Fallback:** Harici servisler yanıt vermediğinde tüm uygulamanın kilitlenmesini engelleyen fallback mekanizmaları.
  - **Yük Kısma / Boşaltma (Load Shedding & Rate Limiting):** Aşırı yük veya trafik patlamalarında arka plan işlerini dondurup ana trafiğe öncelik verme.
  - **Bakım Modu (Maintenance Mode) & Kullanıcı İletişimi:** Sistem tamamen durduğunda 500 hatası yerine kullanıcıya anlamlı statik durum ve bilgilendirme ekranı sunma yönergeleri.
- [ ] **Maliyet Yönetimi ve Birim Ekonomi (FinOps & Cost Management):** Mühendislik ve altyapı maliyetlerinin nasıl hesaplanacağı, dokümante edileceği ve optimize edileceği standartlarını oluşturmak:
  - **Birim Maliyet Modeli (Unit Economics):** İşlem başına, kullanıcı başına (Cost per User / Tenant) veya istek başına maliyet hesaplama yöntemleri.
  - **Bulut ve Altyapı Maliyet Takibi (Cloud FinOps):** Sunucu, veritabanı, depolama ve veri transferi (egress) harcamalarının ortam/etiket (tagging) bazlı takibi ve bütçe aşım alarmları.
  - **3. Parti API ve Yapay Zeka (AI/LLM) Maliyetleri:** Harici API çağrıları, SMS/e-posta kotaları ve token kullanım maliyetlerinin izlenmesi ve limitlendirilmesi (Rate/Quota limits).
  - **Fırsat ve Özellik ROI Analizi:** Yeni bir özelliğin getireceği operasyonel/finansal fayda ile geliştirme + sürekli bakım maliyetinin karşılaştırılması.
  - **Atıl Kaynak Temizliği (Waste Reduction):** Kullanılmayan test ortamları, sahipsiz disk/snapshot ve fazla provizyonlanmış (over-provisioned) kaynakların periyodik temizlik rutini.

- [ ] **Nöbet Rotasyonu ve Alarm Politikası (On-Call & Paging):** [Olay Müdahale](docs/core/incident-response.md) dokümanı kriz rollerini tanımlamakta, ancak nöbet çizelgesini, alarm eşiklerini, eskalasyon zincirini ve telafi/izin kurallarını tanımlamamaktadır. Sev-1 durumunda mesai dışında kimin sorumlu olduğu belirsizdir.
- [ ] **SLO ve Hata Bütçesi (Error Budget):** P0/P1 sınıflandırmasının objektif dayanağını oluşturacak servis seviyesi hedefleri tanımlanmalıdır. Halihazırda severity ataması sezgiseldir.
- [ ] **Tahminleme, Kapasite ve Sprint Kadansı:** Sprint uzunluğu, kapasite hesaplama yöntemi ve taahhüt politikası tanımsızdır. DoR'daki "3 iş günü" kuralının bağlamı bu dokümanla oluşur.
- [ ] **API Sözleşme ve Versiyonlama Standardı:** API sözleşmesi değişikliği Seviye 2 karar olarak tanımlıdır; ancak versiyonlama yöntemi, geriye dönük uyumluluk kuralları ve kullanımdan kaldırma (deprecation) süreci belgelenmemiştir.
- [ ] **Terminoloji Sözlüğü (Glossary):** [Dokümantasyon Standartları](docs/process/documentation-standards.md) terminolojik tutarlılığı zorunlu kılmaktadır, ancak referans sözlük bulunmamaktadır.
- [ ] **Veri Saklama ve İmha Politikası:** KVKK uyumunda maskeleme ve izolasyon tanımlıdır; saklama süreleri, arşivleme ve imha prosedürleri eksiktir. [Özellik sonlandırma akışının](docs/core/product-philosophy.md) 4. aşaması bu politikaya bağımlıdır.
- [ ] **Offboarding ve Bilgi Devri:** "Anti-Kahramanlık" ilkesinin operasyonel karşılığı olan rotasyon, devir ve erişim iptali mekanizması tanımsızdır.

## 3. Geliştirici Deneyimi (DX) ve Otomasyon
- [x] **Bariyer Yorgunluğu — Şablon Katmanı:** PR şablonu, otomasyonla saptanabilen maddeleri listeden çıkardı; yalnızca **yargı gerektiren** maddeler manuel kaldı (`.github/pull_request_template.md`).
- [ ] **Bariyer Yorgunluğu — Ürün Deposu Katmanı:** Kalan DoD maddelerinin ürün depolarında gerçek CI kontrollerine bağlanması.
- [ ] **Performans Ölçümü (DORA):** Kurulan bu sistemi ölçmek için `engineering-metrics.md` altyapısını tasarlamak (Lead Time, Deploy Freq, CFR, MTTR gibi DORA metrikleri).
- [ ] **AI Kodlama Ajan Becerileri & Definition of Done (DoD) İncelemesi:**
  - **Kaynak:** [Addy Osmani - Definition of Done Reference](https://github.com/addyosmani/agent-skills/blob/main/references/definition-of-done.md)
  - **Kapsam:** AI kodlama ajanları için "Acceptance Criteria vs. Definition of Done" ayrımı, çalışma zamanı doğrulaması (runtime verification), test kapsamı, regresyon önleme ve ölü kod/debug çıktısı temizliği kriterlerinin incelenmesi; `docs/core/dod.md` ve AEGS Kapı Bekçisi ([`plans/agents-design.md`](plans/agents-design.md) §4.1) gereksinimlerine uyarlanması.
- [ ] **Ajan Kalite ve Güvenlik Referans Kontrol Listeleri (Agent Reference Checklists) İncelemesi:**
  - **Kaynak:** [Addy Osmani - Agent Skills Reference Checklists](https://github.com/addyosmani/agent-skills#reference-checklists)
  - **Kapsam:** Güvenlik (`security-checklist.md`), gözlemlenebilirlik (`observability-checklist.md`), erişilebilirlik (`accessibility-checklist.md`), test örüntüleri (`testing-patterns.md`) ve orkestrasyon örüntüleri (`orchestration-patterns.md`) referans kontrol listelerinin incelenmesi; kurumumuzun süreç standartları ([`docs/process/test-qa-strategy.md`](docs/process/test-qa-strategy.md), [`docs/process/telemetry-logging.md`](docs/process/telemetry-logging.md), [`docs/process/web-api-security-threat-matrix.md`](docs/process/web-api-security-threat-matrix.md)) ile karşılaştırılarak AI odaklı kural setlerine dönüştürülmesi.

## 4. Stratejik Karar Noktası
- [ ] Metrik altyapısını (DORA) kurmaya devam mı edeceğiz, yoksa mevcut playbook yapısını takıma sunma (roll-out) aşamasına mı geçeceğiz? Ekiple beraber karar verilmeli.

  **Mevcut değerlendirme (2026-08-31 denetimi):** DORA metriklerinin anlamlı olabilmesi süreçlerin fiilen işlemesine bağlıdır; henüz kimsenin uymadığı bir sürecin verisini toplamak ampirik kontrol sağlamaz. Bu nedenle önerilen sıra: **(1)** [Uygulama Profilleri](docs/core/profiles.md) ile kapsamın projeye göre daraltılması, **(2)** takıma roll-out, **(3)** nöbet rotasyonu ve SLO dokümanları, **(4)** DORA ölçüm altyapısı. Nihai karar ekibe aittir.

- [ ] **Bootstrap Mekanizması:** Deponun GitHub Template Repository olarak yapılandırılması ve profil seçimine göre gereksiz dokümanları kaldıran `scripts/init.sh` betiğinin yazılması. Bu adım tamamlanmadığı sürece her yeni proje manuel kopyalama ile başlar ve tecrübe geri akışı (feedback loop) kurulamaz.

---

## 📚 Okunacak Referans Dokümanlar ve Kitaplar

### 1. Kültür, İletişim ve Bilişsel Yük (Organizasyonel Mimari)
*(Playbook'taki `iletisim-ve-toplanti.md`, `yetkinlik-ve-raci.md` ve "Anti-Kahramanlık" kurallarının dayanağı.)*
* **Kitap:** *Team Topologies: Organizing Business and Technology Teams for Fast Flow* (Matthew Skelton, Manuel Pais).
* **Neden Okunmalı?** Bilişsel yükü (cognitive load) yönetmeyi, Conway Kanunu'nu lehinize çevirmeyi ve takımlar arası iletişim sürtünmesini (interaction modes) nasıl keseceğinizi anlatır.

* **Kitap:** *Radical Candor* (Kim Scott).
* **Neden Okunmalı?** PR incelemelerinde ve 1-on-1 toplantılarda "Kişiye değil işe saldırmak" felsefesini ve yapay bir nezaket (ruinous empathy) yerine doğrudan, empatik bir geri bildirim kültürünü kurmayı öğretir.

### 2. Sürekli Teslimat ve Metrikler (DevOps & CI/CD)
*(Playbook'taki `ci-cd-deployment.md`, `engineering-metrics.md` ve "Sıfır Kesinti" kurallarının dayanağı.)*
* **Kitap:** *Accelerate: The Science of Lean Software and DevOps* (Nicole Forsgren, Jez Humble, Gene Kim).
* **Neden Okunmalı?** DORA metriklerinin şirket karlılığını nasıl artırdığını kanıtlar. Metrik fetişizmine düşmeden sistemi nasıl ölçeceğinizi gösterir.

* **Kitap:** *The Phoenix Project* (Gene Kim, Kevin Behr, George Spafford).
* **Neden Okunmalı?** Bir BT projesindeki darboğazları (Theory of Constraints) ve plansız işlerin sistemi nasıl zehirlediğini roman formatında anlatır.

### 3. Kriz Yönetimi ve Dayanıklılık (Resilience)
*(Playbook'taki `incident-response.md` ve Hata Yönetimi kurallarının dayanağı.)*
* **Kitap/Makale:** *Site Reliability Engineering (SRE) - Google* (Özellikle Bölüm 15: Postmortem Culture). *(Ücretsiz okunabilir)*
* **Neden Okunmalı?** "İnsan hatası bir kök neden değildir" felsefesini ve Hata Bütçelerini (Error Budgets) Google'ın nasıl yönettiğini gösterir.

### 4. Müşteri Bariyeri ve Talep Filtreleme (Product Triage)
*(Playbook'taki `triage.md` ve "XY Problemi" kurallarının dayanağı.)*
* **Kitap:** *The Mom Test* (Rob Fitzpatrick).
* **Neden Okunmalı?** Müşteriyle konuşurken doğru soruları nasıl soracağınızı öğretir. Triage toplantılarının can damarıdır.

* **Kitap:** *Escaping the Build Trap* (Melissa Perri).
* **Neden Okunmalı?** Şirketin bir "Özellik Fabrikasına" (Feature Factory) dönüşmesini engellemeyi ve çıktılara (output) değil, sonuçlara (outcome) odaklanmayı anlatır.

### 5. Sistem Düşüncesi ve Teknik Takas (Trade-off)
*(Playbook'taki `urun-felsefesi.md` ve `rfc-guncelleme-protokolu.md` mimarisinin dayanağı.)*
* **Kitap:** *Fundamentals of Software Architecture* (Mark Richards, Neal Ford).
* **Neden Okunmalı?** Mimari kararların bir "doğrusu" olmadığını, sadece "Trade-off" (Takas) olduğunu gösterir. (Örn: Hız vs. Güvenlik).

* **Makale/Blog:** *Martin Fowler - "YAGNI" (You Aren't Gonna Need It) ve "Technical Debt"*.
* **Neden Okunmalı?** Erken optimizasyon (over-engineering) hastalığını ve teknik borcun ne zaman stratejik bir araç, ne zaman bir zehir olduğunu tanımlar.

### 6. Yapay Zeka Ajanları ve Otonom Mühendislik Becerileri (Agentic Coding & Quality Gates)
*(Playbook'taki `docs/core/ai-manifesto.md`, `docs/core/dod.md` ve `plans/agents-design.md` mimarisinin dayanağı.)*
* **Doküman & Depo:** *Agent Skills: Production-grade engineering skills for AI coding agents* (Addy Osmani).
  * [Definition of Done Reference](https://github.com/addyosmani/agent-skills/blob/main/references/definition-of-done.md)
  * [Reference Checklists](https://github.com/addyosmani/agent-skills#reference-checklists)
* **Neden Okunmalı?** AI kodlama ajanlarının en kısa yoldan kod üretip kalite, güvenlik ve doğrulama adımlarını atlamasını ("vibe coding") önlemek için geliştirilmiş kıdemli mühendislik iş akışlarını, test ve çalışma zamanı doğrulama kriterlerini ve paylaşılan kalite kontrol listelerini (güvenlik, gözlemlenebilirlik, erişilebilirlik vb.) inceler. AEGS otonom denetçi ajanlarının kurallarını ve Playbook kontrol kapılarını zenginleştirmek için doğrudan referans alınacaktır.

---

*Son Güncelleme: 2026-09-03 — Doküman Sahibi: Engineering Manager*
