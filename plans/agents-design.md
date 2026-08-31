# AEGS — Otonom Mühendislik Yönetişim Sistemi (Yüksek Seviye Tasarım / HLD)

> **Bu dokümanın amacı nedir?**
> Mühendislik Playbook'unu statik bir wiki olmaktan çıkarıp, yazılım geliştirme yaşam döngüsünün (SDLC) her adımında aktif olarak çalışan bir çoklu-ajan denetim sistemine dönüştürme vizyonunu tanımlamaktır. Hedef kitle CTO, Engineering Manager ve kıdemli mühendislerdir. Bu doküman "ne" ve "neden" sorularını yanıtlar; teknoloji seçimleri (orkestrasyon kütüphanesi, vektör veritabanı, çalışma ortamı) bilinçli olarak kapsam dışı bırakılmış ve Düşük Seviye Tasarım (LLD) aşamasına bırakılmıştır.

> 🚧 **DOKÜMAN DURUMU: TASARIM — YÜRÜRLÜKTE DEĞİLDİR.** Bu doküman bir vizyon tanımıdır, bağlayıcı bir yönerge değildir. Uygulamaya alınması Seviye 3 karardır ve [ADR](../docs/adr/README.md) kaydı gerektirir.

---

## 1. Sistemin Çözeceği Darboğazlar

1. **Bilişsel Yük (Cognitive Load):** Geliştiricilerin çok sayıda dokümandaki kuralı akılda tutmaya çalışırken asıl iş mantığından uzaklaşması.
2. **Kural Erozyonu:** Süreç dokümanlarının (DoR, DoD) zamanla okunmayıp Kırık Cam Teorisi gereğince terk edilmesi.
3. **İnsan Eforu İsrafı (Toil):** Otorite konumundaki mühendislerin PR incelemelerinde "kabul kriteri eksik", "tema değişkeni kullanılmamış" gibi **algoritmik olarak saptanabilir** hataları aramakla vakit kaybetmesi.

## 2. Ön Koşul: Deterministik Katmanın Önceliği

> 🚨 **Sıralama Kuralı:** Bu sistem, deterministik CI bariyerlerinin **yerine** değil, **üzerine** kurulur.

Yukarıdaki üçüncü darboğazın büyük bölümü, dil modeli gerektirmeyen deterministik denetimlerle çözülür: secret taraması, linter, test, build ve şema denetimi. Bu bariyerler kurulmadan bir ajan sistemine geçilmesi, çözülebilir bir problemi gereksiz karmaşıklıkla ve maliyetle çözmek anlamına gelir — [Ürün Felsefesi](../docs/core/product-philosophy.md) §4'te tanımlı erken optimizasyon tuzağı.

| Katman | Yöntem | Kapsadığı Denetim |
| --- | --- | --- |
| **1. Deterministik CI** *(ön koşul)* | Betik / linter / test | Secret sızıntısı, biçim ihlalleri, test başarısızlığı, yıkıcı migration, kırık bağlantı |
| **2. Yapay zeka ajanı** *(bu doküman)* | LLM + RAG | Yargı gerektiren denetimler: kabul kriterinin anlamlı doldurulup doldurulmadığı, talebin XY problemi olup olmadığı, kriz zaman çizelgesinin çıkarılması |

Ajanlara yalnızca ikinci sütun bırakılır. Bu ayrım, sistemin maliyetini ve hata yüzeyini belirleyen temel tasarım kararıdır.

## 3. Değer Önerisi (Rol Bazlı)

* **Geliştirici:** Hızlı ve yargısız geri bildirim. Bir kural ihlali, insan tarafından eleştirilmeden önce sistem tarafından saniyeler içinde, ilgili Playbook maddesine atıfla bildirilir.
* **Otorite / Tech Lead:** "Polislik" görevinin devredilmesi. Otoritenin önüne yalnızca süreç denetimlerinden geçmiş PR'lar düşer; inceleme eforu mimari ve iş mantığına yönelir.
* **Ürün Yöneticisi:** Gürültü filtresi. Çözüm öneren ham talepler, [Triage](../docs/core/triage.md) kurallarındaki XY problemi filtresinden geçirilerek rafine edilir.

## 4. Ajan Yetenekleri

Sistem üç otonom düğümden oluşur. Her ajan yalnızca kendi yetki alanındaki Playbook verisine (RAG) erişir.

### 4.1 Kapı Bekçisi (PR Gatekeeper)

Kodu değil, **süreci ve kısıtlamaları** denetler.

* PR açıklamasındaki DoD listesinin doldurulup doldurulmadığını ve maddelerin **anlamlı** yanıtlandığını denetler (deterministik katmanın yapamadığı kısım).
* Yapay zeka ile üretilen kodlar için "Prompt Şeffaflığı" kuralını kontrol eder (Bkz: [AI Manifestosu](../docs/core/ai-manifesto.md) §4).
* İlgili [Stack dokümanındaki](../docs/stacks/README.md) tasarım sistemi ihlallerini saptar; bulduğunda ilgili kuralı alıntılayarak düzeltme talep eder.
* Deterministik katmanın ürettiği bulguları tekrar etmez; yalnızca özetler ve ilgili Playbook maddesine bağlar.

### 4.2 Talep Filtresi (Triage & Refinement Bot)

Müşteri, destek veya satış ekiplerinden gelen talepleri ekibin önüne düşmeden karşılar.

* Çözüm öneren taleplere "5 Neden" ve kök neden sorularını yönelterek problem tanımını çıkarır.
* Yeterli veri toplandığında taslak bir ICE skoru hesaplar.
* Geçerli talepleri [DoR](../docs/core/dor.md) formatında bir karta dönüştürüp Ürün Yöneticisinin onayına sunar.

### 4.3 Kriz Komutanı Asistanı (Incident Bot)

Sev-1 durumlarında koordinasyon angaryasını üstlenir.

* Alarm anında Kriz Masası (War Room) kanalını açar ve `CODEOWNERS` üzerinden ilgili Otoriteleri kanala çağırır.
* Kesinti anındaki son logları özetleyip kanala sabitler.
* Kriz sonunda kanal geçmişinden zaman çizelgesini (timeline) çıkarır ve [Suçlamasız Post-Mortem](../docs/core/incident-response.md) taslağını büyük ölçüde doldurur.

## 5. Anti-Patenler (Sistemin ASLA Yapmayacağı Şeyler)

Bu bölüm, sistemin en kritik tasarım kısıtını oluşturur. Yapay zekanın bir "İnsan İkamesi" olarak konumlandırılması, ekipte uyarı yorgunluğu (alert fatigue) üretir ve ajanların sessize alınmasıyla sonuçlanır.

* **Koda karar vermek:** Ajanlar kodu birleştiremez (merge), mimari tercih yapamaz. Karar her zaman insandadır (human-in-the-loop).
* **Performans değerlendirmesi:** Ajanlar bireysel profilleme metriği tutamaz. Bu kısıt [Mühendislik Metrikleri](../docs/process/engineering-metrics.md) §3'teki anti-metrik yasağının doğrudan uzantısıdır.
* **Gereksiz gevezelik:** Ajanlar yalnızca kural ihlali durumunda konuşur. İhlal yoksa sessizce onay verip geri çekilir.
* **Deterministik denetimi taklit etmek:** Betikle saptanabilen bir ihlal için dil modeli çağrılmaz.

## 6. Sırada Ne Var? (Düşük Seviye Tasarım Kapsamı)

Bu vizyonun teknik mimariye (LLD) dönüştürülmesi aşamasında yanıtlanacak sorular:

1. Ajanlar hangi çalışma ortamında koşacak (CI iş akışı içinde mi, bağımsız bir servis olarak mı)?
2. Playbook bilgi tabanı hangi erişim yöntemiyle sunulacak (vektör arama mı, doğrudan doküman bağlamı mı)?
3. Ajanlar arası orkestrasyon nasıl kurgulanacak ve maliyet/gecikme bütçesi ne olacak?
4. Ajan çıktılarının doğruluğu nasıl ölçülecek (yanlış pozitif oranı, ekip tarafından sessize alma sıklığı)?

> ⚠️ **Devreye alma ön koşulu:** [README](../README.md) olgunluk tablosundaki "CI Bariyerleri (Ürün Depoları)" satırı ✅ durumuna gelmeden bu sistemin LLD aşamasına geçilmemesi önerilir.

---
*Son Güncelleme: 2026-08-31 — Versiyon 2.0 — Doküman Sahibi: Engineering Manager / Tech Lead*
