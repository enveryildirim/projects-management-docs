# Uygulama Profilleri (Lite / Standard / Regulated)

> **Bu dokümanın amacı nedir?**
> Bu çerçevenin tamamının her projeye uygulanmasının sürdürülemez olduğu gerçeğinden hareketle, proje ölçeğine ve regülasyon yüküne göre hangi dokümanların zorunlu, hangilerinin opsiyonel olduğunu tanımlamaktır. Yeni bir projeye başlayan Tech Lead ve Ürün Yöneticisi için ilk okunması gereken dokümandır.

---

## 1. Neden Profil Gerekli?

Yönetişim çerçevelerinin başarısız olmasının birincil nedeni içeriklerinin zayıf olması değil, **projeye oranla aşırı ağır olmalarıdır**. 3 kişilik, 3 aylık bir iş için 48 saatlik RACI onay hattı, ADR süreci ve 20 dokümanlık okuma listesi işletilemez. İşletilemeyen kural bir süre sonra görmezden gelinir; görmezden gelinen ilk kural, diğer tüm kuralların da bağlayıcılığını zayıflatır (Kırık Cam Teorisi).

> 💡 **Temel İlke:** "Her şey her yerde zorunludur" beyanı, pratikte "hiçbir şey zorunlu değildir" sonucunu üretir. Bu nedenle çerçeve bilinçli olarak kademelendirilmiştir.

## 2. Profil Seçim Kriterleri

Proje başlangıcında aşağıdaki tablo esas alınarak profil belirlenir ve proje deposunun `README.md` dosyasına `Playbook Profili: <Lite|Standard|Regulated>` şeklinde yazılır.

| Kriter | Lite | Standard | Regulated |
| --- | --- | --- | --- |
| **Ekip büyüklüğü** | 1-4 mühendis | 5-15 mühendis | Herhangi |
| **Öngörülen ömür** | < 6 ay / PoC / iç araç | Sürekli ürün geliştirme | Sürekli ürün geliştirme |
| **Kullanıcı** | İç kullanıcı veya pilot müşteri | Çoklu müşteri (B2B/B2C) | Çoklu müşteri |
| **Veri hassasiyeti** | Hassas kişisel veri işlenmiyor | Kişisel veri (PII) işleniyor | Sağlık/finansal veri (KVKK/HIPAA/PCI kapsamı) |
| **Kesinti maliyeti** | Tolere edilebilir | İş etkisi yüksek | Sözleşmesel/hukuki yükümlülük |

> ⚠️ **Yükseltme kuralı:** Profil tek yönlü yükseltilir. Bir proje hassas veri işlemeye başladığında veya ilk kurumsal müşteriyi aldığında profil yükseltilir ve eksik dokümanlar bir [RFC](../process/rfc-update-protocol.md) ile devreye alınır. Profil **düşürülemez**.

## 3. Doküman Zorunluluk Matrisi

**✅ Zorunlu** · **🟡 Önerilir** · **⚪ Kapsam dışı**

| Doküman | Lite | Standard | Regulated |
| --- | :--: | :--: | :--: |
| **Core** | | | |
| [Uygulama Profilleri](./profiles.md) | ✅ | ✅ | ✅ |
| [Ürün Felsefesi](./product-philosophy.md) | ✅ | ✅ | ✅ |
| [P0-P4 Önceliklendirme](./p0-p4-prioritization.md) | ✅ | ✅ | ✅ |
| [Definition of Ready (DoR)](./dor.md) | ✅ *(kısaltılmış)* | ✅ | ✅ |
| [Definition of Done (DoD)](./dod.md) | ✅ *(kısaltılmış)* | ✅ | ✅ |
| [Triage Prosedürü](./triage.md) | 🟡 | ✅ | ✅ |
| [Olay Müdahale ve Post-Mortem](./incident-response.md) | ✅ *(sadece severity + rollback)* | ✅ | ✅ |
| [Yapay Zeka Manifestosu](./ai-manifesto.md) | ✅ *(§2 güvenlik zorunlu)* | ✅ | ✅ |
| [Cynefin Çerçevesi](./cynefin.md) | ⚪ | 🟡 | 🟡 |
| [Ürün Vizyon Panosu](./vision-board.md) | 🟡 | ✅ | ✅ |
| **Process** | | | |
| [Oryantasyon ve Kurulum](../process/onboarding-and-setup.md) | ✅ *(sadece kurulum)* | ✅ | ✅ |
| [CI/CD ve Dağıtım](../process/ci-cd-deployment.md) | ✅ *(trunk + rollback)* | ✅ | ✅ |
| [Güvenlik ve Uyum](../process/security-and-compliance.md) | ✅ *(§1 secret yönetimi)* | ✅ | ✅ |
| [Test ve QA Stratejisi](../process/test-qa-strategy.md) | 🟡 | ✅ | ✅ |
| [Telemetri ve Loglama](../process/telemetry-logging.md) | 🟡 | ✅ | ✅ |
| [Karar Verme Yetkisi](../process/decision-making-authority.md) | ⚪ *(tek karar mercii)* | ✅ | ✅ |
| [Yetkinlik Matrisi](../process/competency-matrix.md) | ⚪ | ✅ | ✅ |
| [RACI Matrisi](../process/raci-matrix.md) | ⚪ | 🟡 | ✅ |
| [İletişim ve Toplantı](../process/communication-and-meetings.md) | 🟡 | ✅ | ✅ |
| [ADR Şablonu ve Arşivi](../process/adr-template.md) | 🟡 *(sadece geri dönüşsüz kararlar)* | ✅ | ✅ |
| [RFC Protokolü](../process/rfc-update-protocol.md) | ⚪ | ✅ | ✅ |
| [Dokümantasyon Standartları](../process/documentation-standards.md) | ⚪ | ✅ | ✅ |
| [Mühendislik Metrikleri (DORA)](../process/engineering-metrics.md) | ⚪ | 🟡 | ✅ |
| **Regülasyona özel** | | | |
| Nöbet Rotasyonu ve Alarm Politikası | ⚪ | 🟡 | ✅ |
| SLO ve Hata Bütçesi (Error Budget) | ⚪ | 🟡 | ✅ |
| Yedekleme ve Felaket Kurtarma (RPO/RTO) | 🟡 | ✅ | ✅ |
| Veri Saklama ve İmha Politikası | ⚪ | 🟡 | ✅ |

## 4. Profillerin Süreç Yükü Farkları

Aynı doküman farklı profillerde farklı ağırlıkta işletilir:

| Mekanizma | Lite | Standard | Regulated |
| --- | --- | --- | --- |
| **Kod inceleme (Review)** | 1 onay, SLA yok | 1 onay, 24 saat SLA, `CODEOWNERS` | 2 onay (biri Otorite), 24 saat SLA |
| **Seviye 3 karar** | Sözlü mutabakat + PR açıklaması | ADR zorunlu | ADR + güvenlik gözden geçirmesi zorunlu |
| **RFC süreci** | Doğrudan PR | 48 saat asenkron inceleme | 48 saat + uyum (compliance) onayı |
| **Post-Mortem** | Sev-1 için kısa not | Sev-1/Sev-2 için tam rapor (48 saat) | Tam rapor + regülatör bildirimi değerlendirmesi |
| **CI bariyerleri** | Secret taraması + build | + linter, test, SCA | + SAST, imaj taraması, politika motoru |
| **Test zorunluluğu** | Kritik iş mantığı | + entegrasyon, IDOR denetimi | + E2E, veri maskeleme doğrulaması |

## 5. Kısaltılmış (Lite) Kalite Kapıları

Lite profilde DoR ve DoD tam listeleri yerine aşağıdaki asgari çekirdek uygulanır. Bu çekirdek pazarlık konusu değildir; profil ne olursa olsun geçerlidir.

**DoR — Lite çekirdeği**
- [ ] Çözülen kullanıcı problemi ve başarı ölçütü bir cümleyle yazılmıştır.
- [ ] Kabul kriterleri (en az ideal akış + bir hata durumu) tanımlanmıştır.
- [ ] Görev azami 3 iş günü kapsamına indirilmiştir.

**DoD — Lite çekirdeği**
- [ ] Kabul kriterleri karşılanmıştır.
- [ ] Kimlik bilgileri (secret) koda gömülmemiştir; secret taraması geçilmiştir.
- [ ] Kritik iş mantığı için test yazılmıştır.
- [ ] Geri alma (rollback) yolu bilinmektedir; şema değişikliği varsa geriye dönük uyumludur.
- [ ] Yapay zeka ile üretilmiş karmaşık mantık varsa ana komut (prompt) PR açıklamasına eklenmiştir.

---

*Son Güncelleme: 2026-08-31 — Versiyon 1.0 — Doküman Sahibi: Engineering Manager*
