# Dokümantasyon Standartları: Doküman Oluşturma Kılavuzu

> **Bu dokümanın amacı nedir?**
> Bu belge, tüm süreç ve teknik dokümantasyonumuz için temel referans (Playbook) niteliğindedir. Organizasyonumuz bünyesinde oluşturulan her yeni dokümanın (oryantasyon, mimari kararlar, operasyonel süreçler vb.) bu standartlara uygun olarak hazırlanması gerekmektedir. Temel amacımız, farklı ekipler tarafından oluşturulan içeriklerin yapısal bütünlüğünü sağlamak ve hem çalışanlarımız hem de yapay zeka asistanları (Claude Code, Cursor vb.) tarafından anlaşılabilir, yüksek kaliteli belgeler üretmektir.

---

## 1. Standart Formatın Gerekliliği

- **Tutarlılık:** Standart bir yapı, okuyucunun aradığı bilgiyi doküman içerisinde hızlıca bulmasını sağlar.
- **Yapay Zeka (AI) Okunabilirliği:** Yapay zeka ajanları dokümanlarımızı bağlam olarak kullanmaktadır. Belirsiz ve düzensiz yapılandırılmış belgeler, hatalı kod üretimine veya yanlış yönlendirmelere sebep olabilir. Net başlıklandırma, tablolar ve kod bloklarının kullanımı, yapay zeka sistemlerinin veriyi doğru işlemesini kolaylaştırmaktadır.
- **Sürdürülebilirlik:** Standart bir yapıdan yoksun dokümanlar, zamanla güncelliğini yitirmekte ve kullanılmaz hale gelmektedir.

---

## 2. Temel Doküman Yapısı

Her dokümanın aşağıdaki standart yapı ile başlatılması zorunludur:

```markdown
# [Doküman Başlığı]

> **Bu dokümanın amacı nedir?**
> [2-3 cümlelik amaç ve kapsam tanımı. Hedef kitle ve kullanım senaryosu belirtilmelidir.]

---

## 1. [İlk Ana Bölüm]
...

---
*Son Güncelleme: [Tarih] — Versiyon [x.x] — Doküman Sahibi: [İsim/Rol]*
```

### 2.1 Amaç ve Kapsam Özeti (Zorunlu)
Her dokümanın başlangıcında, alıntı bloğu (`>`) formatında 2-3 cümlelik bir özet bulunmalıdır. Bu bölümü içermeyen belgeler taslak statüsünde değerlendirilir ve resmi olarak yayınlanamaz.

*   *Hatalı Örnek:* "Bu doküman deployment sürecini anlatır."
*   *Doğru Örnek:* "Bu belge, kodun 'main' dalından üretim (production) ortamına aktarımı ve olası kriz anlarında sistemin nasıl geri alınacağı (rollback) süreçlerini tanımlar. DevOps ekipleri ve tüm yazılım mühendisleri için zorunlu referans niteliğindedir."

### 2.2 Sahiplik (Ownership)
Her dokümanın güncelliğinden sorumlu bir sahibi (birey veya rol) bulunmalıdır. Sahipliği tanımlanmamış belgeler zamanla geçerliliğini yitirme riski taşımaktadır.

---

## 3. Temel Prensipler ve Yazım Kuralları

Kaynak kod "ne" yapıldığını, dokümantasyon ise "neden" yapıldığını açıklar. Belgelerimiz statik metinler olmak yerine, sürekli güncellenen operasyonel rehberler olarak konumlandırılmaktadır.

* **Tek Gerçeklik Kaynağı (Single Source of Truth):** Bilgi tekrarından kaçınılmalıdır. Herhangi bir kural veya prosedür güncellendiğinde, bu değişiklik yalnızca ana kaynakta yapılmalı ve diğer belgelerden ilgili kaynağa bağlantı (link) verilmelidir.
* **Güncelleme Sorumluluğu:** Sistem işleyişini değiştiren bir Değişiklik Talebi (Pull Request), ilgili dokümantasyonun güncellenmesini de zorunlu kılar (Bitti Kriterleri - Definition of Done). Dokümantasyon güncellemesi, kodu değiştiren mühendisin sorumluluğundadır.
* **Görselleştirme (Mermaid.js):** Sadece metin ile ifade edilmesi güç olan karmaşık mimariler ve iş akışları (örneğin veritabanı ilişkileri) için Mermaid.js kullanılmalıdır. Bu sayede diyagramlar, kod olarak versiyon kontrol sisteminde takip edilebilir.

| Kural | Açıklama |
|---|---|
| **Etkin ve Yönerge Bazlı Dil** | "Deploy yapılabilir" yerine "Dağıtım (deployment) işlemini aşağıdaki adımlarla gerçekleştirin" şeklinde net ifadeler kullanılmalıdır. |
| **Öz ve Anlaşılır Cümleler** | Her cümlede tek bir fikir ifade edilmelidir. Karmaşık ve uzun cümle yapılarından kaçınılmalıdır. |
| **Somut Örneklendirme** | Soyut kurallar, mutlaka kod parçacıkları veya komut örnekleriyle desteklenmelidir. |
| **Tablo Kullanımı** | Karşılaştırmalar ve kural setleri için uzun paragraflar yerine tablolar tercih edilmelidir. |
| **Kontrol Listeleri (Checklists)** | İşlem adımları `- [ ]` formatında yazılmalı; böylece kullanıcılar ve AI ajanları süreci adım adım takip edebilmelidir. |
| **Terminoloji Açıklamaları** | Kısaltmalar ve teknik jargon, metinde ilk geçtiği yerde açıklanmalıdır (Örn: "DoD - Definition of Done"). |
| **Terminolojik Tutarlılık** | Kurum içi teknik terminolojide standart sağlanmalıdır. Aynı kavram için farklı terimler (Örn: "deploy" ve "dağıtım") birbirinin yerine kullanılmamalıdır. |

---

## 4. Yeni Doküman Oluşturma ve Mevcut Dokümanı Güncelleme Kriterleri

- İçerik, mevcut bir belgenin **alt başlığı** olarak anlamlıysa → İlgili mevcut belge güncellenmelidir.
- İçerik, bağımsız bir referans birimi teşkil ediyorsa (örn: "Dağıtım Süreçleri") → Yeni bir doküman oluşturulmalıdır.
- Hacmi 300-400 satırı aşan dokümanların, okunabilirliği artırmak amacıyla alt bölümlere ayrılması değerlendirilmelidir.
- Bir doküman **yalnızca bir adet H1 (`#`) başlık** içerebilir. İki bağımsız konunun tek dosyada birleştirilmesi, çapraz atıf (link) yerine kopyala-yapıştır kullanımına ve sahiplik belirsizliğine yol açar.

---

## 5. Commit Mesajı Hijyeni

Dokümantasyon deposundaki commit geçmişi kurumsal hafızanın bir parçasıdır ve `git log` üzerinden aranır. Bu nedenle commit mesajının beyanı ile değişikliğin fiili içeriği örtüşmek zorundadır.

| Değişiklik Türü | Önek | Örnek |
| --- | --- | --- |
| Yeni doküman eklenmesi | `docs:` | `docs: add on-call rotation policy` |
| Mevcut dokümanın içerik güncellemesi | `docs:` | `docs: clarify rollback limits in ci-cd` |
| Yalnızca birikim listesine (backlog) madde eklenmesi | `chore:` | `chore: add Backup&DR scope to backlog` |
| Yapısal/otomasyon değişikliği | `chore:` / `ci:` | `ci: block PR on broken doc links` |

> 🚨 **Kural:** Yalnızca `TODO.md` veya bir plan dosyasına madde ekleyen bir commit, mesajında **"add documentation" / "doküman eklendi"** ifadesini kullanamaz. Bu ifade, ilgili dokümanın fiilen yazıldığı commit'e ayrılmıştır. Aksi durumda geçmiş üzerinden yapılan aramalar var olmayan dokümanları mevcut gösterir.

---

## 6. Versiyon Kontrolü ve Güncellik

- Tüm dokümanların alt kısmında `Son Güncelleme` tarihi ve versiyon numarası (`1.0`, `1.1` vb.) yer almalıdır.
- **Kapsamlı Değişiklikler** (süreç ve kuralların yeniden tanımlanması) → Majör versiyon artışı gerektirir (`1.x` → `2.0`).
- **Minör Düzenlemeler** (yazım hatalarının giderilmesi, örnek eklenmesi) → Minör versiyon artışı gerektirir (`1.0` → `1.1`).
- Altı ay boyunca güncellenmemiş dokümanlar, ilgili belge sahibi tarafından gözden geçirilmeli ve geçerliliği doğrulanmalıdır.

---

## 7. Dizin Yapısı ve Doküman Sınıflandırması

Playbook kapsamındaki tüm belgeler, erişilebilirliği artırmak amacıyla kategorik klasörler altında organize edilmelidir. Her klasörün dizin kökünde, içerdiği dokümanların özetini sunan bir `README.md` dosyası bulunmalıdır.

```text
/
├── README.md              ← Ana indeks: tüm dokümanlara bağlantılar ve olgunluk tablosu
├── docs/
│   ├── core/              ← Teknoloji BAĞIMSIZ çekirdek: felsefe, DoR/DoD, önceliklendirme, kriz
│   │   └── README.md
│   ├── process/           ← Operasyonel akış: iletişim, karar yetkileri, CI/CD, test, güvenlik, metrik
│   │   └── README.md
│   ├── stacks/            ← Teknoloji eklentileri: yığın bazlı standartlar
│   │   └── README.md
│   └── adr/               ← Mimari Karar Kayıtları arşivi
│       └── README.md
├── plans/                 ← Henüz yürürlükte olmayan tasarım ve denetim dokümanları
├── scripts/               ← Denetim betikleri (Policy-as-Code)
└── .github/               ← PR/Issue şablonları, CODEOWNERS, CI iş akışları
```

> 🚨 **Katman Kuralı (Sızıntı Yasağı):** `docs/core/` altındaki hiçbir doküman somut araç veya kütüphane adı içeremez (örn. linter, framework, ORM isimleri). Somut araç tercihleri yalnızca `docs/stacks/` altında belirtilir. Bu kural, teknoloji değişikliklerinin çekirdek yönergeleri geçersiz kılmamasını güvence altına alır ve `make check` ile denetlenir.

Belge türlerine göre depolama lokasyonları aşağıdaki matriste belirtilmiştir:

| Doküman Türü | Depolama Konumu | Kapsam ve Amaç |
| --- | --- | --- |
| **Bileşen & Tasarım Sistemi** | Storybook / Kaynak Kod İçi | UI bileşenlerinin (buton, form vb.) kullanım standartlarını belirler. |
| **Lokal Ortam Kurulumu** | Proje Kök Dizini (`README.md`) | Projenin geliştirme ortamında başlatılması için gereken yönergeleri içerir. |
| **Mimari Kararlar (ADR)** | [`docs/adr/`](../adr/README.md) Dizini | Projenin mimarisini etkileyen stratejik teknik kararların gerekçelerini belgeler. |
| **Süreç & Kültür (Playbook)** | `docs/` Dizini veya Merkezi Wiki | Kurumsal politikaları, kod gözden geçirme standartlarını ve ekip işleyiş kurallarını tanımlar. |

---

## 8. Yayın Öncesi Onay Listesi

Bir dokümanın resmi olarak yayınlanabilmesi için aşağıdaki kriterleri karşılaması gerekmektedir:

- [ ] Amaç ve kapsam özeti (blockquote formatında) tanımlanmış mı?
- [ ] Doküman sahibi belirlenmiş mi?
- [ ] İlgili ekip lideri veya yetkili bir paydaş tarafından gözden geçirilmiş mi?
- [ ] İlgili somut örnekler, kod blokları veya tablolar içeriyor mu?
- [ ] Versiyon numarası ve son güncelleme tarihi eklenmiş mi?
- [ ] Ana Playbook indeksine (README) ve ilgili klasör indeksine gerekli bağlantı sağlanmış mı?
- [ ] `make check` denetimi hatasız tamamlanıyor mu? (kırık bağlantı / eksik sahiplik / indeks boşluğu)

---
*Son Güncelleme: 2026-08-31 — Versiyon 2.0 — Doküman Sahibi: Tech Lead / Engineering Manager*
