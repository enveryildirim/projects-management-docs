# 00-Oryantasyon ve Sistem Kurulum Rehberi

> **Dokümanın Amacı**
> İşbu doküman, ekibimize yeni katılan mühendislerin ilk gün, ilk hafta ve ilk ay periyotlarındaki oryantasyon sürecini, sistem kurulum adımlarını ve ilk kod değişikliklerinin (PR) canlı ortama (production) aktarılma prosedürlerini standartlaştırmaktadır. Temel hedefimiz; kapsamlı dokümantasyon yükünden kaçınarak, yeni ekip üyelerinin **en geç 48 saat içerisinde ilk PR süreçlerini tamamlayıp canlı ortama (production) kod sevk etmelerini** sağlamaktır.

> 💡 **Tek Gerçeklik Kaynağı:** Oryantasyon sürecinin tanımlandığı tek resmî doküman işbu belgedir. Yerel kurulumun ayrıntılı komut dizisi ve sorun giderme (troubleshooting) tabloları için [Yerel Geliştirme Ortamı Kurulum Rehberi](./local-setup.md) eki referans alınır; ancak süreç sıralamasında bu doküman esastır.

---

## 1. Gün: Sistem Felsefesi ve Erişim Kontrolleri

İlk iş gününde doğrudan kodlama veya yerel geliştirme ortamı (local environment) kurulumuna başlanmamalıdır. Öncelikli amaç; kurumumuzun teknik işleyiş prensiplerini özümsemek ve gerekli sistem erişimlerinin tahsis edildiğini doğrulamaktır.

### 1. Temel Okuma Listesi

Bilişsel yükü optimize etmek amacıyla, tüm Playbook dokümantasyonunun tek seferde incelenmesi beklenmemektedir. İlk gün yalnızca aşağıdaki üç temel dokümanın okunması zorunludur:

1. [Ürün Felsefesi](../core/product-philosophy.md) (Ürün geliştirme gerekçeleri, süreçlerimiz ve özellik sonlandırma prensiplerimiz)
2. [İletişim ve Toplantı Manifestosu](./communication-and-meetings.md) (Kurumsal iletişim protokolleri ve toplantı katılım/ret standartları)
3. [Yapay Zeka Manifestosu](../core/ai-manifesto.md) (Yapay zeka araçlarının kullanımına ilişkin kurumsal güvenlik ve uyum sınırları)

### 2. Erişim Kontrolleri

Aşağıda belirtilen platformlara erişiminizin sağlanmadığı durumlarda, kurum içi iletişim kanalları (Slack/Teams) üzerinden ilgili Otorite veya Tech Lead ile iletişime geçmeniz gerekmektedir:

* [ ] GitHub / GitLab (Repository yetkilendirmesi)
* [ ] Jira / Linear (Proje yönetim panosu yetkilendirmesi)
* [ ] Vercel / AWS / Cloudflare (Sistem loglarına erişim yetkisi)
* [ ] Geliştirici ortamı lisans tahsisleri (Örn: Cursor Pro, Copilot)

---

## 2. Gün: Otomatize Edilmiş Yerel Kurulum (Local Setup)

Ortamlar arası tutarsızlıkları ("Benim lokalimde çalışıyor" vakalarını) elimine etmek amacıyla, projelerimizde Docker ve otomasyon betikleri (scripts) standart olarak kullanılmaktadır. Kurulumda **öncelikli yöntem otomasyon betiğidir**; manuel adım dizisi yalnızca otomasyonun başarısız olduğu durumlarda geri dönüş (fallback) olarak uygulanır ve bu durum bir hata kaydı (issue) ile raporlanır.

### 1. Sistem Bağımlılıkları

Kişisel iş istasyonunuzda yalnızca aşağıdaki temel bileşenlerin kurulu olması yeterlidir:

* Git
* Docker Desktop (alternatif olarak OrbStack veya Colima)
* Node.js (`nvm` veya `fnm` araçları kullanılarak) & `pnpm`

### 2. Otomatik Kurulum (Automated Setup)

Proje deposu (repository) yerel ortama kopyalandıktan (clone) sonra, kök dizin üzerinden aşağıdaki komut çalıştırılmalıdır. İlgili komut; bağımlılıkların indirilmesini, `.env` konfigürasyon dosyasının şablon üzerinden oluşturulmasını, DLP/Güvenlik kancalarının (Husky vb.) entegrasyonunu ve veritabanı konteynerinin başlatılmasını otomatize eder.

```bash
git clone <repo-url>
cd <proje-klasoru>
make setup  # veya pnpm run setup
```

*Not: `.env` dosyası içerisinde yer alan bazı API anahtarlarının eksik olması halinde, mimari "mock-first" prensibiyle tasarlandığından, sentetik (mock) verilerle geliştirmeye devam edilmelidir.*

> ⚠️ **Otomasyon Başarısız Olursa:** `make setup` komutu hata verirse, [Yerel Kurulum Rehberi](./local-setup.md) §2'deki manuel adım dizisi ve §4'teki sorun giderme tablosu uygulanır. Manuel kuruluma başvurulması, otomasyon betiğinde giderilmesi gereken bir kusur bulunduğu anlamına gelir; ilgili durum DevOps Otoritesine bildirilmelidir.

### 3. Geliştirme Sürecinin Başlatılması

Veritabanı migrasyonlarının (migration) başarıyla tamamlandığını ve yerel sunucunun aktif hale geldiğini doğrulamak için aşağıdaki komut çalıştırılmalıdır:

```bash
make dev  # veya pnpm run dev
```

Uygulamanın `localhost:3000` portu üzerinden herhangi bir hata olmaksızın erişilebilir durumda olması beklenmektedir.

---

## 3. Gün: İlk Pull Request (PR) ve İş Akışı Deneyimi

Üçüncü günün odak noktası mimari derinlikten ziyade, Sürekli Dağıtım (Continuous Deployment) boru hattının (pipeline) işleyişini pratik olarak deneyimlemektir.

1. **Danışman (Buddy) Ataması ve Görev Seçimi:** Yetkinlik matrisine ([Yetkinlik Matrisi](./competency-matrix.md)) istinaden atanmış olan "Buddy/Mentor" ile kısa bir koordinasyon toplantısı gerçekleştirilmelidir. Ardından proje yönetim aracı (Jira/Linear) üzerinden, yeni başlayanlara uygun ("Good First Issue" etiketli) basit bir görev (Örn: tipografik düzeltme, ufak bir arayüz güncellemesi) üstlenilmelidir.
2. **Süreç Regülasyonlarının İncelenmesi:** Geliştirme sürecine başlanmadan önce kalite kontrol kriterleri okunmalıdır:
* [DoR — Geliştirmeye Hazır Kriterleri](../core/dor.md) (İlgili görev geliştirilmeye hazır mı?)
* [DoD — Bitti Kriterleri](../core/dod.md) (Görev tamamlandığında sağlanması gereken asgari koşullar nelerdir?)

3. **Çalışma Dalı (Branch) Oluşturma ve Geliştirme:** Görev için `feat/ilk-gorevim` isimlendirme standardına uygun bir çalışma dalı oluşturulmalıdır. Kurumsal yapay zeka destekli kodlama standartları çerçevesinde geliştirme tamamlanmalıdır.
4. **Güvenlik Bariyerleri ve Doğrulama:** Kod deposuna gönderim (commit) işlemi denendiğinde, kurumsal `pre-commit` kancalarının (TruffleHog, linter vb.) aktif olarak denetim yaptığından emin olunmalıdır.
5. **PR Oluşturma ve Önizleme (Preview) Süreci:** GitHub/GitLab üzerinden Pull Request (PR) talebi oluşturulur.
* `CODEOWNERS` konfigürasyonunun ilgili Buddy'yi otomatik olarak İnceleyen (Reviewer) şeklinde atadığı doğrulanmalıdır.
* CI/CD otomasyon botunun, ilgili PR için izole bir "Geçici Önizleme URL'si" (Preview) oluşturması beklenmelidir.

6. **Canlı Ortama Aktarım (Deploy):** PR onay süreçleri tamamlanıp kod `main` dalına birleştirildiğinde (merge), değişikliklerin doğrudan üretim ortamına (production) otomatik aktarım süreci takip edilmelidir (Bkz: [CI/CD ve Dağıtım Stratejisi](./ci-cd-deployment.md)).

## 1. Hafta: Operasyonel Süreçlerin Kavranması

İlk üç günün ardından haftanın kalanında hedef, kalite kapılarının (DoR/DoD) ve karar mekanizmalarının pratikte deneyimlenmesidir.

- [ ] **Süreç Adaptasyonu:** [DoR](../core/dor.md), [DoD](../core/dod.md) ve [Karar Verme Yetkisi](./decision-making-authority.md) dokümanları okunmuştur.
- [ ] **Kalite Kapısı Deneyimi:** İlk PR'ın CI/CD denetimlerinden (secret taraması, linter, test) geçişi gözlemlenmiş; en az bir denetimin bilinçli olarak başarısız kılınarak bariyerin fiilen çalıştığı doğrulanmıştır.
- [ ] **Önceliklendirme Dili:** [P0-P4 Önceliklendirme Çerçevesi](../core/p0-p4-prioritization.md) ve [Triage Prosedürü](../core/triage.md) incelenmiştir.
- [ ] **Ekip Tanışması:** Kurum içi iletişim kanalında (`#general`) kısa bir tanıtım mesajı paylaşılmıştır.

## 1. Ay: Otonomi ve Görev Sahipliği

Birinci ayın tamamlanmasıyla mühendislerimizin uçtan uca özellik geliştirme süreçlerini bağımsız olarak yürütebilmeleri beklenmektedir.

- [ ] **Mimari Hakimiyet:** Müşteri talep döngüsü ([Triage](../core/triage.md)) bütünüyle kavranmış; projenin dizin yapısına ve teknoloji yığınına (Bkz: [Stacks](../stacks/README.md)) hakimiyet sağlanmıştır.
- [ ] **Özellik Sahipliği:** Orta ölçekli bir özellik geliştirme süreci uçtan uca üstlenilmiş; geliştirme, test yazımı ve canlıya alma aşamaları tamamlanmıştır.
- [ ] **Yetkinlik Konumlandırması:** [Yetkinlik Matrisi](./competency-matrix.md) üzerinde ilgili teknik alanlardaki seviye (Öğrenen / Geliştirici / Uzman) Tech Lead ile birlikte güncellenmiştir.
- [ ] **Geri Bildirim Süreci:** Teknik Lider ile birebir (1-on-1) değerlendirme toplantısı gerçekleştirilerek oryantasyon süreci analiz edilmiş ve Playbook'a ilişkin geri bildirimler iletilmiştir. Playbook'ta iyileştirme önerisi bulunuyorsa [RFC süreci](./rfc-update-protocol.md) işletilir.

---

> 🎉 **Süreç Tamamlama Bildirimi:** Belirtilen adımların eksiksiz uygulanması neticesinde, kodunuz üretim ortamında aktif hale gelmiştir. İlerleyen süreçlerde, teknik mimari kararlar, arayüz (UI) standartları ve test stratejileri (Bkz: Aşama 3 Dokümanları) gibi hususlar için Playbook dokümantasyonu referans alınmalıdır.

---

*Son Güncelleme: 2026-08-31 — Versiyon 2.0 — Doküman Sahibi: Engineering Manager / Tech Lead*
