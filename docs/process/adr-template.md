# Mimari Karar Kayıtları (Architecture Decision Record - ADR) Şablonu

> **Bu dokümanın amacı nedir?**
> Mimari, altyapı, veritabanı ve temel sistem bileşenleri ile ilgili alınan kritik kararların, ileride dönüp bakıldığında "neden böyle yapıldı?" sorusunu cevaplayabilmesi amacıyla kayıt altına alınmasını standartlaştırmaktır. Bir karar önerisi (ADR) oluştururken aşağıdaki şablon kullanılmalıdır.

---

## 1. Başlık [Kısa ve Açıklayıcı Karar Başlığı]

* **Tarih:** YYYY-AA-GG
* **Karar Alıcılar:** [İlgili Otoriteler / Katılımcılar]
* **Durum:** [Önerildi (Proposed) | Kabul Edildi (Accepted) | Reddedildi (Rejected) | Yürürlükten Kaldırıldı (Superseded)]

## 2. Bağlam ve Problem (Context)

Bu bölümde, kararın alınmasına yol açan problem, mevcut durumun yetersizliği veya karşılaşılan teknik kısıtlar nesnel bir dille açıklanmalıdır. 

* Mevcut sistemde ne gibi bir darboğaz veya ihtiyaç bulunmaktadır?
* Bu karar alınmazsa oluşacak riskler nelerdir?

## 3. Değerlendirilen Seçenekler (Considered Options)

Problem için değerlendirilen alternatif çözümler ve bu çözümlerin birbirlerine karşı avantaj ve dezavantajları listelenmelidir.

1. **[Seçenek 1 - Örn: PostgreSQL Kullanmak]:** [Açıklama, Avantajlar ve Dezavantajlar]
2. **[Seçenek 2 - Örn: NoSQL / MongoDB Kullanmak]:** [Açıklama, Avantajlar ve Dezavantajlar]
3. **[Seçenek 3 - Örn: Mevcut Yapıda Kalmak]:** [Açıklama, Avantajlar ve Dezavantajlar]

## 4. Alınan Karar (Decision)

Yukarıdaki seçenekler ışığında hangi alternatifin seçildiği ve bu alternatifin seçilmesindeki **temel etkenler** açıkça ifade edilmelidir.

* **Seçilen Çözüm:** [...]
* **Gerekçe:** [...] (Fırsat maliyeti, takımın mevcut yetkinliği, performans testleri vb. metriklere dayalı argümanlar sunulmalıdır.)

## 5. Sonuçlar ve Etkiler (Consequences)

Bu kararın uygulanmasıyla birlikte teknik borç, performans, güvenlik veya geliştirme eforu anlamında oluşacak sonuçlar (hem olumlu hem de olumsuz) belgelenmelidir.

* **Olumlu Etkiler:** (Örn: Veri tutarlılığı artacak, sorgu performansında %40 iyileşme sağlanacak.)
* **Olumsuz Etkiler / Kısıtlar:** (Örn: Ekibin bu yeni teknolojiye adaptasyonu için öğrenme eğrisi maliyeti doğacak, sunucu maliyetleri %10 artacak.)

## 6. Referanslar

* [Performans Testi Sonuçları veya Proof of Concept (PoC) Linki]
* [Mevcut Dokümantasyon, Makale veya İlgili RFC Bağlantısı]

---

*Son Güncelleme: 2026-08-31 — Versiyon 1.0 — Doküman Sahibi: Tech Lead*
