# Tasarım Sistemi ve UI Referansı (Golden Path)

> **Dokümanın Amacı**
> Bu doküman, proje arayüzlerinin tutarlılığını temin etmeyi amaçlamaktadır. Bileşenlerin mükerrer olarak geliştirilmesini önler; Next.js App Router standartlarına uygun render stratejilerini (RSC ve Client) ve Tailwind tema mimarisini belirler.

## 1. Araç Seti ve Temel Kurallar

* **CSS Framework:** Tailwind CSS
* **Bileşen Kütüphanesi:** Shadcn UI (Radix tabanlı, erişilebilirlik standartlarına uygun bileşenler)
* **İkonlar:** Lucide Icons
* **Stil Birleştirme (Composition):** `cn()` yardımcı fonksiyonu (`clsx` + `tailwind-merge`)

> 💡 **Temel Prensip:** Özel (custom) CSS yazımı kurum standartlarımızca uygun bulunmamaktadır. Koşullu (conditional) veya dışarıdan sağlanan sınıfların (prop olarak iletilen `className`) birleştirilmesi işlemlerinde istisnasız olarak `cn()` fonksiyonu kullanılmalıdır. Aksi durumlarda Tailwind CSS kaskad çakışmaları meydana gelebilmektedir.

## 2. Tailwind CSS ve Tema Kuralları

* **Semantik Renk Değişkenleri:** Renk kodlarının (Örn: `text-gray-500` veya `#ff0000`) doğrudan kod içerisine yazılması (hardcoding) uygun değildir. Bunun yerine tema değişkenleri (`text-muted-foreground`, `bg-destructive`) kullanılmalıdır. Bu yaklaşım, karanlık mod (Dark Mode) desteğinin koşulsuz olarak sağlanmasını güvence altına alır.
* **Gelişigüzel Değerler (Arbitrary Values) İstisnası:** `w-[325px]` gibi spesifik piksel değerleri, yalnızca sistem dışından entegre edilen 3. parti yazılımlar veya kesin marka logosu kısıtlamaları söz konusu olduğunda kullanılabilir. Belirtilen istisnalar haricinde, sistemin tanımlı `spacing` skalasının dışına çıkılmamalıdır.
* **Mobil Öncelikli Tasarım:** Tasarımlarımız varsayılan olarak mobil odaklıdır. Tablet ve masaüstü görünümleri için `md:` ve `lg:` kesim noktaları (breakpoint) kullanılmalıdır (Örn: `flex-col md:flex-row`).

## 3. Next.js Bileşen (Component) Mimarisi (App Router)

Bileşen mimarimiz, geleneksel Smart/Dumb ayrımı yerine performans ve güvenlik kriterleri göz önünde bulundurularak **Server ve Client** prensibi doğrultusunda iki ana kategoriye ayrılmaktadır:

### 3.1. Server Components (Varsayılan)

* İş mantığını barındırır; doğrudan veritabanı bağlantılarını gerçekleştirir veya veri çekme (fetch) isteklerini yönetir (`async/await` yapısını kullanır).
* JavaScript paket (bundle) boyutuna etki etmez (sıfır boyutludur) ve SEO standartlarına tam uyumludur.
* **Kısıtlamalar:** `useState`, `useEffect`, `onClick` gibi interaktif hook'ların veya olay dinleyicilerinin (event listener) KULLANILMASI MÜMKÜN DEĞİLDİR.

### 3.2. Client Components (`"use client"`)

* Yalnızca kullanıcı etkileşimi (tıklama, form doldurma), animasyon süreçleri veya tarayıcı API'lerinin (localStorage vb.) kullanımının zorunlu olduğu durumlarda tercih edilmelidir.
* `src/components/ui/` dizininde yer alan Shadcn bileşenleri genellikle Client Component yapısındadır.
* **Mimari Kural:** İstemci bileşenleri, bileşen ağacının (tree) mümkün olan en uç noktalarına (leaf) yerleştirilmelidir. Sayfanın tamamının `"use client"` olarak tanımlanması mimari bir ihlal olarak değerlendirilir.

## 4. Yeni Bir Bileşen Eklerken İzlenecek Karar Ağacı ve AI Kuralları

Yeni bir arayüz bileşeni geliştirilirken (veya AI araçları ile oluşturulurken) aşağıdaki hiyerarşik adımlar izlenmelidir:

1. **Hazır Bileşen Kullanımı:** İhtiyaç duyulan bileşen Shadcn kütüphanesinde mevcut mudur? -> Mevcut ise `npx shadcn-ui@latest add [bileşen-adı]` komutu ile projeye entegre ediniz.
2. **Kompozisyon (Birleştirme):** Hazır bir bileşen bulunmuyorsa, mevcut Shadcn UI bileşenleri birleştirilerek yeni bir yapı oluşturulabilir mi? -> Mümkünse bu yöntemi tercih ediniz.
3. **Özel Geliştirme ve ADR (Seviye 2 Karar):** İhtiyaç sistemin mevcut olanaklarıyla çözülemiyorsa, `#frontend` iletişim kanalında yetkili birimden (Bkz: `competency-and-raci.md`) onay alınarak geliştirme sürecine başlanmalıdır.

🚨 **AI ve Geliştirici İçin Zorunlu Kontrol Listesi:**
Sıfırdan tasarlanan (Özel Üretim) her UI bileşeni, aşağıdaki kalite standartlarını sağlamakla yükümlüdür:

* [ ] Klavye navigasyonunu (Tab tuşu ile erişilebilirliği) tam olarak desteklemelidir.
* [ ] Gerekli `aria-` etiketlerini içermelidir (Erişilebilirlik standartları).
* [ ] Dışarıdan `className` özelliğini (prop) kabul etmeli ve bu parametreyi `cn(defaultClasses, className)` formatında işleyebilmelidir.