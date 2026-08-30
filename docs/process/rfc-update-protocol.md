# Playbook Güncelleme Protokolü (Request for Comments - RFC)

> **Dokümanın Amacı**
> İşbu doküman, Mühendislik Playbook'unun statik bir yapıya dönüşmesini engellemek amacıyla hazırlanmıştır. Organizasyonumuz büyüdükçe veya teknolojik altyapılar güncellendikçe; kuralların (felsefe, süreç ve araçlar), ampirik verilere dayalı ve şeffaf bir prosedür çerçevesinde nasıl değiştirileceğini standart altına alır.

## 1. RFC (Request for Comments) Gereksinimi

Süreç ve kurallar; standart dışı iletişim kanalları (örn. anlık mesajlaşma uygulamaları), anlık kararlar veya şeffaf olmayan yönetimsel inisiyatiflerle değiştirilmemelidir. Kurumumuzda, Playbook dokümantasyonu "Kod Olarak Dokümantasyon" (Docs-as-Code) prensibiyle yönetilmektedir. Herhangi bir kural değişikliği, üretim (production) kodunda yapılan bir değişiklik ile eşdeğer kritiklik seviyesinde değerlendirilir ve sistem üzerinde kalıcı bir denetim izi (log) bırakması zorunludur.

## 2. Güncelleme Sınıflandırması (Triage)

Tüm değişiklik talepleri aynı risk ve etki seviyesine sahip değildir. Süreçlerdeki karmaşayı (entropi) önlemek ve operasyonel hızı korumak adına güncellemeler iki ana kategoriye ayrılmaktadır:

* ⚡ **Hızlı İzlem (Fast-Track):** Yazım hatalarının giderilmesi, çalışmayan bağlantıların (linklerin) onarılması veya mevcut bir kuralı daha anlaşılır kılan minimal metin eklemeleri.
* *Süreç:* Standart bir Pull Request (PR) oluşturulur. Herhangi bir Uzman (U) veya Otorite (O) tarafından (Bkz: `competency-and-raci.md`) Kod İncelemesi (Code Review) prensipleri doğrultusunda anında onaylanıp ana dala aktarılabilir (merge). Bekleme süresi (SLA) şartı aranmaz.

* 🏛️ **Çekirdek Değişiklik (Core RFC):** Teknoloji yığınında (Tech Stack) yapılacak değişiklikler (Örn: Tailwind'den PandaCSS'e geçiş), süreç güncellemeleri (Örn: Yeni bir Bitti Tanımı (DoD) veya Hazır Tanımı (DoR) maddesinin eklenmesi) veya yeni bir test aracının standartlaştırılması.
* *Süreç:* Aşağıda detaylandırılan üç aşamalı asenkron RFC onay hattından geçmesi zorunludur.

## 3. RFC İşletim Hattı (Çekirdek Değişiklikler İçin)

Bir RFC sürecini başlatmak adına, ilgili Playbook dokümanını güncelleyen bir Pull Request (PR) açılmalı ve PR açıklama (Description) bölümünde aşağıdaki adımlar eksiksiz olarak yerine getirilmelidir:

### Adım 1: Gerekçe ve Argüman (PR Açıklaması Zorunlulukları)

PR açıklamasında aşağıdaki üç sorunun ampirik verilerle yanıtlanması zorunludur (Bu yanıtların eksik veya yetersiz olduğu talepler, ilgili Otoriteler tarafından doğrudan reddedilecektir):

1. **Hangi darboğaz (Bottleneck) çözümlenmektedir?** Mevcut kuralın, sürecin veya aracın organizasyona maliyeti (zaman kaybı, performans düşüklüğü, bilişsel yük artışı vb.) net olarak tanımlanmalıdır.
2. **Fırsat maliyeti ve ödünleşim (Trade-off) durumu nedir?** Yeni kuralın veya aracın entegrasyonu sonucunda hangi mevcut avantajlardan feragat edileceği belirtilmelidir (Örn: "Daha hızlı render süreleri elde edilecek, ancak paket boyutu 50kb artacaktır").
3. **Başarı kriterleri nasıl ölçümlenecektir?** Değişikliğin operasyonel verimliliğe katkısı, hangi DORA metrikleri veya kurum içi operasyonel metrikler (`engineering-metrics.md`) aracılığıyla doğrulanacağı açıklanmalıdır.

### Adım 2: İnceleme ve Değerlendirme (48 Saatlik Asenkron Süreç)

* İlgili değerlendirmeler, PR yorumları üzerinden (GitHub/GitLab platformlarında) asenkron olarak yürütülür. Anlık mesajlaşma araçlarında (Örn: Slack) resmi kararlar alınamaz.
* **Hizmet Seviyesi Sözleşmesi (SLA):** Değişikliğin etki alanındaki Otoritelerin (CODEOWNERS), en geç 48 saat içerisinde değerlendirme sürecine katılım sağlaması ve onay/ret kararlarını iletmesi beklenmektedir.

### Adım 3: Karar ve Üst Merciye Taşıma (Eskalasyon - Seviye 3 Yetki)

* **Uzlaşma (Konsensüs):** 48 saatlik sürenin sonunda projeyi sekteye uğratacak (bloklayıcı) majör bir itiraz bulunmaması ve ilgili Otorite(ler)in onay vermesi halinde PR birleştirilir (merge).
* **Uzlaşmazlık (Eskalasyon):** 48 saat sonunda ortak bir karara varılamaması durumunda, süreç `decision-making-authority.md` dokümanındaki Seviye 3 kuralı uyarınca Tech Lead veya Engineering Manager'a eskale edilir. Sürecin gereksiz yere uzamasına ("analiz felci") müsaade edilmez; ilgili lider inisiyatif alarak kararı bağlar ve gerekçesini PR üzerinde dokümante ederek işlemi sonlandırır (Merge veya Close). Kararsızlık durumunun kalıcı hale gelmesine izin verilmez.

## 4. Ret Edilen Kararların Saklanması

Bir RFC (PR) talebinin reddedilmesi durumunda, ilgili PR kapatılır (Closed) ancak sistemden silinmez. Gelecekte benzer bir konuyu yeniden gündeme getirmeyi planlayan geliştiricilerin, geçmiş PR kayıtlarındaki tartışma tarihçesini ve değerlendirilen ödünleşimleri (trade-off) incelemesi zorunludur.

---

*Son güncelleme: 2026-08-29 — Sorumlu: Engineering Manager*
