# Cynefin Çerçevesi (Metodoloji Seçim Modeli)

> **Bu dokümanın amacı nedir?**
> Bir görevin veya projenin hangi yönetim metodolojisiyle (Waterfall, Kanban, Scrum, kriz müdahalesi) yürütülmesi gerektiğini, iş gereksinimlerinin netliği ve teknolojinin öngörülebilirliği ölçütlerine göre belirlemektir. Tech Lead ve Ürün Yöneticisi için [Triage](./triage.md) kararlarının ardından başvurulan referans modeldir.

---

Cynefin Çerçevesi, yazılım mühendisliği ve proje yönetimi süreçlerinde, karşılaşılan operasyonel gereksinimlerin ve projelerin hangi yönetim metodolojisi (Agile/Scrum, Waterfall, R&D vb.) ile yürütülmesi gerektiğini tayin eden kurumsal bir karar destek modelidir.

Organizasyonumuzdaki projeler, iş gereksinimlerinin netliği ve kullanılacak teknolojinin öngörülebilirliğine dayalı olarak Cynefin alanlarına aşağıdaki şekilde sınıflandırılmaktadır:

## 1. Belirgin Alan (Clear): Rutin ve Standart Operasyonlar

* **Sistemdeki Karşılığı:** Mühendislik ekibinin daha önce defalarca uyguladığı, belirsizlik oranının sıfır olduğu standart operasyonel görevlerdir.
* **Örnek Durumlar:** Standart bir veri giriş formu oluşturulması, veritabanı şemasına rutin bir alan (kolon) eklenmesi veya kurum onaylı bir kütüphanenin projeye entegrasyonu.
* **Uygulanacak Metodoloji:** Geleneksel Waterfall (Şelale) modeli veya katı kurallara bağlı kontrol listeleri (checklist) uygulanır. Bu alan, süreç otomasyonu için en uygun zemini temsil eder.

## 2. Karışık Alan (Complicated): Uzmanlık Gerektiren Mühendislik Süreçleri

* **Sistemdeki Karşılığı:** Hedeflenen çözüm bellidir ancak uygulamanın gerçekleştirilmesi derinlemesine teknik bilgi, sistem analizi ve mimari tasarım gerektirir. Sektör standartlarında "doğru" kabul edilen bir mimari mevcuttur ancak bunun tespiti uzman personelin analizine tabidir.
* **Örnek Durumlar:** Bütünsel veritabanı performans optimizasyonu, iki farklı kurumsal sistemin karmaşık API'ler aracılığıyla entegrasyonu veya monolitik bir uygulamanın mikroservis mimarisine dönüştürülmesi.
* **Uygulanacak Metodoloji:** Kapsamlı sistem analizleri, sıkı kod incelemeleri (code review) ve mimari değerlendirme kurulları (architecture review boards) işletilir. Kanban veya titizlikle planlanmış Scrum çerçeveleri bu tip projeler için en uygun yönetim biçimleridir.

## 3. Karmaşık Alan (Complex): Yenilikçi ve Keşfe Dayalı Geliştirme (AR-GE)

* **Sistemdeki Karşılığı:** Kullanıcı gereksinimlerinin tam olarak netleşmediği veya organizasyonda ilk kez uygulanacak yenilikçi teknolojilerin kullanıldığı senaryolardır. Gereksinimler, yazılım geliştirildikçe ve kullanıcı testlerinden (UAT) veri toplandıkça netleşir.
* **Örnek Durumlar:** Yeni bir girişim (startup) ürünü piyasaya sürmek, makine öğrenmesi destekli kişiselleştirilmiş analiz motorları tasarlamak veya kullanıcı deneyimi (UX) dönüşümü sağlamak.
* **Uygulanacak Metodoloji:** Çevik (Agile / Scrum) metodolojiler bu alanın doğasına en uygun yaklaşımlardır. Kısa geliştirme döngüleri (sprintler), Minimum Uygulanabilir Ürün (MVP) yaklaşımı, sürekli entegrasyon/sürekli dağıtım (CI/CD) ve kullanıcı geri bildirimlerine dayalı yönlendirme (Dene-Algıla-Yanıtla / Probe-Sense-Respond) prensipleri uygulanır. Belirsizliklerin giderilmesi amacıyla araştırma (Spike) görevleri sistemli olarak kullanılır.

## 4. Kaotik Alan (Chaotic): Kriz Yönetimi ve Sistem Kesintileri

* **Sistemdeki Karşılığı:** Üretim ortamının (Production) tamamen çöktüğü veya kritik düzeyde bir güvenlik ihlalinin tespit edildiği operasyonel felaket anlarıdır. Bu durumlarda standart analiz süreçleri işletilemez ve toplantı yapılamaz.
* **Örnek Durumlar:** Ana ödeme geçidinin canlı ortamda devre dışı kalması, veritabanı kilitlenmeleri (deadlock) veya aktif siber saldırı altında olunması.
* **Uygulanacak Metodoloji:** Kriz müdahale protokolleri devreye girer (Harekete Geç-Algıla-Yanıtla / Act-Sense-Respond). Birinci öncelik, geçici de olsa sistemin operasyonel hale getirilmesidir (Mitigation). Ardından sistem metrikleri analiz edilir ve kalıcı çözüm tasarlanmak üzere konu Karışık veya Karmaşık alana devredilir. Bu süreçler doğrudan Olay Müdahale (Incident Management) ekiplerince yönetilir.

## 5. Karışıklık (Confusion / Disorder): Sınıflandırılamayan Durumlar

* **Sistemdeki Karşılığı:** Sisteme yeni bir proje talebi iletilmiştir ancak iş gereksinimleri, kullanılacak teknoloji yığını veya potansiyel riskler hakkında hiçbir net bilgi bulunmamaktadır.
* **Uygulanacak Metodoloji:** Proje derhal detaylı bir analize tabi tutularak yönetilebilir alt parçalara ayrıştırılmalıdır. Örneğin; sistemin kullanıcı giriş modülü Belirgin alana, temel veri işleme algoritması Karışık alana, kullanıcı davranışı analizi ise Karmaşık alana tahsis edilerek izole şekilde yönetilmelidir.

---

*Son Güncelleme: 2026-08-31 — Versiyon 1.0 — Doküman Sahibi: Engineering Manager / Tech Lead*
