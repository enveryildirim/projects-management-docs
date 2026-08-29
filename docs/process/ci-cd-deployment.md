# CI/CD ve Dağıtım (Deployment) Stratejisi

> **Bu doküman ne işe yarar?**
> Yazılan kodun, geliştiricinin bilgisayarından çıkıp hastane sunucularına güvenle, otomatik ve kesintisiz şekilde ulaşmasını sağlayan boru hattının (pipeline) kurallarını tanımlar.

---

**Amacımız:** "Cuma günü canlıya çıkılmaz" korkusunu bitirmek. İnsan hatasını ortadan kaldırarak kodun üretim (production) ortamına aktarımını tamamen otomatize etmek ve acil durumlarda tek tuşla güvenli geri alma (rollback) sağlamak.

## 1. Versiyon Kontrol ve İzole Önizleme (Preview) Akışı

Projemizde "Staging" darboğazını ve karmaşık GitFlow'u tamamen reddeden **Gerçek Trunk-Based Development** modelini kullanıyoruz.

| Branch Adı | Amacı | Kurallar |
| --- | --- | --- |
| `main` | Canlı Ortam (Production) | Doğrudan commit atılamaz. Sadece doğrulanmış PR'lar merge edilebilir. `main` dalı her zaman **canlıya çıkılabilir (deployable)** durumdadır. |
| `feat/x`, `fix/y` | Geliştirme ve Önizleme | Geliştirici kendi işi için açar. PR açıldığı an bu dala özel **Geçici Önizleme Ortamı (Preview Deployment)** otomatik ayağa kalkar. |

*(Not: Ortak ve statik bir `staging` dalı **yoktur**. Manuel QA testleri doğrudan PR'ın Preview URL'si üzerinden yapılır.)*

## 2. Sürekli Entegrasyon ve Güvenlik (CI - Continuous Integration)

Bir PR açıldığı an, GitHub Actions botu devreye girer. Aşağıdaki adımlardan biri bile başarısız olursa PR bloke edilir:

* [ ] **DLP ve Sır Taraması (Shift-Left Security):** TruffleHog/GitGuardian çalışır. Koda sızmış bir API anahtarı, `faker.js` ile üretilmemiş gerçek hasta verisi veya TC Kimlik numarası varsa PR derhal reddedilir (Bkz: `ai-manifesto.md`).
* [ ] **Linter ve Ölü Kod Kontrolü:** AI'ın ürettiği kullanılmayan fonksiyonlar, ESLint ve Prettier uyarıları taranır.
* [ ] **Birim ve Entegrasyon Testleri:** İş mantığını ve Yatay Yetki Yükseltme (IDOR) güvenliğini doğrulayan testler (Bkz: `test-qa-strategy.md`) çalıştırılır.
* [ ] **Derleme (Build) Kontrolü:** `pnpm build` komutuyla TypeScript hataları denetlenir.

## 3. Veritabanı Göçleri ve "Expand-Contract" (Geriye Uyumluluk) Püterni

Rollback (geri alma) işleminin çalışabilmesi için veritabanı her zaman bir önceki kod versiyonuyla **uyumlu olmak zorundadır**.

* CI/CD sürecinde canlı veritabanına otomatik migration (`db:migrate`) uygulanır.
* 🚨 **Yıkıcı Değişiklik Yasağı:** Tek bir PR içinde tablo silmek (DROP) veya kolon adı değiştirmek (RENAME) YASAKTIR.
* **Expand-Contract Püterni Uygulanır:** Bir kolon değiştirilecekse; önce yeni kolon eklenir (Expand), kod hem yeniye hem eskiye yazar. Sonraki deployment'ta veriler yeni kolona taşınır. En son deployment'ta eski kolon silinir (Contract). Bu sayede acil durumlarda kod rollback edildiğinde sistem eski kolonu bulup çalışmaya devam edebilir.

## 4. Sürekli Dağıtım (CD) ve Zero-Downtime

Kod incelenip PR onaylandıktan ve "Preview" ortamında QA testinden geçtikten sonra dağıtım süreci otomatiktir.

* **Production (Canlı) Ortamına Çıkış:** PR `main` dalına merge edildiği an, sistem otomatik olarak yeni bir "Release Tag" (Örn: `v1.2.0`) oluşturur ve canlı sunuculara aktarır.
* **Kesintisiz Geçiş (Zero-Downtime):** Docker konteynerleri sayesinde yeni versiyon arka planda ayağa kalkar. Konteynerin `healthcheck` sinyali başarılı dönene kadar trafik eski versiyonda kalır. Sistem tam hazır olduğunda yük dengeleyici (Load Balancer) trafiği yeni versiyona geçirir.

## 5. Acil Durum ve Geri Alma (Rollback)

Eğer canlıya çıkan kodda kritik bir hata tespit edilirse:

1. **Manuel Müdahale (SSH/Hotfix) Yasaktır:** Kriz anında canlı sunucuya bağlanıp kod değiştirmek kesinlikle yasaktır.
2. **Otomatik Rollback:** Pipeline üzerinden tek tuşla bir önceki stabil Release Tag'ine (Örn: `v1.1.9`) dönülür. (Veritabanı *Expand-Contract* püterni ile geriye uyumlu olduğu için çökme yaşanmaz).
3. **Kök Neden Analizi:** Sistem saniyeler içinde eski versiyona döner. Hatanın kök nedeni lokalde çözülüp Post-Mortem yapılarak (Bkz: `iletisim-ve-toplanti.md`) yeni bir PR ile sisteme dahil edilir.

---

*Son güncelleme: 2026-08-29 — Versiyon 2.0 — Sahibi: DevOps / Tech Lead*