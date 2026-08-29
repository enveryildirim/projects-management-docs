# Definition of Ready (DoR) - Geliştirmeye Hazır Kriterleri

> **Bu doküman ne işe yarar?**
> Bir görevin yazılım ekibine iletilmeden ve kodlanmaya başlanmadan önce sağlaması gereken asgari şartları tanımlar. Bu kurallar, eksik analizle geliştirme yapmanın (ve sonradan kodu çöpe atmanın) önüne geçmek için tasarlanmıştır.

> 💡 **Sistemik Kural:** Aşağıdaki *tüm* şartlar sağlanmamışsa, geliştirici görevi "Halt on Ambiguity" (Belirsizlikte Dur) prensibi gereği reddetmekle ve Ürün Yöneticisine (PM) iade etmekle yükümlüdür.

## 1. 🎯 Ürün, Kapsam ve Hipotez (Ürün Felsefesi Uyumlu)

- [ ] **Kök Neden ve Hipotez Belli:** "Kullanıcı bunu neden istiyor?" (5 Neden) cevaplandı. Görevin başarı metriği (Örn: "Dönüşüm oranı %2 artacak") açıkça tanımlandı.
- [ ] **Kabul Kriterleri (Acceptance Criteria):** İşin nasıl test edileceği Given-When-Then formatında net bir şekilde yazıldı.
- [ ] **Görev Boyutu Uygun:** Görev, bir geliştiricinin maksimum 3 gününde bitirebileceği (kapsamı sınırlandırılmış - scope bounded) alt parçalara bölündü.

## 2. 🎨 Tasarım ve Arayüz (Frontend İşleri İçin)

- [ ] **Tasarım Linki Ekli:** Tasarım dosyaları (Figma vb.) karta bağlandı.
- [ ] **Uç Durumlar (Edge Cases) Çizilmiş:** Sadece Happy Path değil; "Boş (Empty)", "Yükleniyor (Loading)" ve "Hata (Error)" durumları tanımlandı.
- [ ] **Tasarım Sistemi Uyumu:** Arayüz, projedeki "Altın Yol" (Golden Path) UI bileşenlerine uygun tasarlandı. (Yeni bileşen icadı gerekiyorsa önceden belirtildi).

## 3. ⚙️ Teknik, AI ve Bağımlılıklar

- [ ] **API/Veritabanı Hazır:** Frontend çalışacaksa API uçları (endpoint) dokümante edildi veya mock datalar (/mocks) sağlandı.
- [ ] **Sistem Mimarisi ve Dış Bağımlılıklar:** Mimari etki veya 3. parti API kullanımı varsa karta not edildi. Başka bir ekibin/kişinin işini bitirmesi beklenmiyor.
- [ ] **Güvenlik ve Veri Sınıflandırması:** Sağlık verisi (KVKK/HIPAA) işlenecekse veya dışarıya veri çıkacaksa, anonimleştirme kuralları belirtildi.