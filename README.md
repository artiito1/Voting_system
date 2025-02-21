# VoteDao - Blockchain Oylama Sistemi

## 📌 Genel Bakış
VoteDao, Solidity ile yazılmış, merkeziyetsiz ve güvenli bir şekilde oylama anketleri oluşturmayı ve yönetmeyi sağlayan bir akıllı sözleşmedir. Kullanıcılar, mevcut anketlere belirtilen seçeneklerle oy verebilir ve tüm oylar şeffaf bir şekilde blockchain üzerinde saklanır.

## 🚀 Özellikler
- **Anket Oluşturma:** Yalnızca admin (yönetici) tarafından yeni anketler oluşturulabilir ve süresi belirlenebilir.
- **Güvenli Oylama:** Kullanıcılar her ankete yalnızca bir kez oy verebilir.
- **Oylama Seçenekleri:** Kabul (Yes), Ret (No), İlgilenmiyorum (NoInterested).
- **Anket Detaylarını Görüntüleme:** Kullanıcılar aktif ve tamamlanmış anketleri görüntüleyebilir.
- **Şeffaflık:** Tüm oylar kaydedilir ve görüntülenebilir.
- **Esnek Yönetim:** Bir anketin hala aktif olup olmadığını kontrol etme imkanı.

## 🛠️ Kullanılan Teknolojiler
- **Solidity** - Akıllı sözleşme geliştirme.
- **OpenZeppelin** - `Counters` kütüphanesi ile anket kimliklerini yönetmek için.
- **Web3.js** - Akıllı sözleşmeyle etkileşim sağlamak için.
- **Ethereum Blockchain** - Verilerin güvenli bir şekilde saklanması ve şeffaflığı sağlamak için.

## 📜 Akıllı Sözleşme Yapısı
- **Admin:** Yalnızca anket oluşturabilen yönetici.
- **Poll Struct:** Anketin başlığı, açıklaması, süresi ve oy bilgilerini içerir.
- **Vote Struct:** Kullanıcının adresi, seçtiği seçenek ve oy zamanı gibi bilgileri içerir.
- **Fonksiyonlar:**
  - `createPoll(...)` Yeni bir anket oluşturur.
  - `vote(...)` Kullanıcının oy vermesini sağlar.
  - `getPollDetailes(...)` Anketin detaylarını döndürür.
  - `getVotes(...)` Belirli bir anket için tüm oyları alır.
  - `getAllPollings()` Aktif ve tamamlanmış anketleri getirir.
  - `pollExpirationStatus(...)` Anketin süresinin dolup dolmadığını kontrol eder.
  - `getUserPollsAllreadyVoted()` Kullanıcının oy verdiği tüm anketleri getirir.

## 📥 Kurulum ve Kullanım
1. **Depoyu klonlayın:**
   ```bash
   git clone https://github.com/your-repo/vote-dao.git
   cd vote-dao
   ```
2. **Bağımlılıkları yükleyin:**
   ```bash
   npm install
   ```
3. **Akıllı sözleşmeyi dağıtın:**
   `Hardhat` veya `Truffle` kullanarak Ethereum test ağına akıllı sözleşmeyi yükleyin.
4. **Frontend çalıştırın:**
   `Web3.js` kullanarak akıllı sözleşme ile etkileşim kuran bir web arayüzü oluşturulacaktır.

## 📌 Gelecek Güncellemeler
- MetaMask ve diğer Web3 cüzdanları ile entegrasyon.
- React.js ile daha gelişmiş bir kullanıcı arayüzü.
- Özel oylama türleri için destek.
- Yöneticiler için yönetim paneli.

## 📄 Lisans
Bu proje [MIT License](LICENSE) lisansı altında lisanslanmıştır.

## ✨ Katkıda Bulunma
Projeye katkıda bulunmak isterseniz, PR göndererek veya issues açarak bize ulaşabilirsiniz!

