# Playbook Güncelleme Protokolü (Request for Comments - RFC)

> **Bu doküman ne işe yarar?**
> Mühendislik Playbook'unun statik bir dogmaya dönüşmesini engeller. Ekip büyüdükçe veya teknolojiler eskidikçe kuralların (felsefe, süreç, araçlar) ampirik ve şeffaf bir şekilde nasıl değiştirileceğini tanımlar.

## 1. Neden RFC (Request for Comments)?

Kurallar Slack mesajlarıyla, anlık heveslerle veya kapalı kapılar ardındaki yönetici kararlarıyla değiştirilemez. Playbook'u kod gibi yönetiyoruz (Docs-as-Code). Bir kuralı değiştirmek, üretim kodunu değiştirmekle eşdeğer ciddiyettedir ve kalıcı bir kayıt (log) bırakmalıdır.

## 2. Güncelleme Sınıfları (Triage)

Her değişiklik aynı ağırlıkta değildir. Entropiyi önlemek ve hızı korumak için değişiklikler ikiye ayrılır:

* ⚡ **Fast-Track (Hızlı Yol):** Yazım hataları, kırık linkler, mevcut bir kuralı netleştiren küçük cümle eklemeleri.
* *Süreç:* Standart bir PR açılır. Herhangi bir Uzman (U) veya Otorite (O) tarafından (Bkz: `yetkinlik-ve-etki-alani.md`) Code Review mantığıyla anında onaylanıp merge edilebilir. Bekleme süresi yoktur.


* 🏛️ **Core RFC (Çekirdek Değişiklik):** Teknoloji yığını değişikliği (Örn: Tailwind -> PandaCSS), süreç değişikliği (Örn: Yeni bir DoD/DoR maddesi), yeni bir test aracının zorunlu kılınması.
* *Süreç:* Aşağıdaki 3 adımlı asenkron RFC hattından geçmek zorundadır.



## 3. RFC İşletim Hattı (Core Değişiklikler İçin)

Bir RFC sürecini başlatmak için repo üzerinde playbook dokümanını güncelleyen bir Pull Request (PR) açılır ve PR açıklamasında (Description) aşağıdaki adımlar işletilir:

### Adım 1: Kanıt ve Argüman (PR Açıklaması Zorunlulukları)

PR açıklamasında şu 3 soru ampirik verilerle cevaplanmak zorundadır (Bu soruların eksik olduğu PR'lar Otoriteler tarafından anında reddedilir):

1. **Hangi darboğazı (Bottleneck) çözüyoruz?** Mevcut kuralın, sürecin veya aracın bize maliyeti (zaman, performans, bilişsel yük) nedir?
2. **Fırsat maliyeti ve Takas (Trade-off) nedir?** Bu yeni kuralı/aracı getirirsek neyden feragat ediyoruz? (Örn: "Daha hızlı render alacağız ama paket boyutu 50kb büyüyecek").
3. **Başarıyı nasıl ölçeceğiz?** Değişikliğin işe yaradığını hangi DORA metrikleri veya operasyonel metrikle (`engineering-metrics.md`) kanıtlayacağız?

### Adım 2: İnceleme (48 Saatlik Asenkron Tartışma)

* Tartışmalar PR yorumlarında (GitHub/GitLab) asenkron olarak döner. Slack'te karara bağlanmaz.
* **SLA:** Değişikliğin etkilediği alanın Otoritelerinin (CODEOWNERS) 48 saat içinde tartışmaya katılması veya onay/ret vermesi beklenir.

### Adım 3: Karar ve Eskalasyon (Seviye 3 Yetki)

* **Uzlaşma:** 48 saat sonunda majör, bloklayıcı bir itiraz yoksa ve ilgili Otorite(ler) onaylamışsa PR merge edilir.
* **Uzlaşmazlık (Eskalasyon):** 48 saat sonunda konsensüs sağlanamazsa, konu `karar-verme-yetkisi.md` Seviye 3 kuralı gereği Tech Lead veya Engineering Manager'a eskale edilir. Uzun süren "analiz felci" yasaktır; lider inisiyatif alır, kararı bağlar ve gerekçesini PR'a yazarak işlemi sonlandırır (Merge veya Close). *Kararsızlık kalıcı hale getirilemez.*

## 4. Karar Mezarlığı Yok

Bir RFC (PR) reddedildiyse, PR kapatılır (Closed) ancak silinmez. Aylar sonra aynı konuyu gündeme getirmek isteyen bir geliştirici, geçmiş PR'daki tartışma tarihçesini ve trade-off'ları okumakla yükümlüdür.

---

*Son güncelleme: 2026-08-29 — Sahibi: Engineering Manager*
