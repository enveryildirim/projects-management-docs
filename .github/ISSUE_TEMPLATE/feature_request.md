---
name: ✨ Talep / Yeni Özellik
about: Müşteri talebi veya yeni özellik önerisi (Triage sürecine girer)
labels: enhancement, triage
---

> 💡 **Bu şablon [Triage Prosedürü](../../docs/core/triage.md) ile uyumludur.** Aşağıdaki üç alan eksiksiz doldurulmadığı takdirde talep, aciliyet beyanına veya müşteri segmentine bakılmaksızın değerlendirmeye alınmaz.

## 1. Kullanıcı Problemi

<!-- Kullanıcının şu anda gerçekleştiremediği işlem nedir?
     ÇÖZÜM DEĞİL, PROBLEM yazınız.
     ❌ "Şu ekrana bir buton ekleyin"
     ✅ "Toplu taburcu işlemi gerçekleştirilemiyor, her kayıt tek tek açılmak zorunda" -->

## 2. İş Etkisi (Impact)

<!-- Bu problem çözülmezse oluşacak kayıp nedir? (zaman, finansal kaynak, müşteri memnuniyeti) -->

## 3. Erişim ve Sıklık (Reach)

<!-- Bu problem kaç kullanıcı tarafından, ne sıklıkla yaşanıyor? Mümkünse veriye dayandırınız. -->

---

## Kök Neden Analizi (Talebi ileten ekip doldurur)

* **"Süreçteki en büyük tekil engeli kaldırma imkanınız olsaydı bu ne olurdu?" sorusuna müşterinin yanıtı:**
* **Halihazırda denenen geçici çözüm (workaround) var mı?**

## Triage Değerlendirmesi (Ürün Yöneticisi doldurur)

* **ICE Skoru:** Impact `__/10` · Confidence `__/10` · Ease `__/10`
* **Karar:** ❌ Reddedildi (Drop) · 🧊 Beklemeye Alındı (Icebox, 3 ay TTL) · ✅ Kabul Edildi (To Refinement)
* **Gerekçe:**
* **Özel geliştirme (custom code) kısıtı denetimi:** Çözüm, müşteriye özel koşullu mantık gerektirmeden genel ürün mimarisine uyumlu tasarlanabiliyor mu? (Hayır ise reddedilir.)
