# 00-Onboarding ve Kurulum Rehberi

> **Bu doküman ne işe yarar?**
> Ekibe yeni katılan bir mühendisin ilk 3 gününde ne okuyacağını, sistemini nasıl kuracağını ve ilk kodunu (PR) canlıya nasıl alacağını adım adım tanımlar. Amacımız seni dokümanlara boğmak değil, **maksimum 48 saat içinde ilk PR'ını açıp canlıya (production) göndermeni** sağlamaktır.

---

## Gün 1: Sistem Felsefesi ve Erişimler

İlk gün kod yazmaya çalışmayın, yerel ortam kurmakla vakit kaybetmeyin. Sadece oyunun kurallarını anlayın ve hesap erişimlerinizi doğrulayın.

### 1. Temel Okuma Listesi (Sadece Bunları Okuyun)

Tüm playbook'u tek seferde okumak bilişsel yük yaratır. Bugün sadece şu üç anayasayı okuyun:

1. `urun-felsefesi.md` (Neyi, neden yapıyoruz ve ne zaman siliyoruz?)
2. `iletisim-ve-toplanti.md` (Nasıl iletişim kuruyoruz? Toplantı ret hakkınız nedir?)
3. `ai-manifesto.md` (Yapay zekayı kullanırken kırmızı çizgilerimiz nelerdir?)

### 2. Erişim Kontrolü

Aşağıdaki platformlara davet edilmediyseniz, Slack/Teams üzerinden Otoriteye (veya Tech Lead'inize) ulaşın:

* [ ] GitHub / GitLab (Repo erişimi)
* [ ] Jira / Linear (Board erişimi)
* [ ] Vercel / AWS / Cloudflare (Logları okuma yetkisi)
* [ ] Geliştirici ortamı için gerekli lisanslar (Örn: Cursor Pro, Copilot)

---

## Gün 2: Çalıştırılabilir Kurulum (Local Setup)

"Benim makinemde çalışıyor" bahanesini yok etmek için projemiz Docker ve otomasyon betikleri (scripts) kullanır. Manuel yapılandırmadan kaçının.

### 1. Bağımlılıklar

Makinenizde yalnızca şunların kurulu olduğundan emin olun:

* Git
* Docker Desktop (veya OrbStack/Colima)
* Node.js (Tercihen `nvm` veya `fnm` ile) & `pnpm`

### 2. Tek Komutla Kurulum (Automated Setup)

Proje reposunu klonladıktan sonra kök dizinde aşağıdaki komutu çalıştırın. Bu komut; bağımlılıkları indirir, `.env` dosyasının bir kopyasını oluşturur, DLP/Güvenlik kancalarını (Husky) kurar ve veritabanı konteynerini ayağa kaldırır.

```bash
git clone <repo-url>
cd <proje-klasoru>
make setup  # veya pnpm run setup

```

*Not: Eğer `.env` içindeki bazı API anahtarları eksikse, sahte verilerle (mock) sistemi çalıştırmaya devam edin. Sistem mock-first tasarlanmıştır.*

### 3. Geliştirme Sürecini Başlatma

Veritabanı migration'larının ve lokal sunucunun ayağa kalktığını doğrulayın:

```bash
make dev  # veya pnpm run dev

```

Sistem `localhost:3000` üzerinde hatasız açılmalıdır.

---

## Gün 3: İlk Pull Request (PR) ve İş Akışı Deneyimi

Bugünün amacı mimariyi öğrenmek değil, boru hattının (pipeline) nasıl çalıştığını deneyimlemektir (Sürekli Dağıtım pratiği).

1. **Buddy ve Görev Seçimi:** Yetkinlik matrisine (`yetkinlik-ve-etki-alani.md`) göre atanan "Buddy/Mentor"unuz ile kısa bir görüşme yapın. Jira/Linear board üzerinden sizin için ayrılmış, "Good First Issue" etiketli basit bir görevi (Örn: typo düzeltmesi, basit bir UI güncellemesi) üzerinize alın.
2. **Süreç Okuması:** İşe başlamadan önce giriş ve çıkış kapılarını okuyun:
* `dor.md` (Bu görev kodlanmaya hazır mı?)
* `dod.md` (İşi bitirdiğimde hangi şartları sağlamalıyım?)


3. **Dal (Branch) Açma ve Kodlama:** `feat/ilk-gorevim` adında bir branch açın. AI destekli kodlama kurallarına uyarak görevi tamamlayın.
4. **Güvenlik Bariyeri:** Commit atmayı deneyin. Kurduğumuz `pre-commit` hook'ların (TruffleHog, linter) çalıştığını gözlemleyin.
5. **PR Açma ve Önizleme (Preview):** GitHub üzerinden PR açın.
* `CODEOWNERS` dosyasının Buddy'nizi otomatik Reviewer atadığını görün.
* CI/CD botunun PR için özel bir "Geçici Önizleme URL'si" (Preview) oluşturmasını bekleyin.


6. **Canlıya Çıkış (Deploy):** PR onaylandıktan ve `main` dalına merge edildikten sonra kodunuzun doğrudan canlıya (production) aktarılışını izleyin (`ci-cd-deployment.md`).

> 🎉 **Tebrikler.** Artık kodunuz üretim ortamında çalışıyor. Teknik mimari kararlar, UI standartları ve test stratejileri (Bkz: Aşama 3 Dokümanları) için ihtiyaç duydukça playbook'a başvurabilirsiniz.

---

*Son güncelleme: 2026-08-29 — Sahibi: Engineering Manager*
