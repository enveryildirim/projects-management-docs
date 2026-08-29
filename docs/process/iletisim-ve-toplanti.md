# İletişim ve Toplantı Manifestosu

> **Bu doküman ne işe yarar?**
> Ekip içindeki bilgi akışının, toplantı kültürünün ve geri bildirim (feedback) süreçlerinin nasıl yürümesi gerektiğini tanımlar. Amacımız; birbirimizin zamanına saygı duymak, bağlam değiştirme (context switching) maliyetini sıfırlamak ve derin çalışmaya (deep work) maksimum odaklanma sağlamaktır.

---

> 💡 **Ana Kuralımız:** Odaklanmış çalışma süresi önemlidir. İletişimi ağırlıklı olarak asenkron ve yazılı yürütmeyi taahhüt ediyoruz.

## 1. Toplantı Kuralları ve Ret Hakkı (Right to Decline)

Toplantılar iş yapmak için değil, bilgi paylaşımının ve yazılı tartışmanın tıkandığı durumlarda **karar almak** için yapılır.

* **Toplantı Tipleri:** Operasyonel senkronizasyon (Sync) toplantıları maksimum 30 dakikadır. Mimari Tasarım (ADR), Kök Neden Analizi (Post-Mortem) veya Sprint Planlama gibi 'Derin Çalıştaylar (Workshops)' 60-90 dakika olabilir; ancak öncesinde okuma dokümanlarının paylaşılmış olması zorunludur.
* **Reddetme Hakkı (Right to Decline):** Bir toplantı davetinde net bir gündem ve beklenen karar/çıktı yoksa veya Odak Günü (Çarşamba) ihlal ediliyorsa, katılımcıların daveti **cezasız (penalty-free) reddetme hakkı** sistem tarafından korunur. Gerekçe olarak bu Playbook gösterilir.
* **Odak Günü (No-Meeting Day):** Çarşamba günleri tamamen kod yazmaya ve derin çalışmaya ayrılmıştır. Acil krizler (production down) hariç birbirimizin akışını bölmemeye özen gösteririz.
* **Karar Kaydı (Meeting Notes):** Toplantıyı organize eden kişi, alınan kararları toplantı bitiminde yazılı olarak (ilgili Jira/Linear kartına) ekler.

## 2. Asenkron İletişim ve Bildirim Hijyeni

Anlık mesajlaşma araçları, her zaman anında cevap beklendiği anlamına gelmez.

* **Bağlamı Baştan Paylaşın (No Hello):** "Selam, müsait misin?" yazıp beklemek yasaktır. Konu, denenen yollar ve beklenen aksiyon tek seferde yazılır.
* **Düzenli Akış İçin Thread Kullanımı:** Kanallardaki iletişimin takibini kolaylaştırmak için her zaman "Thread" (Yanıtla) özelliği kullanılır.
* **Toplu Etiketleme Yasağı:** `@here`, `@channel` veya `@everyone` etiketleri **sadece canlı sistem çöktüğünde (Kritik Kriz)** kullanılır. Soru sormak veya duyuru yapmak için toplu etiketleme kullanılamaz; doğrudan ilgili alanın Otoritesi (`CODEOWNERS`) etiketlenir.
* **Durum Bildirimleri (Status):** Odaklanmış çalışma seansına giren bir geliştirici, durumunu "DND (Rahatsız Etmeyin)" olarak günceller. Acil olmayan konularda anlık cevap beklenmez.

## 3. İletişim Kanalları Karar Matrisi

| Durum / İhtiyaç | Kullanılacak Kanal | Beklenen Yanıt Süresi |
| --- | --- | --- |
| **Kritik Kriz (Canlı sistem çöktü)** | Telefon araması / PagerDuty | Anında |
| **Günlük Blokaj (İlerleyemiyorum)** | Slack/Teams ilgili kanal (Thread) | 1-2 Saat içinde |
| **Mimari Karar / PR Review** | ADR Dokümanı / PR Yorumları | 24 Saat içinde (SLA) |
| **Durum Güncellemesi / Rapor** | Jira / Linear kartı yorumları | Asenkron (Görüldüğünde) |

## 4. Asenkron Daily (Walk the Board)

Daily toplantısının amacı "durum raporu vermek" değil, engelleri kaldırmaktır. Çift veri girişi (hem Jira'yı güncelleyip hem Slack'e özet yazmak) idari bir israftır. Jira/Linear board'umuz tek gerçeklik kaynağımızdır (Single Source of Truth).

* Asenkron daily formatımızda "Dün ne yaptım, bugün ne yapacağım" sorusu **sorulmaz**; çünkü kartlar zaten günceldir.
* Formatımız şudur: **1. (Varsa) Beni bloklayan şey X, 2. (Varsa) Review bekleyen PR linkim Y.**
* Engel veya onayı bekleyen PR yoksa, o gün daily yazılmaz, board konuşur.

## 5. Geri Bildirim ve Otomasyon (Feedback)

* **Otomasyon Kötü Adamdır:** Code Review'larda kişisel gerilimi sıfırlamak için, lint kuralları, format hataları ve test başarısızlıkları CI/CD botları tarafından bildirilir. "Kodu düzelt" uyarısını insan değil, sistem yapar. İnsanlar mimariye ve iş mantığına odaklanır.
* **Kişiye Değil, İşe Yönelik Eleştiri:** PR yorumları doğrudan kodu hedefler. (Örn: "Bunu yanlış yapmışsın" yerine "Bu fonksiyonun performansı şu yaklaşımla iyileştirilebilir mi?")
* **Özelde Eleştir, Herkesin İçinde Takdir Et:** Yapıcı eleştiriler her zaman 1-on-1 görüşmelerde; başarılar ise genel kanallarda paylaşılır.
* **Açık İletişim (Radical Candor):** Sorunları hasıraltı etmek projeye zarar verir. İletişimde doğrudan, net ancak karşı tarafı önemseyen bir tutum sergilenir.

---

## 6. Kurulum ve Aksiyon Adımları (To-Do)

Bu kuralları günlük operasyona entegre etmek için aşağıdaki adımları tamamlayın:

* [ ] **Slack/Teams Profil Optimizasyonu:** Tüm ekip üyeleri, çalışma saatlerini (Working Hours) ve bildirim ayarlarını (DND schedule) iletişim platformlarında yapılandırsın.
* [ ] **Toplantı Varsayılanlarını Değiştirme:** Google Workspace veya Outlook ayarlarında varsayılan toplantı süresini "30 Dakika" olarak ve "Speedy Meetings" (5 dakika erken bitirme) özelliğini aktif edin.
* [ ] **CI/CD - İletişim Entegrasyonu:** GitHub/GitLab PR botlarını Slack/Teams'e bağlayın. PR açıldığında geliştiricinin manuel mesaj atmasına gerek kalmadan, ilgili kanal (veya CODEOWNERS) otomatik etiketlensin.
* [ ] **Jira/Linear Temizliği:** Asenkron "Walk the Board" pratiğinin çalışabilmesi için her geliştiricinin gün sonunda üzerinde çalıştığı kartın durumunu (In Progress, Review) mutlaka güncelleme alışkanlığını oturtun.