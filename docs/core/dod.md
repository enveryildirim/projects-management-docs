# Definition of Done (DoD) - Bitti Kriterleri

> **Bu doküman ne işe yarar?**
> Bir kodun eksiksiz, güvenli ve canlıya çıkmaya hazır olduğunu (Production-Ready) garanti altına alır. Bu liste Pull Request (PR) şablonumuzun değişmez çekirdeğidir.

> 💡 **Sistemik Kural:** "Kodu yazdım, çalışıyor" demek *Done* demek değildir. Aşağıdaki liste otomasyon ve manuel Code Review ile doğrulanmadan merge işlemi yapılamaz.

## 1. 💻 Kod Kalitesi, AI ve Standartlar

- [ ] **Kabul Kriterleri:** Görev kartındaki tüm kabul kriterleri eksiksiz karşılandı.
- [ ] **Linter / Format / Ölü Kod:** ESLint/Prettier uyarıları sıfırlandı. `console.log`'lar temizlendi. AI'ın ürettiği kullanılmayan ölü fonksiyonlar ve halüsinasyon bağımlılıklar (gereksiz kütüphaneler) reddedildi.
- [ ] **AI Prompt Şeffaflığı (Prompt-as-Code):** Kompleks iş mantıkları AI ile üretildiyse, kullanılan ana prompt PR açıklamasına eklendi.

## 2. 🧪 Test, Güvenlik ve Dayanıklılık (Resilience)

- [ ] **AI-TDD ve İş Mantığı Testleri:** Sadece mevcut kodu doğrulayan tautolojik testler değil, iş kurallarını (business logic) sınayan birim/entegrasyon testleri yazıldı.
- [ ] **DLP ve Sırlar (Security):** API key'ler, DB şifreleri veya gerçek hasta verileri koda gömülmedi. Lokal `pre-commit` (TruffleHog/Git-secrets) hook'ları başarılı.
- [ ] **Graceful Degradation (Zarif Bozulma):** Dış API'ler çöktüğünde veya veritabanı yavaşladığında sistem tamamen çökmüyor; kullanıcıya anlamlı bir hata mesajı veya kısıtlı deneyim sunuyor.

## 3. 🔄 İnceleme (Code Review) ve CI/CD

- [ ] **CI/CD Pipeline Yeşil:** Otomatik testler, build ve güvenlik taramaları sunucuda (GitHub Actions vb.) sorunsuz geçti.
- [ ] **Anti-Kahraman (Ortak Mülkiyet) Onayı:** Kod, bilgi silolarını kırmak adına takımda o modülü en az bilen bir kişi dahil olmak üzere review edildi ve onaylandı.
- [ ] **Çatışma Yok:** Branch `main` ile senkronize edildi.

## 4. 📦 İzlenebilirlik ve Dağıtım

- [ ] **Telemetri ve Loglama:** Ürün felsefesindeki "Hipotezi Doğrulama" kuralı gereği, bu özelliğin kullanılıp kullanılmadığını biçecek ürün logları (analytics/telemetry event'leri) koda eklendi.
- [ ] **Dokümantasyon ve ADR:** Yeni `.env` değişkenleri eklendi, yeni kütüphane veya mimari karar alındıysa ADR dokümanı yazıldı.
- [ ] **Veritabanı Rollback:** Veritabanı şemasında (migration) değişiklik yapıldıysa, olası geri alma (rollback) senaryosu test edildi.