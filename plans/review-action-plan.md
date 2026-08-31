# Playbook Denetim Raporu ve Düzeltme Planı (2026-08-31)

> **Bu dokümanın amacı nedir?**
> 31 Ağustos 2026 tarihinde Playbook üzerinde gerçekleştirilen yapısal denetimin (review) bulgularını ve bu bulgulara karşılık gelen somut düzeltme görevlerini kayıt altına almaktır. Doküman, düzeltmeler tamamlandığında arşivlenecek geçici bir çalışma planıdır; kalıcı stratejik birikim listesi için [TODO.md](../TODO.md) esas alınmalıdır.

---

## Faz 0 — Yapısal Bütünlük (Framework'ün Güvenilirliği)

Bu fazın gerekçesi: dokümantasyonun kendi indeksi ve iç atıfları çalışmadığı sürece içerik kalitesinin bir anlamı bulunmamaktadır.

- [x] **F0.1 — İndeks Onarımı:** `README.md` içerisindeki 22 adet `google.com/search?q=...` formatındaki sahte bağlantı, gerçek göreli (relative) yollara çevrilecektir.
- [x] **F0.2 — Yol Hatalarının Giderilmesi:** İndekste hatalı konumlanmış 5 doküman yolu düzeltilecektir (`00-onboarding`, `rfc-update-protocol`, `ci-cd-deployment`, `test-qa-strategy`).
- [x] **F0.3 — İndeks Boşluklarının Kapatılması:** İndekste hiç yer almayan 6 doküman eklenecektir (`vision-board`, `onboarding-and-setup`, `telemetry-logging`, `documentation-standards`, `local-setup`, `backend-db`).
- [x] **F0.4 — Kırık İç Atıflar:** 5 adet kırık doküman içi bağlantı onarılacak; silinmiş `musteri-talep-rehberi.md` atıfları `triage.md` olarak güncellenecektir.
- [x] **F0.5 — README İddialarının Dürüstleştirilmesi:** Mevcut olmayan altyapıya (OPA/Conftest, Gatekeeper botları, `scripts/`) atıf yapan tanıtım metni, gerçekleşme durumunu şeffaf biçimde gösteren bir olgunluk tablosuyla değiştirilecektir.

## Faz 1 — Çelişkilerin Giderilmesi (Tek Gerçeklik Kaynağı)

- [x] **F1.1 — Onboarding Tekilleştirmesi:** Kök dizindeki `00-onboarding.md` ile `docs/process/onboarding-and-setup.md` çelişen talimatlar vermektedir (1. gün kurulum yapılsın / yapılmasın). İki doküman `docs/process/onboarding-and-setup.md` altında birleştirilecek, kök dizindeki dosya kaldırılacaktır.
- [x] **F1.2 — Kurulum Yönteminin Tekilleştirilmesi:** `local-setup.md` (manuel adımlar) ile `onboarding-and-setup.md` (`make setup` zorunluluğu) çelişkisi giderilecek; `local-setup.md` otomasyonun başarısız olduğu durumlar için "manuel geri dönüş (fallback) ve sorun giderme eki" olarak yeniden konumlandırılacaktır.
- [x] **F1.3 — Severity Etiketi:** `test-qa-strategy.md` içerisindeki "E2E yalnızca P1 (Çok Kritik)" ifadesi, `p0-p4-prioritization.md` ile uyumlu hale getirilecektir (Kritik = P0).
- [x] **F1.4 — Post-Mortem Atfı:** `ci-cd-deployment.md` §5.3 içerisindeki post-mortem atfı `communication-and-meetings.md` yerine `incident-response.md` olarak düzeltilecektir.
- [x] **F1.5 — DoR ve DORA Uyumu:** DoR'daki "azami 3 iş günü" kuralı ile DORA "Lead Time < 1 gün" hedefi arasındaki çelişki, görev parçalama kuralının netleştirilmesiyle giderilecektir.
- [x] **F1.6 — AR-GE Kapasitesinin Ölçülmesi:** `product-philosophy.md` §6.1'de tanımlı %10 AR-GE tahsisi `engineering-metrics.md` içerisinde izlenen bir metrik haline getirilecektir.
- [x] **F1.7 — Riskli Mutlak Kuralın Yumuşatılması:** "30 gün içinde doğrulanmayan özellik kalıcı olarak silinir" kuralı, B2B sözleşme riski nedeniyle kademeli sonlandırma (deprecate → sunset → arşiv) akışına dönüştürülecektir.

## Faz 2 — Framework'ün Kendi Standardına Uyumu

- [x] **F2.1 — Dizin Standardı:** `documentation-standards.md` §6'da tanımlı `/playbook/01-kultur-ve-zihniyet/...` yapısı, fiilen kullanılan `docs/core|process|stacks` yapısıyla değiştirilecektir.
- [x] **F2.2 — Klasör İndeksleri:** `docs/core/`, `docs/process/` ve `docs/stacks/` dizinlerine, standardın zorunlu kıldığı `README.md` indeks dosyaları eklenecektir.
- [x] **F2.3 — Footer Eksikleri:** Sahiplik ve versiyon bilgisi (footer) taşımayan 12 doküman standarda uygun hale getirilecektir.
- [x] **F2.4 — Doküman Ayrıştırması:** 3 adet H1 başlığı ve iki bağımsız konuyu barındıran `competency-matrix.md`, `competency-matrix.md` ve `raci-matrix.md` olarak ikiye ayrılacaktır.
- [x] **F2.5 — Numaralandırma:** `decision-making-authority.md` içerisindeki bölüm numaralandırma boşluğu (1, 2, 4) giderilecektir.
- [x] **F2.6 — Teknoloji Sızıntısı:** Teknoloji bağımsız olması gereken `docs/core/` dizinindeki yığın-spesifik ifadeler (ESLint, Prettier, `console.log`, Next.js, Tailwind, husky, faker.js) soyutlanacak; somut araç isimleri `docs/stacks/` altına taşınacaktır.
- [x] **F2.7 — Boş Dosya:** İçeriği bulunmayan `docs/stacks/backend-db.md`, kapsamı ve sahibi tanımlı resmi bir taslağa dönüştürülecektir.
- [x] **F2.8 — Plan Dokümanının Temizlenmesi:** `plans/agents-design.md` içerisindeki ham yapay zeka diyalog artefaktları ("Red Teaming", "Elevation (ZPD)", onay soruları) kaldırılacak ve doküman standart formata alınacaktır.

## Faz 3 — Uygulama Katmanı (Policy-as-Code Çekirdeği)

Bu fazın gerekçesi: `TODO.md` içerisindeki "Bariyer Yorgunluğu" ve "Uyum (Compliance) Ölçümü" maddelerinin çözümü, DoD/DoR maddelerinin manuel onay kutularından otomatik denetimlere taşınmasıdır.

- [x] **F3.1 — Denetim Betiği:** `scripts/check-docs.sh` oluşturulacaktır. Kırık bağlantıları, indeks boşluklarını, eksik footer'ları ve boş dosyaları denetler.
- [x] **F3.2 — Makefile:** Boş durumdaki `Makefile`, çalıştırılabilir hedeflerle (`check`, `check-links`, `check-index`, `new-adr`) doldurulacaktır.
- [x] **F3.3 — CI Denetimi:** `.github/workflows/docs-check.yml` ile denetim betiği her PR'da süreç durdurucu (blocking) kontrol olarak çalıştırılacaktır.
- [x] **F3.4 — PR Şablonu:** `.github/pull_request_template.md`, DoD kriterleri ve AI Manifestosu'nun "Prompt Şeffaflığı" maddesi baz alınarak oluşturulacaktır.
- [x] **F3.5 — Issue Şablonları:** `.github/ISSUE_TEMPLATE/` altında DoR ve Triage formatlarına uyumlu şablonlar oluşturulacaktır.
- [x] **F3.6 — CODEOWNERS:** Boş durumdaki `CODEOWNERS` dosyası, Yetkinlik Matrisi ile eşleşen rol tabanlı bir şablona dönüştürülecektir.
- [x] **F3.7 — ADR Arşivi:** `docs/adr/` dizini ve indeksi oluşturulacak; şablonun kullanımını örneklendiren ilk gerçek ADR kaydı yazılacaktır.

## Faz 4 — Ölçeklendirme (Framework'ün Devreye Alınabilirliği)

- [x] **F4.1 — Uygulama Profilleri:** `docs/core/profiles.md` oluşturulacak; Lite / Standard / Regulated profilleri ve her profilde zorunlu doküman kümesi tanımlanacaktır. Her dokümanın başlığına ilgili profil etiketi eklenecektir.
- [x] **F4.2 — Otorite Atama Prosedürü (HIPPO):** Eskalasyonun unvana (Tech Lead / EM) geri dönmesi, "unvan değil yetkinlik" felsefesiyle çelişmektedir. Otorite atama, itiraz ve geri alma prosedürü `decision-history` gerekçe zorunluluğu ile birlikte tanımlanacaktır.
- [ ] **F4.3 — Bootstrap Mekanizması:** Depo GitHub Template Repository olarak yapılandırılacak ve profil seçimine göre gereksiz dokümanları kaldıran `scripts/init.sh` betiği yazılacaktır. *(Bu madde `TODO.md` §4 stratejik kararına bağlıdır.)*

## Faz 5 — İçerik Boşlukları (Yeni Doküman İhtiyaçları)

> ℹ️ **Durum:** Bu fazdaki maddeler bilinçli olarak açık bırakılmıştır. Yeni yönerge yazımı, mevcut yönergelerin ekip tarafından benimsenmesinden sonra ele alınmalıdır; aksi halde doküman hacmi benimseme oranından hızlı büyür. Maddeler [TODO.md](../TODO.md) altında kalıcı birikim listesine taşınmıştır.

Etki sırasına göre listelenmiştir. Detaylı kapsam tanımları için bkz. [TODO.md](../TODO.md).

- [ ] **F5.1 — Nöbet Rotasyonu ve Alarm Politikası (On-Call & Paging):** `incident-response.md` kriz rollerini tanımlamakta ancak nöbet çizelgesini, alarm eşiklerini ve telafi kurallarını tanımlamamaktadır.
- [ ] **F5.2 — SLO ve Hata Bütçesi (Error Budget):** P0/P1 sınıflandırmasının objektif dayanağını oluşturacak servis seviyesi hedefleri tanımlanmalıdır.
- [ ] **F5.3 — Tahminleme, Kapasite ve Sprint Kadansı:** Sprint uzunluğu, kapasite hesabı ve taahhüt politikası tanımsızdır.
- [ ] **F5.4 — API Sözleşme ve Versiyonlama Standardı:** API değişikliği Seviye 2 karar olarak tanımlıdır; ancak versiyonlama yöntemi belgelenmemiştir.
- [ ] **F5.5 — Terminoloji Sözlüğü (Glossary):** `documentation-standards.md` terminolojik tutarlılığı zorunlu kılmakta, ancak referans sözlük bulunmamaktadır.
- [ ] **F5.6 — Veri Saklama ve İmha Politikası:** KVKK uyumunda maskeleme tanımlıdır; saklama süresi ve imha süreçleri eksiktir.
- [ ] **F5.7 — Offboarding ve Bilgi Devri:** "Anti-Kahramanlık" ilkesinin operasyonel karşılığı olan rotasyon ve devir mekanizması tanımsızdır.
- [ ] **F5.8 — Yedekleme/Felaket Kurtarma, Kesinti Müdahalesi ve FinOps:** `TODO.md` §2 altında kapsamı tanımlanmış durumdadır.

---

## Denetim Bulgusu: Commit Hijyeni

`74fbf26` ve `eba3149` commit'leri "Add/Expand documentation" ifadesiyle doküman eklendiğini beyan etmekte, ancak yalnızca `TODO.md` dosyasını değiştirmektedir. Bu durum `git log` üzerinden yürütülecek kurumsal hafıza aramalarını yanıltmaktadır.

- [x] **F6.1 — Commit Mesajı Standardı:** Yalnızca birikim listesine (backlog) madde ekleyen değişiklikler `docs:` veya `chore:` öneki ile ve "eklendi" beyanı içermeyecek şekilde etiketlenmelidir. İlgili kural `documentation-standards.md` içerisine işlenecektir.

## Uygulama Özeti (2026-08-31)

Faz 0-4 ve Faz 6 tamamlanmıştır. Faz 5 (yeni doküman ihtiyaçları) ile Faz 4.3 (bootstrap mekanizması) açıktır.

**Yapısal değişiklikler:**
* Kaldırılan: `00-onboarding.md` (kök, çelişkili ikinci onboarding), `docs/process/competency-and-raci.md` (iki konu tek dosyada)
* Eklenen doküman: `docs/core/profiles.md`, `docs/core/README.md`, `docs/process/README.md`, `docs/stacks/README.md`, `docs/adr/README.md`, `docs/adr/0001-trunk-based-development.md`, `docs/process/competency-matrix.md`, `docs/process/raci-matrix.md`
* Eklenen otomasyon: `scripts/check-docs.sh`, `scripts/new-adr.sh`, `Makefile`, `CODEOWNERS`, `.github/pull_request_template.md`, `.github/ISSUE_TEMPLATE/` (2 şablon), `.github/workflows/docs-check.yml`

**Denetim kapsamı (`make check`):** kırık iç bağlantı · sahte arama bağlantısı · indeks boşluğu · sahiplik footer'ı · amaç bloğu · tek H1 kuralı · katman kuralı (core teknoloji bağımsızlığı) · boş dosya. Denetim negatif test ile doğrulanmıştır (enjekte edilen ihlaller yakalanmakta, çıkış kodu 1 dönmektedir).

**Kurulum için kalan manuel adımlar:**
- [ ] `CODEOWNERS` içerisindeki `@rol` yer tutucuları gerçek GitHub kullanıcı/ekip adlarıyla değiştirilecektir.
- [ ] Depo ayarlarından Branch Protection → "Require review from Code Owners" aktive edilecektir.
- [ ] `docs/process/competency-matrix.md` içerisindeki örnek isimler (Ali/Ayşe/Can/Zeynep) gerçek ekip üyeleriyle değiştirilecektir.

---
*Son Güncelleme: 2026-08-31 — Versiyon 1.1 — Doküman Sahibi: Engineering Manager*
