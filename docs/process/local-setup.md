# Yerel Geliştirme Ortamı Kurulum Rehberi (Local Setup)

> **Bu Dokümanın Amacı**
> Bu doküman, ekibimize yeni katılan veya donanım yenilemesi gerçekleştiren yazılım mühendislerimizin, projeyi kendi yerel makinelerinde standart ve hızlı bir şekilde çalışır duruma getirmeleri için gereken adımları tanımlamaktadır. Tüm mühendislik ekibimiz için uyulması zorunlu bir başlangıç kılavuzudur.

---

## 1. Ön Koşullar ve Gereksinimler

Kuruluma başlamadan önce sisteminizde aşağıdaki araçların kurulu ve güncel olduğundan emin olunuz:
- **Node.js:** v18 veya üzeri (Sürüm yönetimi için `nvm` veya `fnm` kullanılması tavsiye edilmektedir)
- **Paket Yöneticisi:** `pnpm` (v8 ve üzeri)
- **Konteyner Motoru:** Docker Desktop veya OrbStack (macOS kullanıcıları için OrbStack önerilmektedir)
- **Git:** v2.30 veya üzeri

## 2. İlk Kurulum Adımları

Projeyi yerel ortamınızda yapılandırmak için sırasıyla aşağıdaki adımları takip ediniz:

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
*Son güncelleme: 2026-08-29 — Sürüm: 1.0 — Sorumlu Birim: Tech Lead*
