# Yetkinlik ve Etki Alanı Matrisi

> **Bu Dokümanın Amacı**
> Bu doküman, çeşitli teknoloji alanlarında kurum içi karar vericilerin (Otorite), danışmanların (Uzman) ve gelişim aşamasındaki çalışanların (Öğrenen) rollerini şeffaf bir biçimde tanımlamayı amaçlamaktadır. Aynı zamanda `CODEOWNERS` dosyamızın yapısal temelini oluşturur. Süreç bazlı sorumluluk dağılımı için bkz: [RACI Matrisi](./raci-matrix.md).

## 1. Yetkinlik Seviyeleri

* **Otorite (O):** İlgili teknik alanın nihai karar merciidir. Seviye 2 kapsamındaki kararlarda son onayı verme yetkisine sahiptir. Her teknik alan için yalnızca bir Otorite belirlenmelidir.
* **Uzman (U):** İlgili alanda derin pratik bilgi ve tecrübeye sahiptir. Otorite konumundaki kişiye ulaşılamadığı durumlarda karar alma sürecini devralır (Yedekleme/Fallback).
* **Geliştirici (G):** Bağımsız olarak kod geliştirme yetkinliğine sahiptir; ancak mimari tasarım kararlarına doğrudan yön vermez.
* **Öğrenen (Ö):** İlgili alanda bilgi ve becerilerini geliştirmeyi hedefleyen, Eşli Programlama (Pair Programming) pratikleriyle desteklenen ekip üyesidir.

## 2. Örnek Yetkinlik ve Etki Alanı Matrisi (Dinamik Harita)

| Teknik Alan (Domain) | Ali | Ayşe | Can | Zeynep |
| --- | --- | --- | --- | --- |
| **Next.js & App Router** | G | **O** | U | Ö |
| **Drizzle ORM & Postgres** | **O** | Ö | U | G |
| **LLM & Prompt Mühendisliği** | Ö | G | G | **O** |
| **Docker, CI/CD Pipeline** | U | Ö | **O** | G |

## 3. Sistem Pratikleri ve Otomasyon

* **Otomatize Edilmiş Gözden Geçirme (CODEOWNERS):** Geliştirme sürecinde "Bu kod değişikliğini kim inceleyebilir?" sorusu ortadan kaldırılmıştır. Proje genelinde yer alan `CODEOWNERS` dosyası, değişiklik yapılan dizinleri baz alarak Pull Request (PR) inceleme atamalarını doğrudan matriste tanımlı Otoritelere (O) otomatik olarak gerçekleştirir.
* **Kurum İçi Mentörlük:** "Öğrenen (Ö)" rolündeki çalışanlarımız, ilgili alanın "Uzmanı (U)" ile eşleştirilerek Eşli Programlama (Pair Programming) seanslarına dahil edilir.
* **Unvansız Liderlik:** Kurumumuzda yetkinlik, kıdemden bağımsız değerlendirilir. Altı aylık deneyime sahip bir geliştirici, ekibin geri kalanından daha derinlemesine bilgi sahibi olduğu spesifik bir teknolojide "Otorite" rolünü üstlenebilir.

---

### 🚀 Sisteme Entegre Edilecek Kurulum Aksiyonları (Görevler)

* [ ] **CODEOWNERS Otomasyonu:** Depo kök dizininde (veya `.github/` klasörü altında) bir `CODEOWNERS` dosyası oluşturulmalıdır. Matriste belirlenen Otoriteler, ilgili dosya yollarıyla eşleştirilmelidir. *(Örnek: `src/db/** @ali` veya `src/app/** @ayse`)*
* [ ] **Dal Koruma Kuralları (Branch Protection):** GitHub/GitLab depo ayarları üzerinden "Require review from Code Owners" (Kod sahiplerinden onay zorunluluğu) seçeneği aktif edilmelidir.
* [ ] **Zaman Aşımı Politikası:** Ekip içi iletişim kanallarında (Slack/Teams vb.) "24 Saat Otorite Devri (Fallback)" kuralı duyurulmalıdır. Otoriteye 24 saat içerisinde ulaşılamadığı durumlarda, PR onay işlemlerinin ilgili Uzman (U) inisiyatifiyle tamamlanabileceği bilgisi ilgili kanallara sabitlenmelidir.

---

*Son Güncelleme: 2026-08-31 — Versiyon 1.1 — Doküman Sahibi: Engineering Manager / Tech Lead*
