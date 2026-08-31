# İletişim ve Toplantı Manifestosu

> **Bu Dokümanın Amacı**
> Ekip içerisindeki bilgi akışının, toplantı kültürünün ve geri bildirim (feedback) süreçlerinin standartlarını belirlemektir. Temel hedefimiz; tüm çalışanlarımızın zamanına saygı duymak, bağlam değiştirme (context switching) maliyetlerini asgari düzeye indirmek ve derin çalışmaya (deep work) azami odaklanmayı sağlamaktır.

---

> 💡 **Temel Prensibimiz:** Odaklanmış çalışma süresi kurumumuz için kritik öneme sahiptir. İletişim süreçlerimizin ağırlıklı olarak asenkron ve yazılı formatta yürütülmesini taahhüt ediyoruz.

## 1. Toplantı Kuralları ve Ret Hakkı (Right to Decline)

Toplantılar, doğrudan operasyonel iş üretmek amacıyla değil; bilgi paylaşımının ve yazılı müzakerelerin yetersiz kaldığı durumlarda **karar almak** maksadıyla organize edilmelidir.

* **Toplantı Sınıflandırmaları:** Operasyonel senkronizasyon toplantıları azami 30 dakika ile sınırlandırılmıştır. Mimari Tasarım (ADR), Kök Neden Analizi (Post-Mortem) veya Sprint Planlama gibi 'Derinlemesine Çalıştaylar (Workshops)' 60-90 dakika aralığında planlanabilir; ancak bu toplantılardan önce hazırlık dokümanlarının katılımcılarla paylaşılmış olması zorunludur.
* **Reddetme Hakkı (Right to Decline):** Bir toplantı davetinde net bir gündem maddesi ve beklenen karar/çıktı tanımlanmamışsa veya Odak Günü (Çarşamba) prensibi ihlal ediliyorsa, katılımcıların ilgili daveti **herhangi bir yaptırım olmaksızın (penalty-free) reddetme hakkı** kurumsal politikamızla güvence altına alınmıştır. Bu işlemde, gerekçe olarak işbu doküman referans gösterilmelidir.
* **Odak Günü (No-Meeting Day):** Çarşamba günleri, mühendislik ekibinin tamamen kod geliştirmeye ve derin çalışmaya odaklanması amacıyla toplantısız gün olarak tahsis edilmiştir. Kritik sistem kesintileri (production down) haricinde, çalışanlarımızın iş akışını bölmemeye azami özen gösterilmelidir.
* **Karar Kayıtları (Meeting Notes):** Toplantıyı organize eden sorumlu, alınan kararları toplantı bitiminde yazılı hale getirerek ilgili Jira/Linear görev kartına eklemekle yükümlüdür.

## 2. Asenkron İletişim ve Bildirim Hijyeni

Anlık mesajlaşma araçlarının kullanımı, her iletiye anında yanıt beklendiği anlamını taşımaz.

* **Bağlamın Öncelikli Paylaşımı (No Hello Kuralı):** Yalnızca selamlama mesajı ileterek karşı tarafın yanıtını beklemek kurumsal iletişim standartlarımıza aykırıdır. Konunun içeriği, daha önce denenen çözüm yolları ve karşı taraftan beklenen aksiyon tek bir mesajda bütüncül olarak iletilmelidir.
* **Düzenli İletişim Akışı İçin Thread Kullanımı:** İletişim kanallarında konu bütünlüğünün korunması ve takibin kolaylaştırılması amacıyla her zaman "Thread" (Yanıtla) özelliği kullanılmalıdır.
* **Toplu Etiketleme Kısıtlamaları:** `@here`, `@channel` veya `@everyone` etiketleri **yalnızca canlı sistem kesintileri gibi kritik kriz durumlarında** kullanılabilir. Soru sormak veya genel duyurular yapmak amacıyla toplu etiketleme yapılamaz; bunun yerine doğrudan ilgili teknik alanın Otoritesi (`CODEOWNERS`) etiketlenmelidir.
* **Durum Bildirimleri (Status):** Odaklanmış çalışma seansına dahil olan bir çalışanımız, durumunu "Rahatsız Etmeyin (DND)" olarak güncellemelidir. Aciliyet arz etmeyen konularda anlık yanıt beklentisine girilmemelidir.

## 3. İletişim Kanalları Karar Matrisi

| Durum / İhtiyaç | Kullanılacak Kanal | Beklenen Yanıt Süresi (SLA) |
| --- | --- | --- |
| **Kritik Kriz (Canlı sistem kesintisi)** | Telefon araması / PagerDuty | Anında |
| **Günlük Operasyonel Blokaj (İlerleyememe durumu)** | Slack/Teams ilgili kanal (Thread) | 1-2 Saat içerisinde |
| **Mimari Karar Onayı / PR Gözden Geçirme** | ADR Dokümanı / PR Yorumları | 24 Saat içerisinde |
| **Durum Güncellemesi / Raporlama** | Jira / Linear kartı yorumları | Asenkron (Görüldüğünde) |

## 4. Asenkron Günlük Değerlendirme (Walk the Board)

Günlük (Daily) toplantıların amacı "durum raporu sunmak" değil, süreçteki darboğazları tespit edip ortadan kaldırmaktır. Mükerrer veri girişi (hem Jira'nın güncellenmesi hem de iletişim kanallarına özet geçilmesi) operasyonel bir israftır. Kurumumuzda Jira/Linear panoları, tek doğru bilgi kaynağı (Single Source of Truth) olarak kabul edilmektedir.

* Asenkron günlük değerlendirme formatımızda "Dün ne yaptım, bugün ne yapacağım?" sorusuna yer **verilmez**; zira görev kartlarının güncelliği esastır.
* Formatımız şu şekildedir: **1. (Mevcutsa) Sürecimi engelleyen blokaj durumu X, 2. (Mevcutsa) İnceleme (Review) bekleyen PR bağlantım Y.**
* Herhangi bir engel veya onay bekleyen PR bulunmuyorsa, o gün için bildirim yapılmasına gerek yoktur; görev panosunun mevcut durumu yeterlidir.

## 5. Geri Bildirim ve Otomasyon (Feedback)

* **Sistem Tabanlı Geri Bildirimler:** Kod gözden geçirme (Code Review) süreçlerinde kişisel algılanabilecek gerilimleri ortadan kaldırmak adına; lint kural ihlalleri, formatlama hataları ve test başarısızlıkları doğrudan CI/CD botları tarafından raporlanır. Düzeltme uyarıları insan eliyle değil, sistem tarafından iletilir. Ekiplerimiz ise yalnızca mimari yapıya ve iş mantığına (business logic) odaklanmalıdır.
* **İşe Odaklı Eleştiri Yaklaşımı:** PR yorumları doğrudan kodun kalitesini ve verimliliğini hedeflemelidir. (Örneğin: "Bunu yanlış yapmışsın" yerine "Bu fonksiyonun performansı, şu yaklaşımla daha verimli hale getirilebilir mi?" şeklinde ifade edilmelidir.)
* **Birebir Eleştiri, Açık Takdir:** Gelişim odaklı yapıcı eleştiriler her zaman birebir (1-on-1) görüşmelerde iletilirken; başarılar ve olumlu katkılar genel iletişim kanallarında kurum geneliyle paylaşılır.
* **Şeffaf İletişim (Radical Candor):** Karşılaşılan sorunların gizlenmesi veya ertelenmesi proje sağlığına zarar verir. İletişim süreçlerimizde doğrudan, net, aynı zamanda meslektaşlarımıza saygı ve değer veren bir tutum sergilenmesi esastır.

---

## 6. Kurulum ve Aksiyon Adımları (Görevler)

Bu prensiplerin günlük operasyonlarımıza entegre edilmesi için aşağıdaki adımların tamamlanması gerekmektedir:

* [ ] **Slack/Teams Profil Optimizasyonu:** Tüm ekip üyeleri, çalışma saatlerini (Working Hours) ve bildirim kısıtlama ayarlarını (DND schedule) kullandıkları iletişim platformlarında yapılandırmalıdır.
* [ ] **Toplantı Varsayılanlarının Güncellenmesi:** Google Workspace veya Outlook takvim ayarlarında varsayılan toplantı süresi "30 Dakika" olarak belirlenmeli ve "Hızlı Toplantılar (Speedy Meetings - 5 dakika erken bitirme)" özelliği aktif hale getirilmelidir.
* [ ] **CI/CD - İletişim Entegrasyonu:** GitHub/GitLab PR botları, kullanılan Slack/Teams çalışma alanlarına entegre edilmelidir. Yeni bir PR oluşturulduğunda, geliştiricinin manuel bildirim yapmasına gerek kalmadan ilgili kanal (veya CODEOWNERS) sistem tarafından otomatik olarak etiketlenmelidir.
* [ ] **Jira/Linear Veri Hijyeni:** Asenkron "Walk the Board" pratiğinin sağlıklı işleyebilmesi adına, her geliştiricinin mesai bitiminde üzerinde çalıştığı kartın güncel durumunu (In Progress, Review vb.) panoda eksiksiz olarak güncellemesi standart bir alışkanlık haline getirilmelidir.

---

*Son Güncelleme: 2026-08-31 — Versiyon 1.1 — Doküman Sahibi: Engineering Manager*
