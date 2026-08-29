# Tasarım Sistemi ve UI Referansı (Golden Path)

> **Bu doküman ne işe yarar?**
> Projenin arayüzlerinin tutarlı kalmasını sağlar. Bileşenlerin sıfırdan icat edilmesini engeller, Next.js App Router standartlarına uygun render stratejilerini (RSC vs. Client) ve Tailwind tema mimarisini belirler.

## 1. Araç Seti ve Temel Kurallar

* **CSS Framework:** Tailwind CSS
* **Bileşen Kütüphanesi:** Shadcn UI (Radix tabanlı erişilebilir bileşenler)
* **İkonlar:** Lucide Icons
* **Stil Birleştirme (Composition):** `cn()` yardımcı fonksiyonu (`clsx` + `tailwind-merge`)

> 💡 **Altın Kural:** Özel (custom) CSS yazmak yasaktır. Koşullu (conditional) veya dışarıdan gelen sınıfları (prop olarak gelen `className`) birleştirirken her zaman `cn()` fonksiyonu kullanılmalıdır. Aksi takdirde Tailwind CSS kaskad çatışmaları yaşanır.

## 2. Tailwind CSS ve Tema Kuralları

* **Semantik Renk Değişkenleri:** Renk kodlarını (Örn: `text-gray-500` veya `#ff0000`) hardcode yazmak yasaktır. Bunun yerine tema değişkenleri (`text-muted-foreground`, `bg-destructive`) kullanılır. Bu, karanlık mod (Dark Mode) desteğini şartsız sağlar.
* **Gelişigüzel Değerler (Arbitrary Values) İstisnası:** `w-[325px]` gibi rastgele pikseller ancak sistemin dışından gelen 3. parti bir entegrasyon veya kesin bir marka logosu kısıtlaması varsa kullanılabilir. Bunun dışında sistemin `spacing` skalası dışına çıkılamaz.
* **Mobil Öncelikli Tasarım:** Varsayılan tasarımlar mobildir. Tablet ve masaüstü için `md:` ve `lg:` breakpoint'leri kullanılır. (Örn: `flex-col md:flex-row`).

## 3. Next.js Bileşen (Component) Mimarisi (App Router)

Bileşenlerimiz geleneksel Smart/Dumb yerine, performans ve güvenlik açısından **Server vs. Client** prensibiyle ikiye ayrılır:

### 3.1. Server Components (Varsayılan - Default)

* İş mantığı barındırır, doğrudan veritabanına bağlanır veya fetch isteği atar (`async/await` kullanır).
* Boyutu sıfırdır (JS bundle'a eklenmez), SEO dostudur.
* **Kısıtlamalar:** `useState`, `useEffect`, `onClick` gibi interaktif hook'ları veya olay dinleyicileri (event listener) KULLANAMAZ.

### 3.2. Client Components (`"use client"`)

* Yalnızca kullanıcı etkileşimi (tıklama, form doldurma), animasyon veya tarayıcı API'leri (localStorage vb.) gerektiğinde kullanılır.
* `src/components/ui/` altındaki Shadcn bileşenleri genellikle Client Component'tir.
* **Mimari Kural:** İstemci bileşenleri ağacın (tree) mümkün olan en "yaprak" (leaf) noktasına itilmelidir. Koca bir sayfayı `"use client"` yapmak mimari bir hatadır.

## 4. Yeni Bir Bileşen Eklerken Karar Ağacı ve AI Kuralları

Yeni bir arayüz çizerken (veya AI'a kodlatırken) şu hiyerarşi izlenir:

1. **Hazır Bileşen:** İhtiyaç duyulan bileşen Shadcn'de var mı? -> Varsa `npx shadcn-ui@latest add [bileşen-adı]` ile projeye dahil et.
2. **Kompozisyon:** Yoksa, mevcut Shadcn UI bileşenleri birleştirilerek oluşturulabilir mi? -> Varsa öyle yap.
3. **Özel Üretim ve ADR (Seviye 2 Karar):** Sistemle çözülemiyorsa, `#frontend` kanalında Otorite'den (Bkz: `yetkinlik-ve-etki-alani.md`) onay alınarak inşa edilir.

🚨 **AI ve Geliştirici İçin Zorunlu Kontroller:**
Sıfırdan üretilen (Özel Üretim) her UI bileşeni şu standartları sağlamak zorundadır:

* [ ] Klavye navigasyonunu (Tab ile gezilebilirliği) desteklemelidir.
* [ ] Gerekli `aria-` etiketlerini barındırmalıdır (Erişilebilirlik).
* [ ] Dışarıdan `className` prop'u kabul etmeli ve bunu `cn(defaultClasses, className)` şeklinde işlemelidir.