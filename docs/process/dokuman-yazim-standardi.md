# Dokümantasyon Standardı — Dokümanlar Nasıl Yazılmalı?

> **Bu doküman ne işe yarar?**
> Bu, "dokümanların dokümanı"dır. Playbook içindeki her yeni doküman (onboarding, mimari, süreç vb.) yazılırken bu kurallara uyulur. Amaç: farklı kişiler doküman yazsa bile hepsi aynı yapıda, aynı netlikte ve hem insanlar hem de AI ajanları (Claude Code, Cursor vb.) tarafından kolayca okunup uygulanabilir olsun.

---

## 1. Neden Standart Bir Format Gerekli?

- **Tutarlılık:** Bir dokümanı okuyan biri, diğerini de nereden başlayacağını bilerek okur.
- **AI-Okunabilirlik:** Yapay zeka ajanları dokümanları bağlam olarak kullanıyor. Belirsiz, dağınık yazılmış bir doküman yanlış kod üretimine yol açar. Net başlıklar, tablo ve kod bloğu kullanımı AI'ın doğru yorumlamasını kolaylaştırır.
- **Bakım Kolaylığı:** Standart yapı olmadan dokümanlar zamanla "kimse okumuyor, kimse güncellemiyor" çöplüğüne döner.

---

## 2. Her Dokümanın Zorunlu Bölümleri

Her doküman şu iskeletle başlar:

```markdown
# [Doküman Başlığı]

> **Bu doküman ne işe yarar?**
> [2-3 cümlelik amaç ve kapsam. Kim, ne zaman, neden okumalı?]

---

## 1. [İlk ana bölüm]
...

---
*Son güncelleme: [tarih] — Versiyon [x.x] — Sahibi: [isim/rol]*
```

### 2.1 Amaç/Kapsam Notu (Zorunlu)
Her dokümanın en tepesinde blockquote (`>`) ile 2-3 cümlelik bir özet olur. Bu bölüm olmadan doküman "taslak" sayılır, yayınlanamaz.

*   *Kötü örnek:* "Bu doküman deployment sürecini anlatır."
*   *İyi örnek:* "Bu doküman, kodun main branch'ten canlıya nasıl çıktığını ve bir kriz anında sistemin nasıl geri alınacağını (rollback) anlatır. DevOps ve tüm geliştiriciler için zorunlu okumadır."

### 2.2 Sahiplik (Ownership)
Her dokümanın bir sahibi (bir kişi veya rol) olmalı. Sahip belirsizse doküman kimse tarafından güncellenmez ve zamanla yanlış bilgi içermeye başlar.

---

## 3. Temel Prensipler ve Yazım Kuralları

Kodun kendisi "ne" yapıldığını, dokümantasyon ise "neden" yapıldığını anlatır. Dokümanlarımız statik metinler değil, sürekli güncellenen yaşayan rehberlerdir.

* **Tek Gerçek Kaynak (Single Source of Truth):** Aynı bilgi iki farklı yerde bulunamaz. Bir kural veya kurulum adımı değişecekse, sadece ana kaynağında güncellenir ve diğer yerlerden oraya link verilir.
* **Kodu Kim Değiştiriyorsa, Belgeyi O Günceller:** Bir PR (Pull Request) sistemin işleyişini değiştiriyorsa, ilgili dokümanın güncellenmesi DoD (Bitti Kriterleri) şartıdır. Dokümanı ayrı bir ekip veya kişi güncellemez.
* **Görsellik (Mermaid.js):** Sadece metinle anlatılamayan karmaşık iş akışları (Örn: veritabanı ilişkileri) için Mermaid.js kullanılır. Böylece şemalar kod olarak versiyonlanabilir.

| Kural | Açıklama |
|---|---|
| **Aktif ve emir kipi** | "Deploy yapılabilir" değil, "Deploy'u şu adımlarla yap" |
| **Kısa cümle** | Bir cümlede tek bir fikir. Bağlaçlarla uzatılmış cümlelerden kaçın |
| **Somut örnek** | Her kural için en az 1 kod/komut/örnek eklenir. Soyut kural tek başına yeterli değildir |
| **Tablo > uzun paragraf** | Karşılaştırma, liste, kural seti varsa tablo kullanılır |
| **Checklist kullan** | Uygulanabilir adımlar `- [ ]` formatında yazılır, okuyan kişi/AI adım adım takip edebilir |
| **Jargon açıklanır** | Kısaltma ilk geçtiği yerde açık yazılır: "DoD (Definition of Done)" |
| **Türkçe teknik terim tutarlılığı** | Ekip içinde hangi terimin Türkçe/İngilizce kullanılacağı netleştirilir (örn: "deploy" mu "dağıtım" mı — ikisi karışık kullanılmaz) |

---

## 4. Ne Zaman Yeni Doküman, Ne Zaman Mevcut Dokümana Ekleme?

- Konu, var olan bir dokümanın **alt başlığı** olarak okunabiliyorsa → mevcut dokümana ekle.
- Konu kendi başına bağımsız aranabilir/referans verilebilir bir birimse (örn: "Deployment Süreci") → yeni doküman aç.
- Bir doküman 300-400 satırı geçtiyse, bölünmesi gerekip gerekmediği gözden geçirilir.

---

## 5. Versiyonlama ve Güncellik

- Her doküman en altta `Son güncelleme` tarihi ve versiyon numarası taşır (`1.0`, `1.1`...).
- **Büyük değişiklik** (kuralın anlamı değişti) → versiyon major artar (`1.x` → `2.0`).
- **Küçük düzeltme** (yazım, örnek ekleme) → versiyon minor artar (`1.0` → `1.1`).
- Bir doküman 6 aydır güncellenmemişse, sahibi tarafından "hâlâ geçerli mi?" kontrolü yapılır.

---

## 6. Dizin / Klasör Yapısı Önerisi ve Doküman Tipleri

Tüm playbook, okunabilirliği artırmak için kategorik klasörler altında toplanmalıdır. Her klasörün girişinde, o klasördeki dokümanların ne işe yaradığını özetleyen kısa bir `README.md` bulunur.

```text
/playbook
  /01-kultur-ve-zihniyet
  /02-surec-ve-akis
  /03-teknik-standartlar
  /04-kalite-guvenlik
  README.md   ← Tüm dokümanlara linkler
```

Farklı doküman tiplerinin nerede tutulması gerektiğine dair karar matrisi aşağıdadır:

| Doküman Tipi | Nerede Tutulur? | Amacı |
| --- | --- | --- |
| **Bileşen & Tasarım Sistemi** | Storybook / Kod İçi | UI bileşenlerinin (buton, form) nasıl kullanılacağını gösterir. |
| **Lokal Kurulum (Setup)** | Proje Kök Dizini (`README.md`) | Projeyi sıfırdan ayağa kaldırmak için gereken tekil komutları içerir. |
| **Mimari Kararlar (ADR)** | `/docs/adr` klasörü | Projenin kaderini değiştiren büyük teknik kararların "neden" alındığını kaydeder. |
| **Süreç & Kültür (Playbook)** | `docs/` veya Merkezi Wiki | Kuralları, code review standartlarını ve ekibin işleyişini belirler. |

---

## 7. Yayın Öncesi Kontrol Listesi

Bir doküman yayınlanmadan önce aşağıdaki kontroller sağlanmalıdır:

- [ ] Amaç/kapsam notu (blockquote) var mı?
- [ ] Sahibi belirlenmiş mi?
- [ ] En az bir başka kişi (ekip lead'i / ilgili kişi) tarafından gözden geçirilmiş mi?
- [ ] Somut örnek/kod bloğu veya tablo içeriyor mu?
- [ ] Versiyon ve tarih bilgisi eklenmiş mi?
- [ ] Playbook ana README'sine linki eklenmiş mi?

---
*Son güncelleme: 2026-08-29 — Versiyon 1.1 — Sahibi: Tech Lead / Engineering Manager*
