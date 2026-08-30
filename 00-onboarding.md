# Geliştirici Oryantasyon (Onboarding) Süreci

> **Dokümanın Amacı**
> Bu doküman, ekibimize yeni katılan yazılım mühendislerinin 1. gün, 1. hafta ve 1. ay periyotlarındaki hedeflerini ve beklenen kazanımlarını tanımlamaktadır. Temel gayemiz, yeni ekip üyelerimizin sistemimize en hızlı, güvenli ve verimli şekilde entegrasyonunu sağlamaktır.

---

## 1. Gün: "Sisteme Giriş ve İlk Kurulum"

İlk günün odak noktası, kod geliştirmekten ziyade çalışma ortamının eksiksiz hazırlanması ve ekip içi iletişimin başlatılmasıdır.

- [ ] **Erişim Yetkileri:** GitHub, Slack, Jira, Figma ve 1Password (veya ilgili AWS/Cloud servisleri) davetlerini onaylayınız.
- [ ] **Yerel (Local) Kurulum:** `local-setup.md` dokümanındaki yönergeleri izleyerek projeyi yerel ortamınızda eksiksiz bir şekilde çalışır duruma getiriniz. (Destek gerektiren durumlarda ilgili Uzman/Otorite ile iletişime geçiniz - bkz. Yetkinlik Matrisi).
- [ ] **Kurum Kültürü Okumaları:** `product-philosophy.md` ve `communication-and-meetings.md` dokümanlarını inceleyiniz.
- [ ] **Ekip Tanışması:** Kurumsal Slack `#general` kanalında kendinizi tanıtan kısa bir bilgilendirme mesajı paylaşınız.

## 1. Hafta: "İlk Commit ve Operasyonel Süreçlerin Kavranması"

İlk haftanın temel hedefi, projeye değer katan ilk geliştirmenin yapılması ve kodun canlı ortama taşınma süreçlerinin deneyimlenmesidir.

- [ ] **Süreç Adaptasyonu:** `dod.md`, `dor.md` ve `decision-making-authority.md` dokümanlarını dikkatlice okuyunuz.
- [ ] **İlk Görevlendirme (Good First Issue):** Jira platformu üzerinden "Good First Issue" olarak etiketlenmiş, teknik riski düşük (örn. UI güncellemeleri, metin revizyonları) bir görev üstleniniz.
- [ ] **Kod İnceleme Süreci (PR):** Geliştirmenizi tamamlayarak Pull Request (PR) oluşturunuz ve ekip üyelerinden kod incelemesi (Code Review) talep ediniz.
- [ ] **Canlıya Alma (Deployment):** Geliştirdiğiniz kodun CI/CD boru hattı (pipeline) üzerinden başarıyla geçerek `staging` ortamına aktarılışını takip ediniz.

## 1. Ay: "Otonomi ve Görev Sahipliği"

Birinci ayın tamamlanmasıyla birlikte, mühendislerimizin uçtan uca özellik (feature) geliştirme süreçlerini bağımsız olarak yürütebilmeleri beklenmektedir.

- [ ] **Mimari Hakimiyet:** Müşteri talep döngüsünü (`musteri-talep-rehberi.md`) bütünüyle kavrayınız; projenin dizin yapısına ve Next.js/Drizzle mimarisine tam hakimiyet sağlayınız.
- [ ] **Özellik (Feature) Sahipliği:** Orta veya büyük ölçekli bir epik/özellik geliştirme sürecini uçtan uca üstleniniz; geliştirme, test yazımı ve canlıya alma aşamalarını başarıyla tamamlayınız.
- [ ] **Geri Bildirim Süreci:** Birinci ayın sonunda Teknik Lider (Tech Lead) ile birebir (1-on-1) değerlendirme toplantısı gerçekleştirerek oryantasyon sürecini analiz ediniz ve gelişim alanlarına dair geri bildirimlerinizi sununuz.

---
*Son güncelleme: 2026-08-29 — Versiyon 1.0 — Sorumlu: Mühendislik Yöneticisi (Engineering Manager) / Teknik Lider (Tech Lead)*
