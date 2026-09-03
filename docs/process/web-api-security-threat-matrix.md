# Web ve API Güvenliği Tehdit Matrisi: Saldırı ve Savunma Kılavuzu

> **Bu dokümanın amacı nedir?**
> Bu doküman, modern web uygulamaları ve API mimarilerinde karşılaşılan temel güvenlik tehditlerini, saldırı mekanizmalarını ve her biri için uygulanması gereken doğrudan savunma yöntemlerini listeler. Yazılım geliştiriciler, mimarlar ve kod inceleyiciler (code reviewers) için birincil güvenlik referans rehberidir.

---

## Genel Bakış ve Tehdit Matrisi

Aşağıdaki matris, modern web ve API mimarilerinde en sık karşılaşılan 8 kritik güvenlik tehdidini, etki alanlarını ve temel savunma mekanizmalarını özetlemektedir:

| # | Tehdit Adı | OWASP Referansı | Temel Risk | Birincil Savunma Mekanizması |
|---|---|---|---|---|
| 1 | **SQL Injection (SQLi)** | A03:2021 – Injection | Veri sızıntısı, veri tabanının tahribatı / silinmesi | Parametreli sorgular (Prepared Statements), güvenli ORM, En Düşük Yetki |
| 2 | **Broken Object-Level Authorization (BOLA / IDOR)** | API1:2023 / A01:2021 – Broken Access Control | Yetkisiz nesne ve veri erişimi / manipülasyonu | Nesne bazlı yetkilendirme, sorgularda kiracı filtresi, UUID kullanımı |
| 3 | **Server-Side Request Forgery (SSRF)** | A10:2021 – SSRF | İç ağ taraması, bulut metadata anahtarlarının çalınması | Katı allowlist, özel IP/metadata bloklama, soket seviyesinde IP kontrolü |
| 4 | **Server-Side Template Injection (SSTI)** | A03:2021 – Injection | Sunucu üzerinde uzaktan kod çalıştırma (RCE) | Girdilerin salt veri/bağlam olarak iletilmesi, şablon sandbox modu |
| 5 | **Mass Assignment / Parameter Tampering** | API3:2023 – Broken Object Property Level Auth | Yetkisiz alan/rol güncelleme, ayrıcalık yükseltme | DTO kullanımı, katı doğrulama şemaları, bilinmeyen alanların budanması |
| 6 | **Brute-Force & Credential Stuffing** | API2:2023 / A07:2021 – Identification Failures | Hesap ele geçirme, kimlik doğrulama baypas | Hız sınırlama (Rate Limiting), hesap kilitleme, CAPTCHA, MFA/Passkeys |
| 7 | **Clickjacking (UI Redressing)** | A05:2021 – Security Misconfiguration | Kullanıcıyı manipüle ederek yetkisiz işlem tetikleme | CSP `frame-ancestors 'none'`, `X-Frame-Options: DENY` başlıkları |
| 8 | **CORS Hatalı Yapılandırması** | A05:2021 – Security Misconfiguration | Tarayıcı üzerinden çapraz kaynak yetkisiz veri okuma | Güvenilir allowlist eşleşmesi, credentials ile wildcard yasağı, `null` origin reddi |

---

## 1. SQL Injection (SQLi)

* **Saldırı Mekanizması:** Kullanıcı girdilerinin SQL sorgularına dinamik olarak (string birleştirme ile) eklenmesi durumudur. Saldırgan girdi alanlarına `' OR '1'='1` gibi ifadeler enjekte ederek veri tabanı şemasını okuyabilir, veri sızdırabilir veya tabloları silebilir.
* **Savunma Stratejisi:**
  * Sorguları asla string birleştirme (`+`, template literals) ile oluşturmayın.
  * Her zaman **Parametreli Sorgular (Prepared Statements)** veya güvenli ORM/Query Builder araçları (Hibernate, Prisma, Entity Framework) kullanın.
  * Veri tabanı kullanıcısının yetkilerini **En Düşük Yetki Prensibi (Least Privilege)** gereğince sınırlandırın (örn: DDL izinlerini API kullanıcısına vermeyin).

---

## 2. Broken Object-Level Authorization (BOLA / IDOR)

* **Saldırı Mekanizması:** Bir kullanıcının kimliği doğrulanmış olsa dahi, URL parametrelerindeki veya istek gövdesindeki kayıt ID'sini değiştirerek başka bir kullanıcı/kuruma ait veriye yetkisiz erişmesidir (Örn: `GET /api/orders/105` adresindeki `105`'i `106` yapmak).
* **Savunma Stratejisi:**
  * Sadece "kullanıcı oturum açtı mı?" kontrolüyle yetinmeyin; "bu kullanıcı talep edilen nesneye erişebilir mi?" kontrolünü her uç noktada zorunlu kılın.
  * Veri tabanı sorgularına her zaman oturumdaki kullanıcı/organizasyon filtresini ekleyin:
    ```sql
    SELECT * FROM orders WHERE id = :orderId AND organization_id = :currentOrgId;
    ```
  * Tahmin edilebilir ardışık tam sayı ID'ler (`1, 2, 3`) yerine rastgele üretilen UUID v4 veya şifreli tanımlayıcılar kullanın.

---

## 3. Server-Side Request Forgery (SSRF)

* **Saldırı Mekanizması:** Uygulamanın kullanıcıdan aldığı bir URL'ye sunucu tarafında HTTP isteği yapmasıdır (Web scraping, avatar yükleme vb.). Saldırgan iç ağ adreslerini (`http://169.254.169.254/latest/meta-data/` veya `http://localhost:8080/internal-metrics`) belirterek bulut kimlik anahtarlarını çalabilir ya da iç servisleri tarayabilir.
* **Savunma Stratejisi:**
  * Kullanıcıdan alınan URL'leri katı bir **Allowlist (İzin Listesi)** ile kısıtlayın; yalnızca belirli domain ve şemalara (`https://`) izin verin.
  * Özel IP bloklarına (`127.0.0.1`, `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) ve bulut metadata adreslerine sunucudan giden trafiği ağ/güvenlik duvarı düzeyinde engelleyin.
  * DNS Rebinding açıklarına karşı, URL'nin çözümlendiği IP adresini istek atılmadan hemen önce soket seviyesinde doğrulayın.

---

## 4. Server-Side Template Injection (SSTI)

* **Saldırı Mekanizması:** Kullanıcı girdilerinin sunucu tarafı şablon motorlarına (Jinja, Blade, Pug, Thymeleaf) doğrudan kod olarak geçilmesidir. Saldırgan `{{ 7*7 }}` gibi ifadelerle zafiyeti teyit ettikten sonra işletim sistemi komutları çalıştırarak sunucuyu tamamen ele geçirebilir (RCE).
* **Savunma Stratejisi:**
  * Kullanıcı girdisini şablonun şablon sözdizimi içine doğrudan eklemeyin; girdiyi şablona yalnızca **veri parametresi (context variable)** olarak aktarın.
  * Şablon motorunun Sandbox (Kum Havuzu) modunu aktif hale getirin ve dosya/işletim sistemi API'lerine erişim izinlerini kapatın.

---

## 5. Mass Assignment / Parameter Tampering

* **Saldırı Mekanizması:** İstemciden gelen JSON gövdesinin, arka uçtaki veri tabanı modeline otomatik olarak bağlanmasıdır (Auto-binding). Saldırgan profil güncelleme isteğine `"is_admin": true` veya `"balance": 50000` parametresi ekleyerek yetki veya kaynak yükseltmesi yapar.
* **Savunma Stratejisi:**
  * HTTP isteklerini asla doğrudan veri tabanı Entity sınıflarına bağlamayın.
  * Yalnızca izin verilen alanları içeren **DTO (Data Transfer Object)** veya katı şemalar (Zod, Pydantic, Jakarta Validation) kullanın.
  * Şemada tanımlanmamış fazlalık parametreleri framework düzeyinde otomatik reddedin veya sessizce budayın (strip unknown fields).

---

## 6. Brute-Force & Credential Stuffing

* **Saldırı Mekanizması:** Otomatik botlar aracılığıyla şifre denemeleri yapılması veya üçüncü parti veri sızıntılarından elde edilen çalıntı kullanıcı adı/şifre çiftlerinin sisteme karşı topluca denenmesidir.
* **Savunma Stratejisi:**
  * Login, parola sıfırlama ve OTP uç noktalarında IP ve hesap bazlı **Hız Sınırlaması (Rate Limiting)** uygulayın.
  * Belirli sayıda başarısız denemeden sonra hesabı geçici olarak kilitleyin veya şüpheli denemelere **CAPTCHA / Cloudflare Turnstile** tetikleyin.
  * Sisteme Çok Faktörlü Kimlik Doğrulama (**MFA / TOTP / Passkeys**) mekanizmalarını entegre edin.

---

## 7. Clickjacking (UI Redressing)

* **Saldırı Mekanizması:** Hedef sitenin, saldırganın hazırladığı şeffaf bir `<iframe>` içerisine gömülmesi ve kurbanın zararsız bir düğmeye bastığını düşünürken arka planda hedef sitedeki kritik bir eylemi (örn. "Hesabı Sil") tetiklemesidir.
* **Savunma Stratejisi:**
  * Sitenin harici iframe'lerde yüklenmesini engellemek için HTTP yanıt başlıklarını ekleyin:
    ```http
    Content-Security-Policy: frame-ancestors 'none';
    X-Frame-Options: DENY
    ```
  * İframe kullanımı zorunluysa, yalnızca güvenilen etki alanlarına izin verin (`frame-ancestors 'self' https://guvenli-partner.com`).

---

## 8. CORS Hatalı Yapılandırması (CORS Misconfiguration)

* **Saldırı Mekanizması:** API sunucusunun gelen `Origin` başlığını otomatik olarak kabul edip `Access-Control-Allow-Origin: <dinamik-origin>` ve `Access-Control-Allow-Credentials: true` başlıklarıyla yanıt dönmesidir. Bu durum, zararlı sitelerin kurbanın tarayıcı yetkisi üzerinden API'den özel veri okumasına izin verir.
* **Savunma Stratejisi:**
  * `Access-Control-Allow-Origin: *` başlığını kimlik doğrulama gerektiren uç noktalarda kesinlikle kullanmayın.
  * İzin verilen origin'leri statik ve güvenilir bir **Beyaz Liste (Allowlist)** ile eşleştirin; gelen `Origin` başlığını doğrulamadan doğrudan yanıta kopyalamayın.
  * `null` origin değerine (`Access-Control-Allow-Origin: "null"`) asla güvenmeyin.

---

## 9. İlgili Standartlar ve Çapraz Referanslar

* [Güvenlik ve Uyum Standartları (DevSecOps)](./security-and-compliance.md) — Temel güvenlik, secret yönetimi ve zafiyet tarama politikaları.
* [Test ve Kalite Güvence Stratejisi](./test-qa-strategy.md) — BOLA/IDOR ve API yetkilendirme entegrasyon test kuralları.
* [Telemetri ve Loglama Standartları](./telemetry-logging.md) — Şüpheli trafik ve güvenlik vakalarını tespit etmek için loglama ilkeleri.

---

*Son Güncelleme: 2026-09-03 — Versiyon 1.0 — Doküman Sahibi: Güvenlik Otoritesi (Security Authority)*

