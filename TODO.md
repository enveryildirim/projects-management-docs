# 📋 Proje Yönetimi & Süreç İyileştirme - TODO Listesi

Aşağıdaki liste, sistemin mevcut eksikliklerini ve gelecekteki gelişim alanlarını kategorize etmektedir. İşaretlenebilir yapı sayesinde ilerlemeyi buradan takip edebilirsiniz.

## 1. Dokümantasyon, Kültür ve Sahiplik
- [ ] **Çapraz Referanslar:** Her bir dokümandaki kuralları, diğer dokümanlara (ADR, Triage, DoD) atıflar/linkler vererek güçlendirmek.
- [ ] **Sahiplik (Ownership):** Bu dokümanların güncelliğini kimin sağlayacağını belirlemek (Örn: `CODEOWNERS` dosyasının aktif kullanımı).
- [ ] **Uyum (Compliance):** Ekibin belirlenen bu kurallara uyup uymadığını ampirik olarak nasıl ölçeceğimizin mekanizmasını kurmak.
- [ ] **Önyargı Yönetimi (HIPPO):** En yüksek maaşlı kişinin fikrinin (Highest Paid Person's Opinion) teknik kararları ezmesini engelleyecek kültür prensiplerini netleştirmek.

## 2. Eksik Süreçler ve Yeni Doküman İhtiyaçları
- [x] **Güvenlik ve Uyum (DevSecOps):** Veri gizliliği, sızma testi pratikleri ve güvenlik standartları (Örn: [TruffleHog](https://github.com/trufflesecurity/trufflehog) ile secret sızıntılarını engelleme).
- [x] **Mimari Karar Kayıtları (ADR):** Backend, veritabanı veya sistem mimarisi kararlarının nasıl alınacağı ve belgeleneceği için standart bir ADR şablonu oluşturmak.
- [ ] **Yedekleme ve Felaket Kurtarma (Backup & Disaster Recovery):** Veritabanı ve sistem yedekleme sıklığı, RPO/RTO hedefleri, otomatik snapshot süreçleri ve periyodik geri dönme (restore) test protokollerinin dokümante edilmesi (Örn: `docs/stacks/backend-db.md` veya bağımsız bir yönerge).
- [ ] **Kesinti Anında Ürün Davranışı ve Müdahale Stratejileri (Outage Mitigation & Runbooks):** Kesinti durumunda sistemin nasıl tepki vereceğini ve mühendislik müdahale hiyerarşisini belirlemek:
  - **Sürüm Geri Alma (Rollback):** Hangi durumlarda anında geri alma uygulanır, veritabanı migration içeren sürümlerde rollback sınırları nelerdir?
  - **Özellik Kapatma (Feature Flags / Kill Switch):** Hatanın yeni bir özellikten kaynaklandığı senaryolarda yeni deployment yapmadan özelliği anında devre dışı bırakma altyapısı.
  - **Kademeli/Kısıtlı Hizmet (Graceful Degradation & Degraded Mode):** Çöken/yavaşlayan modülleri (raporlama, arama, 3. parti entegrasyonlar vb.) izole edip ana akışı (login, ödeme, kritik kayıt) ayakta tutma.
  - **Devre Kesici (Circuit Breaker) & Fallback:** Harici servisler yanıt vermediğinde tüm uygulamanın kilitlenmesini engelleyen fallback mekanizmaları.
  - **Yük Kısma / Boşaltma (Load Shedding & Rate Limiting):** Aşırı yük veya trafik patlamalarında arka plan işlerini dondurup ana trafiğe öncelik verme.
  - **Bakım Modu (Maintenance Mode) & Kullanıcı İletişimi:** Sistem tamamen durduğunda 500 hatası yerine kullanıcıya anlamlı statik durum ve bilgilendirme ekranı sunma yönergeleri.
- [ ] **Maliyet Yönetimi ve Birim Ekonomi (FinOps & Cost Management):** Mühendislik ve altyapı maliyetlerinin nasıl hesaplanacağı, dokümante edileceği ve optimize edileceği standartlarını oluşturmak:
  - **Birim Maliyet Modeli (Unit Economics):** İşlem başına, kullanıcı başına (Cost per User / Tenant) veya istek başına maliyet hesaplama yöntemleri.
  - **Bulut ve Altyapı Maliyet Takibi (Cloud FinOps):** Sunucu, veritabanı, depolama ve veri transferi (egress) harcamalarının ortam/etiket (tagging) bazlı takibi ve bütçe aşım alarmları.
  - **3. Parti API ve Yapay Zeka (AI/LLM) Maliyetleri:** Harici API çağrıları, SMS/e-posta kotaları ve token kullanım maliyetlerinin izlenmesi ve limitlendirilmesi (Rate/Quota limits).
  - **Fırsat ve Özellik ROI Analizi:** Yeni bir özelliğin getireceği operasyonel/finansal fayda ile geliştirme + sürekli bakım maliyetinin karşılaştırılması.
  - **Atıl Kaynak Temizliği (Waste Reduction):** Kullanılmayan test ortamları, sahipsiz disk/snapshot ve fazla provizyonlanmış (over-provisioned) kaynakların periyodik temizlik rutini.

## 3. Geliştirici Deneyimi (DX) ve Otomasyon
- [ ] **Bariyer Yorgunluğu (Tick-box Fatigue) Çözümü:** DoD ve DoR maddelerini PR şablonlarında manuel "checkbox" olmaktan çıkarıp, otomatikleştirilmiş CI/CD kontrollerine bağlamak.
- [ ] **Performans Ölçümü (DORA):** Kurulan bu sistemi ölçmek için `engineering-metrics.md` altyapısını tasarlamak (Lead Time, Deploy Freq, CFR, MTTR gibi DORA metrikleri).

## 4. Stratejik Karar Noktası
- [ ] Metrik altyapısını (Otomasyon ve DORA) kurmaya devam mı edeceğiz, yoksa mevcut playbook yapısını takıma sunma (roll-out) aşamasına mı geçeceğiz? Ekiple beraber karar verilmeli.

---

## 📚 Okunacak Referans Dokümanlar ve Kitaplar

### 1. Kültür, İletişim ve Bilişsel Yük (Organizasyonel Mimari)
*(Playbook'taki `iletisim-ve-toplanti.md`, `yetkinlik-ve-raci.md` ve "Anti-Kahramanlık" kurallarının dayanağı.)*
* **Kitap:** *Team Topologies: Organizing Business and Technology Teams for Fast Flow* (Matthew Skelton, Manuel Pais).
* **Neden Okunmalı?** Bilişsel yükü (cognitive load) yönetmeyi, Conway Kanunu'nu lehinize çevirmeyi ve takımlar arası iletişim sürtünmesini (interaction modes) nasıl keseceğinizi anlatır.

* **Kitap:** *Radical Candor* (Kim Scott).
* **Neden Okunmalı?** PR incelemelerinde ve 1-on-1 toplantılarda "Kişiye değil işe saldırmak" felsefesini ve yapay bir nezaket (ruinous empathy) yerine doğrudan, empatik bir geri bildirim kültürünü kurmayı öğretir.

### 2. Sürekli Teslimat ve Metrikler (DevOps & CI/CD)
*(Playbook'taki `ci-cd-deployment.md`, `engineering-metrics.md` ve "Sıfır Kesinti" kurallarının dayanağı.)*
* **Kitap:** *Accelerate: The Science of Lean Software and DevOps* (Nicole Forsgren, Jez Humble, Gene Kim).
* **Neden Okunmalı?** DORA metriklerinin şirket karlılığını nasıl artırdığını kanıtlar. Metrik fetişizmine düşmeden sistemi nasıl ölçeceğinizi gösterir.

* **Kitap:** *The Phoenix Project* (Gene Kim, Kevin Behr, George Spafford).
* **Neden Okunmalı?** Bir BT projesindeki darboğazları (Theory of Constraints) ve plansız işlerin sistemi nasıl zehirlediğini roman formatında anlatır.

### 3. Kriz Yönetimi ve Dayanıklılık (Resilience)
*(Playbook'taki `incident-response.md` ve Hata Yönetimi kurallarının dayanağı.)*
* **Kitap/Makale:** *Site Reliability Engineering (SRE) - Google* (Özellikle Bölüm 15: Postmortem Culture). *(Ücretsiz okunabilir)*
* **Neden Okunmalı?** "İnsan hatası bir kök neden değildir" felsefesini ve Hata Bütçelerini (Error Budgets) Google'ın nasıl yönettiğini gösterir.

### 4. Müşteri Bariyeri ve Talep Filtreleme (Product Triage)
*(Playbook'taki `triage.md` ve "XY Problemi" kurallarının dayanağı.)*
* **Kitap:** *The Mom Test* (Rob Fitzpatrick).
* **Neden Okunmalı?** Müşteriyle konuşurken doğru soruları nasıl soracağınızı öğretir. Triage toplantılarının can damarıdır.

* **Kitap:** *Escaping the Build Trap* (Melissa Perri).
* **Neden Okunmalı?** Şirketin bir "Özellik Fabrikasına" (Feature Factory) dönüşmesini engellemeyi ve çıktılara (output) değil, sonuçlara (outcome) odaklanmayı anlatır.

### 5. Sistem Düşüncesi ve Teknik Takas (Trade-off)
*(Playbook'taki `urun-felsefesi.md` ve `rfc-guncelleme-protokolu.md` mimarisinin dayanağı.)*
* **Kitap:** *Fundamentals of Software Architecture* (Mark Richards, Neal Ford).
* **Neden Okunmalı?** Mimari kararların bir "doğrusu" olmadığını, sadece "Trade-off" (Takas) olduğunu gösterir. (Örn: Hız vs. Güvenlik).

* **Makale/Blog:** *Martin Fowler - "YAGNI" (You Aren't Gonna Need It) ve "Technical Debt"*.
* **Neden Okunmalı?** Erken optimizasyon (over-engineering) hastalığını ve teknik borcun ne zaman stratejik bir araç, ne zaman bir zehir olduğunu tanımlar.
