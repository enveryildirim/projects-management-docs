# P0-P4 Önceliklendirme Çerçevesi

P0-P4 Önceliklendirme Çerçevesi, yazılım geliştirme ve ürün yönetimi süreçlerinde karşılaşılan operasyonel olayların (incident) ve geliştirme görevlerinin (task) aciliyet ve etki seviyelerine göre standart bir yapıda sınıflandırılmasını sağlayan referans modelidir.

Bu sınıflandırma metodolojisi, acil ve önemli görevlerin birbirinden ayrıştırılarak kaynakların doğru zamanda doğru önceliklere yönlendirilmesini güvence altına almaktadır.

## Öncelik Seviyeleri (Priority Levels)

| Seviye | Aciliyet | Etki | Örnek Durumlar | Beklenen Yanıt ve Aksiyon |
| --- | --- | --- | --- | --- |
| **P0 (Kritik - Critical)** | Kritik | Kapsamlı | Sistem kesintisi, üretim (production) ortamının durması, tüm kullanıcı tabanını etkileyen majör zafiyetler. | **Acil.** Mevcut tüm operasyonlar derhal durdurulur ve tüm odak problemin çözümüne yönlendirilir. (Existential Crises). |
| **P1 (Yüksek - High)** | Yüksek | Büyük | Temel bir modülün çalışmaması, kritik iş akışlarının kesintiye uğraması. | **Öncelikli.** İlgili mesai saatleri içerisinde, P0 seviyesi istisna olmak kaydıyla, diğer tüm görevlerden önce çözümlenmelidir. |
| **P2 (Orta - Medium)** | Orta | Orta | İkincil özelliklerin çalışmaması, geçici çözümü (workaround) bulunan hatalar, planlı standart geliştirmeler. | **Önemli.** Rutin sprint planlaması dahilinde, diğer P2 seviyesindeki işlerle kıyaslanarak önceliklendirilir. Ani müdahale gerektirmez ancak iş planında yüksek öneme sahiptir. |
| **P3 (Düşük - Low)** | Düşük | Küçük | Sınırlı sayıda kullanıcıyı etkileyen durumlar, arayüz iyileştirmeleri veya minör kullanıcı deneyimi optimizasyonları. | **Ertelenebilir.** Rutin operasyonların bir parçasıdır. Geliştirme döngüsünde kaynak uygunluğu sağlandığında veya daha yüksek öncelikli görevler tamamlandığında işleme alınır (Tasks That Can Wait). |
| **P4 (En Düşük - Lowest)** | Önemsiz | Önemsiz | Kullanıcı operasyonlarını etkilemeyen minör pürüzler, uzun vadeli AR-GE fikirleri veya deneysel eklentiler. | **Backlog.** Kısa vadede planlamaya dahil edilmez. Gelecek dönemlerde kaynak optimizasyonu sağlandığında değerlendirilmek üzere ürün birikim listesinde (backlog) muhafaza edilir. |

## P0 ve P1 Seviyeleri Arasındaki Stratejik Fark

P0 ve P1 seviyelerinin her ikisi de aciliyet arz etmekle birlikte, aralarındaki temel ayrım **durumun kurumsal bir kriz teşkil edip etmediğidir**:
* **P0**, mesai saatlerinden bağımsız olarak derhal müdahale edilmesi ve ilgili tüm ekiplerin seferber edilmesini gerektiren kritik bir kriz durumudur (Örnek: Hassas veri sızıntısı, ana ödeme altyapısının tamamen çökmesi).
* **P1**, yüksek öneme sahip olmakla birlikte, tüm kurumun operasyonlarını durdurmasını gerektirmeyen durumlardır. Standart mesai saatleri dahilinde ilk fırsatta çözümlenmesi gereken, etki alanı geniş fakat sistemi bütünüyle işlevsiz kılmayan hatalardır (Örnek: Raporlama modülünün veri getirememesi).

## P1 ve P2 Seviyeleri Arasındaki Ayrım
* **P1**, tekil bir arızadır ve kullanıcı tabanının büyük bir bölümünü etkiler. Rutin geliştirme süreçlerinin önüne geçerek derhal ele alınması gerekir.
* **P2**, genellikle daha spesifik bir kullanıcı segmentini etkiler ve sistemde birden fazla P2 kaydı bulunabilir. ICE Skorlaması gibi analitik önceliklendirme teknikleriyle kendi içlerinde sıralanarak standart geliştirme döngüsüne (sprint) dahil edilirler.

> **Kurumsal Prensip:** Her sistem hatasının "P0" veya "P1" olarak etiketlenmesi, ekiplerde alarm yorgunluğuna (alert fatigue) yol açar ve gerçek kriz durumlarındaki müdahale reflekslerini zayıflatır. Önceliklendirme yapılırken analitik veriler (impact) esas alınmalı ve objektif değerlendirme yapılmalıdır.
