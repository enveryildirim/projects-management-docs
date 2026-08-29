# Lokal Geliştirme Rehberi (Local Setup)

> **Bu doküman ne işe yarar?**
> Projeye yeni katılan veya bilgisayarını sıfırlayan bir geliştiricinin, projeyi kendi makinesinde tek komutla ayağa kaldırması için gereken adımları içerir. Tüm mühendislik ekibi için zorunlu başlangıç noktasıdır.

---

## 1. Ön Koşullar

Aşağıdaki araçların sisteminizde kurulu olduğundan emin olun:
- **Node.js:** v18 veya üzeri (Tercihen `nvm` veya `fnm` ile kurun)
- **Paket Yöneticisi:** `pnpm` (v8+)
- **Konteyner Motoru:** Docker Desktop veya OrbStack (Mac için önerilir)
- **Git:** v2.30+

## 2. İlk Kurulum Adımları

Projeyi ayağa kaldırmak için sırasıyla aşağıdaki adımları uygulayın:

- [ ] **1. Depoyu klonlayın:**
  ```bash
  git clone git@github.com:sirket/project-management.git
  cd project-management
  ```
- [ ] **2. Bağımlılıkları yükleyin:**
  ```bash
  pnpm install
  ```
- [ ] **3. Çevre değişkenlerini ayarlayın:**
  ```bash
  cp .env.example .env
  ```
  *(Not: Hassas şifreleri ve API key'leri 1Password veya ekip şifre yöneticisinden alıp `.env` dosyasına ekleyin.)*
- [ ] **4. Veritabanı ve yardımcı servisleri başlatın:**
  ```bash
  docker compose up -d
  ```
- [ ] **5. Veritabanı şemasını oluşturun (Migration):**
  ```bash
  pnpm db:push
  # veya CI ortamı simülasyonu için: pnpm db:migrate
  ```

## 3. Geliştirme Sunucusunu Başlatma

Tüm altyapı hazırlandıktan sonra Next.js geliştirme sunucusunu başlatın:

```bash
pnpm dev
```
Tarayıcınızda `http://localhost:3000` adresine giderek sistemin çalıştığını doğrulayın.

## 4. Sık Karşılaşılan Hatalar (Troubleshooting)

| Hata / Semptom | Olası Neden | Çözüm |
|---|---|---|
| `Port 5432 is already in use` | Başka bir PostgreSQL instance'ı çalışıyor. | Lokal makinenizdeki postgres'i durdurun (`brew services stop postgresql`) veya `docker-compose.yml` içinden portu değiştirin. |
| `Cannot find module 'X'` | Yeni bir paket eklenmiş olabilir. | Terminalde `pnpm install` komutunu tekrar çalıştırın. |
| `Environment variable missing` | `.env` dosyası eksik veya güncel değil. | `.env.example` dosyasındaki yeni eklenen anahtarları kontrol edin. |

---
*Son güncelleme: 2026-08-29 — Versiyon 1.0 — Sahibi: Tech Lead*

