class DepartmentListsHelper {
  static final List<String> fakulteler = [
    "Fakülteni Seç",
    "Önlisans Bölümleri",
    "Tıp Fakültesi",
    "İktisadi ve İdari Bilimler Fakültesi",
    "Mühendislik Fakültesi",
    "Veterinerlik Fakültesi",
    "Ziraat Fakültesi",
    "Eğitim Fakültesi",
    "İlahiyat Fakültesi",
    "Fen-Edebiyat Fakültesi",
    "Hukuk Fakültesi",
    "Güzel Sanatlar Fakültesi",
    "İnegöl İşletme Fakültesi",
    "Mimarlık Fakültesi",
    "Sağlık Bilmleri Fakültesi",
    "Diş Hekimliği Fakültesi",
  ];

  static List<String> getDepartmentData(selectedFaculty) {
    List<String> bolumler = [];
    if (selectedFaculty == "Tıp Fakültesi") {
      bolumler = ["Tıp"];
    } else if (selectedFaculty == "İktisadi ve İdari Bilimler Fakültesi") {
      bolumler = [
        "Çalışma Ekonomisi ve Endüstri İlişkileri",
        "Ekonometri",
        "İktisat",
        "İşletme",
        "Maliye",
        "Siyaset Bilimi ve Kamu Yönetimi",
        "Uluslararası İlişkiler",
      ];
    } else if (selectedFaculty == "Mühendislik Fakültesi") {
      bolumler = [
        "Bilgisayar Mühendisliği",
        "Çevre Mühendisliği",
        "Elektrik-Elektronik Mühendisliği",
        "Endüstri Mühendisliği",
        "İnşaat Mühendisliği",
        "Makine Mühendisliği",
        "Otomotiv Mühendisliği",
        "Tekstil Mühendisliği",
      ];
    } else if (selectedFaculty == "Veterinerlik Fakültesi") {
      bolumler = [
        "Veterinerlik",
      ];
    } else if (selectedFaculty == "Ziraat Fakültesi") {
      bolumler = [
        "Bahçe Bitkileri",
        "Bitki Koruma",
        "Biyosistem Mühendisliği",
        "Gıda Mühendisliği",
        "Peyzaj Mimarlığı",
        "Tarım Ekonomisi",
        "Tarla Bitkileri",
        "Toprak Bilimi ve Bitki Besleme",
        "Zootekni",
      ];
    } else if (selectedFaculty == "Eğitim Fakültesi") {
      bolumler = [
        "Almanca Öğretmenliği",
        "Bilgisayar ve Öğretim Teknolojileri Öğretmenliği",
        "Fen Bilgisi Öğretmenliği",
        "Fransızca Öğretmenliği",
        "İlköğretim Matematik Öğretmenliği",
        "İngilizce Öğretmenliği",
        "Okul Öncesi Öğretmenliği",
        "Özel Eğitim Öğretmenliği",
        "Rehberlik ve Psikolojik Danışmanlık",
        "Sınıf Öğretmenliği",
        "Sosyal Bilgiler Öğretmenliği",
        "Türkçe Öğretmenliği",
      ];
    } else if (selectedFaculty == "İlahiyat Fakültesi") {
      bolumler = [
        "İlahiyat",
        "Çevre Mühendisliği",
        "Elektrik-Elektronik Mühendisliği",
        "Endüstri Mühendisliği",
        "İnşaat Mühendisliği",
        "Makine Mühendisliği",
        "Otomotiv Mühendisliği",
        "Tekstil Mühendisliği",
      ];
    } else if (selectedFaculty == "Fen-Edebiyat Fakültesi") {
      bolumler = [
        "Arkeoloji",
        "Biyoloji",
        "Coğrafya",
        "Felsefe",
        "Fizik",
        "Kimya",
        "Matematik",
        "Moleküler Biyoloji ve Genetik",
        "Psikoloji",
        "Sanat Tarihi",
        "Sosyoloji",
        "Tarih",
        "Türk Dili ve Edebiyatı",
      ];
    } else if (selectedFaculty == "Hukuk Fakültesi") {
      bolumler = [
        "Hukuk",
      ];
    } else if (selectedFaculty == "Güzel Sanatlar Fakültesi") {
      bolumler = [
        "Endüstri Ürünleri Tasarımı",
        "Geleneksel Türk Sanatları",
        "Grafik Tasarımı",
        "Resim",
        "Sahne Sanatları",
        "Seramik ve Cam Tasarımı",
        "Tekstil ve Moda Tasarımı",
      ];
    } else if (selectedFaculty == "İnegöl İşletme Fakültesi") {
      bolumler = [
        "İşletme",
        "Uluslararası Ticaret ve İşletmecilik",
        "Yönetim Bilişim Sistemleri",
      ];
    } else if (selectedFaculty == "Mimarlık Fakültesi") {
      bolumler = [
        "Mimarlık",
      ];
    } else if (selectedFaculty == "Sağlık Bilimleri Fakültesi") {
      bolumler = [
        "Fizyoterapi ve Rehabilitasyon",
      ];
    } else if (selectedFaculty == "Diş Hekimliği Fakültesi") {
      bolumler = [
        "Diş Hekimliği",
      ];
    } else if (selectedFaculty == "Önlisans Bölümleri") {
      bolumler = [
        "Anestezi",
        "Aşçılık",
        "Atçılık ve Antrenörlüğü",
        "Avcılık ve Yaban Hayatı",
        "Bahçe Tarımı",
        "Bankacılık ve Sigortacılık",
        "Bilgisayar Programcılığı",
        "Bitki Koruma",
        "Büro Yönetimi ve Yönetici Asistanlığı",
        "Çağrı Merkezi Hizmetleri",
        "Çini Sanatı ve Tasarımı",
        "Çocuk Gelişimi",
        "Deniz ve Liman İşletmeciliği",
        "Dış Ticaret",
        "Doğalgaz ve Tesisatı Teknolojisi",
        "Elektrik",
        "Elektronik Teknolojisi",
        "Emlak Yönetimi",
        "Endüstriyel Kalıpçılık",
        "Et ve Ürünleri Teknolojisi",
        "Gıda Teknolojisi",
        "Grafik Tasarımı",
        "Harita ve Kadastro",
        "Hibrid ve Elektrikli Taşıtlar Teknolojisi",
        "İklimlendirme ve Soğutma Teknolojisi",
        "İlk ve Acil Yardım",
        "İnşaat Teknolojisi",
        "İş Sağlığı ve Güvenliği",
        "İşletme Yönetimi",
        "Laborant ve Veteriner Sağlık",
        "Lojistik",
        "Makine",
        "Mekatronik",
        "Mimari Restorasyon",
        "Mobilya ve Dekorasyon",
        "Moda Tasarımı",
        "Muhasebe ve Vergi Uygulamaları",
        "Organik Tarım",
        "Ormancılık ve Orman Ürünleri",
        "Otomotiv Teknolojisi",
        "Özel Güvenlik ve Koruma",
        "Pazarlama",
        "Peyzaj ve Süs Bitkileri Yetiştiriciliği",
        "Seramik ve Cam Tasarımı",
        "Sivil Hava Ulaştırma İşletmeciliği",
        "Süt ve Besi Hayvancılığı",
        "Süt ve Ürünleri Teknolojisi",
        "Tarım Makineleri",
        "Tekstil Teknolojisi",
        "Tıbbi Dokümantasyon ve Sekreterlik",
        "Tıbbi Görüntüleme Teknikleri",
        "Tıbbi Laboratuvar Teknikleri",
        "Tohumculuk Teknolojisi",
        "Turist Rehberliği",
        "Turizm ve Otel İşletmeciliği",
        "Turizm ve Seyahat Hizmetleri",
        "Yerel Yönetimler",
      ];
    } else {
      bolumler = [
        "Bölümünü Seç",
      ];
    }
    return bolumler;
  }
}