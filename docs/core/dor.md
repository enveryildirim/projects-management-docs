# Geliştirmeye Hazır Kriterleri (Definition of Ready - DoR)

> **Bu dokümanın amacı nedir?**
> Herhangi bir yazılım geliştirme görevinin mühendislik ekibine atanmadan ve kodlanmaya başlanmadan önce sağlaması gereken asgari kurumsal şartları tanımlamaktır. Bu standartlar, eksik analizle geliştirme süreçlerine başlanmasının ve kaynak israfının önüne geçmek amacıyla tasarlanmıştır.

> 💡 **Kurumsal Sistem Kuralı:** Aşağıda listelenen şartların *tamamı* sağlanmadığı takdirde, geliştirici "Belirsizlikte Dur (Halt on Ambiguity)" prensibi gereğince görevi reddetmek ve gerekli iyileştirmelerin yapılması için Ürün Yöneticisine (PM) iade etmekle yükümlüdür.

## 1. 🎯 Ürün, Kapsam ve Stratejik Uyum (Ürün Felsefesi Entegrasyonu)

- [ ] **Kök Neden ve İş Hipotezi Doğrulanmıştır:** "Kullanıcı bu fonksiyona neden ihtiyaç duymaktadır?" sorusu (5 Neden analizi ile) yanıtlanmıştır. İlgili görevin başarı metrikleri (Örneğin: "Dönüşüm oranında %2 artış sağlanması") açıkça tanımlanmış ve belgelenmiştir.
- [ ] **Kabul Kriterleri (Acceptance Criteria) Belirlenmiştir:** Geliştirilecek modülün test senaryoları "Given-When-Then" (Koşul-Eylem-Sonuç) formatında net bir şekilde ifade edilmiştir.
- [ ] **Görev Kapsamı (Scope) Optimize Edilmiştir:** Görev, bir yazılım mühendisinin **azami 3 iş günü** içerisinde tamamlayabileceği, sınırları net olarak çizilmiş (scope-bounded) alt parçalara ayrıştırılmıştır.
- [ ] **Teslim Edilebilir Dilimleme (Deployable Slicing):** Görev, 3 iş günü içerisinde tek seferde teslim edilemiyorsa; her biri bağımsız olarak üretime çıkabilecek (gerekiyorsa özellik bayrağı/feature flag arkasında) **günlük teslim edilebilir dilimlere** bölünmüştür. Bu kural, [DORA](../process/engineering-metrics.md) "Değişiklik Teslim Süresi < 1 gün" hedefinin görev tanımı seviyesindeki karşılığıdır: 3 gün *görevin* azami ömrü, 1 gün ise *tek bir PR'ın* azami ömrüdür.

## 2. 🎨 Arayüz Tasarımı ve Kullanıcı Deneyimi (Frontend Geliştirmeleri İçin)

- [ ] **Tasarım Varlıkları Bağlanmıştır:** İlgili tüm arayüz tasarım dosyaları (Figma vb.) görev kartına (ticket) entegre edilmiştir.
- [ ] **Uç Durumlar (Edge Cases) Tanımlanmıştır:** Yalnızca ideal akış (Happy Path) değil; veri bulunmama (Empty), işlem devam etme (Loading) ve sistem hatası (Error) durumlarına ait arayüz ve senaryolar tasarlanmıştır.
- [ ] **Tasarım Sistemi Uyumu Sağlanmıştır:** Arayüz tasarımları, kurumun mevcut standart UI bileşen setlerine uygun olarak hazırlanmıştır. Eğer yeni bir UI bileşeni tasarlanması gerekiyorsa, bu durum ayrıca belgelenmiştir.

## 3. ⚙️ Teknik Altyapı, Yapay Zeka ve Sistem Bağımlılıkları

- [ ] **API ve Veritabanı Servisleri Hazırdır:** Frontend (Önyüz) geliştirme süreçleri başlayacaksa, gerekli API uç noktaları (endpoints) dokümante edilmiş veya geliştirme ortamı için mock (sahte) veriler sağlanmıştır.
- [ ] **Sistem Mimarisi ve Dış Bağımlılıklar Netleştirilmiştir:** Geliştirmenin genel mimariye etkileri veya üçüncü parti API bağımlılıkları görev kartında detaylandırılmıştır. Geliştirme süreci, başka bir ekibin operasyonunu tamamlamasına bağlı değildir.
- [ ] **Veri Güvenliği ve Regülasyon Uyumu (KVKK/HIPAA vb.):** Hassas kişisel veya sağlık verilerinin işlenmesi, aktarılması veya saklanması durumlarında veri anonimleştirme ve güvenlik kuralları katı bir şekilde tanımlanmıştır.

---

*Son Güncelleme: 2026-08-31 — Versiyon 1.1 — Doküman Sahibi: Ürün Yöneticisi (PM) / Tech Lead*
