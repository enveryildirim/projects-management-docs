# Yerel Geliştirme Ortamı Kurulum Rehberi (Local Setup)

> **Bu Dokümanın Amacı**
> Bu doküman, yerel geliştirme ortamının manuel olarak kurulması için gereken komut dizisini ve sık karşılaşılan kurulum hatalarının çözümlerini tanımlamaktadır. Donanım yenileyen mühendisler ile otomasyon betiğinin başarısız olduğu durumlar için referans niteliğindedir.

> ⚠️ **Bu doküman bir ektir, başlangıç noktası değildir.** Oryantasyon sürecinin tek resmî kaynağı [Oryantasyon ve Sistem Kurulum Rehberi](./onboarding-and-setup.md)'dir ve kurulumda **öncelikli yöntem `make setup` otomasyonudur**. Aşağıdaki manuel adımlara yalnızca otomasyon hata verdiğinde başvurulur; bu durum otomasyon betiğinde giderilmesi gereken bir kusur olduğu anlamına gelir ve DevOps Otoritesine bir hata kaydı (issue) ile bildirilmelidir.

---

## 1. Ön Koşullar ve Gereksinimler

Kuruluma başlamadan önce sisteminizde aşağıdaki araçların kurulu ve güncel olduğundan emin olunuz:
- **Node.js:** v18 veya üzeri (Sürüm yönetimi için `nvm` veya `fnm` kullanılması tavsiye edilmektedir)
- **Paket Yöneticisi:** `pnpm` (v8 ve üzeri)
- **Konteyner Motoru:** Docker Desktop veya OrbStack (macOS kullanıcıları için OrbStack önerilmektedir)
- **Git:** v2.30 veya üzeri

## 2. Manuel Kurulum Adımları (Geri Dönüş / Fallback)

`make setup` komutunun başarısız olduğu durumlarda, otomasyonun gerçekleştirdiği işlemler sırasıyla aşağıdaki şekilde manuel olarak uygulanır:

- [ ] **1. Kaynak Kodun Klonlanması:**
  ```bash
  git clone git@github.com:sirket/project-management.git
  cd project-management
  ```
- [ ] **2. Bağımlılıkların Yüklenmesi:**
  ```bash
  pnpm install
  ```
- [ ] **3. Ortam Değişkenlerinin Yapılandırılması:**
  ```bash
  cp .env.example .env
  ```
  *(Not: Güvenlik politikalarımız gereği, hassas şifreleri ve API anahtarlarını 1Password veya kurum içi şifre yönetim sistemimizden temin ederek `.env` dosyanıza entegre ediniz.)*
- [ ] **4. Veritabanı ve Yardımcı Servislerin Başlatılması:**
  ```bash
  docker compose up -d
  ```
- [ ] **5. Veritabanı Şemasının Oluşturulması (Migration):**
  ```bash
  pnpm db:push
  # veya CI/CD ortamı simülasyonu gerçekleştirmek için: pnpm db:migrate
  ```

## 3. Geliştirme Sunucusunun Başlatılması

Tüm altyapı gereksinimleri tamamlandıktan sonra Next.js geliştirme sunucusunu başlatmak için aşağıdaki komutu çalıştırınız:

```bash
pnpm dev
```
Kurulumun başarıyla tamamlandığını doğrulamak amacıyla, tarayıcınız üzerinden `http://localhost:3000` adresine erişim sağlayınız.

## 4. Sık Karşılaşılan Sorunlar ve Çözümleri (Troubleshooting)

| Hata / Belirti | Olası Neden | Çözüm Adımı |
|---|---|---|
| `Port 5432 is already in use` | Sistemde halihazırda çalışan başka bir PostgreSQL servisi bulunmaktadır. | Yerel makinenizdeki mevcut PostgreSQL servisini durdurunuz (`brew services stop postgresql`) veya `docker-compose.yml` yapılandırması üzerinden port tanımını değiştiriniz. |
| `Cannot find module 'X'` | Projeye yeni bir paket bağımlılığı eklenmiş olabilir. | Terminal üzerinden `pnpm install` komutunu yeniden çalıştırarak bağımlılıkları güncelleyiniz. |
| `Environment variable missing` | `.env` dosyası oluşturulmamış veya güncelliğini yitirmiş olabilir. | `.env.example` dosyasında yer alan yeni değişken anahtarlarını kontrol ederek kendi ortam yapılandırmanızı güncelleyiniz. |

---
*Son Güncelleme: 2026-08-31 — Versiyon 2.0 — Doküman Sahibi: DevOps / Tech Lead*
