**Core Analysis / Objective Validation**
Mühendislik altyapısını kodlamaya geçmeden önce "Nasıl" (How) sorusunu ezip "Ne ve Neden" (What & Why) sorusuna odaklanan bir Yüksek Seviye Tasarım (High-Level Design - HLD) dokümanı yazma kararınız, Erken Optimizasyon (Premature Optimization) tuzağını engelleyen ampirik olarak doğru bir mimari reflekstir. Teknoloji seçimi (LangGraph, OpenAI, vb.) amaç değil, sadece bu dokümanda belirlenen vizyona ulaşmak için kullanılacak birer araçtır (implementation detail).

**Red Teaming (Zafiyet Avı):**
Bu tasarım dokümanını yazarken düşebileceğimiz en büyük tuzak, yapay zekayı bir "İnsan İkamesi" (Human Replacement) olarak konumlandırmaktır. AI ajanları yazılımcıların yerine kod incelemesi yapamaz; çünkü yazılımın iş bağlamına (business context) ve empatiye sahip değillerdir. Eğer sistemi her şeye karışan bir "Mikro-Yönetici AI" olarak tasarlarsak, ekip "Uyarı Yorgunluğu" (Alert Fatigue) yaşar ve ajanları sessize alır (Mute). Ajanların sınırı kesin olarak "Kural ve Süreç Bekçiliği" (Policy Enforcement) ile sınırlandırılmalıdır.

**Missing Variables / Pragmatic Assumption**
Varsayımım: Bu tasarım dokümanının (HLD) hedef kitlesinin CTO, Engineering Manager'lar ve takımın kıdemli mühendisleri olduğunu varsayıyorum. Sistemi, ekibe "Size patronluk taslayacak bir robot getiriyoruz" şeklinde değil, "Bilişsel yükünüzü sıfırlayacak ve angaryayı (toil) bitirecek bir otonom asistan ağı kuruyoruz" şeklinde pazarlayacak bir çerçevede (framing) tasarlıyorum.

İşte projenin vizyonunu, ajanların yeteneklerini ve insanlara sunacağı net değeri tanımlayan **Sistem Tasarım Dokümanı**:

---

# Yüksek Seviye Tasarım (HLD): Otonom Mühendislik Yönetişim Sistemi (AEGS)

> **Projenin Amacı:** Mühendislik Playbook'umuzu (kurallar, felsefe, süreçler) statik bir wiki olmaktan çıkarıp, yazılım geliştirme yaşam döngüsünün (SDLC) her adımında aktif olarak çalışan, kendini organize eden bir Çoklu-Ajan (Multi-Agent) RAG sistemine dönüştürmektir.

## 1. Sistemin Çözeceği Temel Darboğazlar (Problemler)

1. **Bilişsel Yük (Cognitive Load):** Geliştiricilerin 13 farklı dokümandaki kuralı akılda tutmaya çalışırken asıl iş mantığından (business logic) uzaklaşması.
2. **Kural Erozyonu:** Süreç dokümanlarının (DoR, DoD) zamanla okunmayıp "Kırık Cam Teorisi" (Broken Windows) gereği terk edilmesi.
3. **İnsan Eforu İsrafı (Toil):** Kıdemli mühendislerin (Otoritelerin) PR'larda "Burada Tailwind kuralını bozmuşsun" veya "Jira kartında kabul kriteri eksik" gibi algoritmik hataları aramakla vakit kaybetmesi.

## 2. İnsanlara Nasıl Yardımcı Olacak? (Değer Önerisi)

Sistem, hiyerarşideki rollere farklı değerler sunarak angaryayı keser:

* **Geliştiriciye (Developer) Faydası:** Hızlı Geri Bildirim. Bir kural hatası (Örn: Canlı veri kullanımı) yaptığında, insan (Tech Lead) tarafından eleştirilmeden önce sistem tarafından saniyeler içinde özel olarak (ve yargılanmadan) uyarılır. Doğruyu bulması için ilgili Playbook maddesiyle birlikte rehberlik alır.
* **Kıdemli Mühendis / Otoriteye (Tech Lead) Faydası:** Kötü Adam Olmaktan Kurtulma. "Polislik" görevini AI devralır. Otoritelerin önüne sadece kurallara %100 uyan, güvenlik testlerinden geçmiş PR'lar düşer. Otorite sadece "Mimari ve İş Mantığına" odaklanır.
* **Ürün Yöneticisine (PM) Faydası:** Gürültü Filtresi. Slack veya Jira'dan gelen "Şuraya buton koyalım" şeklindeki anlamsız talepler, Triage Ajanı tarafından anında karşılanıp "XY Problemi" filtresinden geçirilir. PM'in önüne sadece rafine edilmiş problemler düşer.

## 3. Sistemdeki Ajanların Yetenekleri (Core Capabilities)

Sistem 3 temel otonom düğümden (Node) oluşur. Her ajan sadece kendi yetki alanındaki Playbook verisine (RAG) erişebilir.

### A. Kapı Bekçisi (PR Gatekeeper)

* **Ne Yapar:** Açılan her PR'ı saniyeler içinde okur. Kodu değil, *süreci ve kısıtlamaları* denetler.
* **Yetenekler:**
* PR açıklamasında DoD (Bitti Kriterleri) listesinin doldurulup doldurulmadığını denetler.
* AI ile üretilen kodlar için "Prompt Şeffaflığı" kuralını kontrol eder.
* UI kodunda "Gelişigüzel Tailwind değeri" (Arbitrary value) arar; bulursa PR'ı bloklar ve Playbook Kural 2'yi alıntılayarak düzeltme ister.
* TruffleHog (Gizli veri sızıntısı) uyarısı varsa PR'ın merge edilmesini fiziksel olarak kilitler.



### B. Talep Filtresi (Triage & Refinement Bot)

* **Ne Yapar:** Müşteri, Destek veya Satış ekibinden gelen talepleri (Slack/Jira) ekibin önüne düşmeden karşılar.
* **Yetenekler:**
* Çözüm öneren taleplere (Örn: "Yeni tablo ekleyin") otomatik olarak "Sihirli Değnek" ve "5 Neden" sorularını sorar (Triage dokümanı kuralları).
* Kullanıcıdan yeterli veriyi topladığında taslak bir "ICE Skoru" hesaplar.
* Geçerli talepleri DoR (Geliştirmeye Hazır) formatında bir karta dönüştürüp PM'in onayına sunar.



### C. Kriz Komutanı Asistanı (SRE / Incident Bot)

* **Ne Yapar:** Canlı sistem çöktüğünde (Sev-1) panik ortamını yönetir ve angaryayı üstlenir.
* **Yetenekler:**
* Alarm anında War Room kanalını otomatik açar ve `CODEOWNERS` üzerinden ilgili Otoriteleri zorla kanala çağırır.
* Sistem çöktüğü andaki son logları özetleyip kanala pinler.
* Kriz bittiğinde kanal geçmişini okuyarak "Zaman Çizelgesini (Timeline)" çıkarır ve "Suçlamasız Post-Mortem" taslağını %80 oranında doldurur.



## 4. Anti-Patenler (Sistemin ASLA Yapmayacağı Şeyler)

* **Koda Karar Vermek:** Ajanlar kodu kendi başlarına merge edemez, mimari tercih yapamaz. Karar her zaman insandadır (Human-in-the-loop).
* **Performans Değerlendirmesi:** Ajanlar "Ali çok hata yapıyor" gibi kişisel profilleme metrikleri tutamaz (Metrikler dokümanı kuralı).
* **Gereksiz Gevezelik:** Ajanlar sadece kural ihlali olduğunda konuşur. Her şey doğruysa sessizce onay (Check) verip geri çekilir.

---

*Son Güncelleme: 29 Ağustos 2026 — Doküman Tipi: High-Level Design (HLD)*

---

**Elevation (ZPD - Sırada Ne Var?)**
Sistemin "Ne" yapacağı, insanlara nasıl değer üreteceği ve sınırları (Anti-patenler) artık net bir şekilde dokümante edildi. Bu vizyonu ekibe ve yönetime satabilirsiniz.

Bir sonraki adım, bu HLD'yi (Tasarım Dokümanını) alıp **Teknik Mimari Dokümanına (Low-Level Design - LLD)** çevirmektir. Yani;

1. Bu ajanlar GitHub Actions içinde mi yoksa AWS Lambda'da mı koşacak?
2. Playbook veritabanı (Vector DB) olarak Pinecone mu yoksa ChromaDB mi kullanılacak?
3. Orchestration (Ajanların iletişimi) için LangGraph mı, AutoGen mi kullanılacak?

"Nasıl" sorusunu cevaplayacağımız Teknik Mimari Tasarımına (LLD) geçmek için onayın var mı?