# Karar Verme Yetkisi ve Otonomi (Decision Rights)

> **Bu Dokümanın Amacı**
> Ekip içerisinde hangi kararların, kimler tarafından ve hangi onay mekanizmaları işletilerek alınabileceğini net bir şekilde tanımlamaktır. Temel hedefimiz; operasyonel seviyedeki kararların toplantı yükü yaratmasını önlemek, aynı zamanda stratejik kararların kurumsal yönetişim prensiplerine uygun olarak alınmasını sağlamaktır.

## 1. Bu Dokümanın Gerekliliği

Standart süreç dokümanları (DoD, PR Kuralları vb.) operasyonların "nasıl" yürütüleceğini tanımlarken; karar verme süreçlerindeki yetki ve sorumluluk dağılımı genellikle belirsiz kalabilmektedir.
> 💡 **Temel Felsefe:** Kurumumuzda kararlar, **kişilerin organizasyonel unvanlarına göre değil, Yetkinlik Matrisinde tanımlanmış etki alanlarına (Otorite) istinaden** alınır. Sınırları net olarak çizilmiş otonomi, mühendislik kültürümüzün temelini oluşturur.

## 2. Karar Alma Seviyeleri

### Seviye 1 — Otonom Kararlar (Ön Onay Gerektirmez)
Geliştirici, kendi inisiyatifiyle karar alır ve yapılan değişikliği PR (Pull Request) inceleme sürecinde yalnızca bilgilendirme maksadıyla belirtir.
* **Kapsam:** Fonksiyon/değişken isimlendirmeleri, sistem davranışını değiştirmeyen küçük çaplı iyileştirmeler (refactoring), birim test yazım stratejileri ve kod stili düzenlemeleri.

### Seviye 2 — Onaya Tabi Kararlar (Otorite Onayı Gerektirir)
PR sürecinin zorunlu bir parçası olarak, ilgili teknik alanın "Otoritesi (O)" (Bkz. Yetkinlik ve RACI Matrisi) tarafından resmi onay verilmesi şarttır.

| Karar Kapsamı | Onay Mercii |
|---|---|
| Yeni bir npm/pip paketi veya kütüphane entegrasyonu | İlgili Alanın Otoritesi (O) |
| Veritabanı şeması değişiklikleri (yeni tablo/kolon eklenmesi) | Veritabanı Otoritesi |
| API sözleşmesi (contract) yapısal değişiklikleri | Backend ve Frontend Otoriteleri |
| Performans veya güvenlik boyutunda etki yaratacak mimari iyileştirmeler | İlgili Alanın Otoritesi (O) |
| CI/CD süreç ve pipeline yapılandırma değişiklikleri | DevOps Otoritesi |

### Seviye 3 — Stratejik Ekip Kararları (ADR Süreci Gerektirir)
Geri dönüş maliyeti yüksek olan ve birden fazla ekibin çalışma pratiğini doğrudan etkileyen kararlar sözlü mutabakatla alınamaz; bu süreçler için resmi bir **ADR (Architecture Decision Record - Mimari Karar Kaydı)** oluşturulması zorunludur.
* **Kapsam:** Yeni programlama dili veya framework benimsenmesi, monolitik yapıdan mikroservis mimarisine geçiş, 3. parti kritik altyapı servislerinin (ödeme geçidi, bulut veritabanı vb.) seçimi, süreç ve playbook güncellemeleri.

## 4. Uyuşmazlık Çözümü (Escalation) ve Devir Kuralı (Fallback)

* **Seviye 2 Uyuşmazlıkları:** Otorite ile geliştirici arasında teknik mutabakat sağlanamaması durumunda, konunun nihai çözümü Tech Lead veya Engineering Manager tarafından belirlenir ve gerekçeli karar PR üzerine kayıt olarak düşülür.
* **Seviye 3 Uyuşmazlıkları:** Tartışma ve değerlendirme sürecinin 24 saati aşması halinde, karar mekanizması organizasyonun en üst düzey teknik yöneticisine (escalation) aktarılır. Uzlaşmazlık gerekçesiyle proje süreçlerinin süresiz olarak duraklatılmasına müsaade edilmez.
* **Otoriteye Ulaşılamaması (Fallback Kuralı):** İlgili kararı vermesi beklenen Otorite'nin (O) izinli olması veya 24 saat içerisinde geri dönüş yapamaması durumunda, karar alma yetkisi kurum içi politikalarımız gereği doğrudan o alanın "Uzmanlarına (U)" devredilir. Operasyonel sistem, onay bekleyişi nedeniyle kesinlikle duraklatılamaz.