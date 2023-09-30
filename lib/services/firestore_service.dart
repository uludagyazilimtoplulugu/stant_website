import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DateTime zaman = DateTime.now();

  Future<bool> whatsappKatilmaTalebiOlusturmusMu(
      {required String ogrenciNo}) async {
    try {
      final DocumentSnapshot documentSnapshot = await firestore
          .collection('whatsappGrubuKatilmaTalepleri')
          .doc(ogrenciNo)
          .get();
      return documentSnapshot.exists;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> whatsappGrubuKatilmaTalebiOlustur({
    required String adiSoyadi,
    required String ogrenciNo,
    required String telefonNumarasi,
    required String fakulte,
    required String bolum,
    required String sinif,
    required String yazilimBilgisiPuani,
    required String yazilimSuresi,
    required List<String> ilgilendigiAlanlar,
    required String githubKullaniciAdi,
  }) async {
    // create a document for the user with the ogrenciNo
    // if the user already exists, it will overwrite the user
    try {
      telefonNumarasi = "+90${telefonNumarasi.replaceAll(" ", "")}";
      await firestore
          .collection('whatsappGrubuKatilmaTalepleri')
          .doc(ogrenciNo)
          .set({
        'adiSoyadi': adiSoyadi,
        'ogrenciNo': ogrenciNo,
        'telefonNumarasi': telefonNumarasi,
        'fakulte': fakulte,
        'bolum': bolum,
        'sinif': sinif,
        'yazilimBilgisiPuani': yazilimBilgisiPuani,
        'yazilimSuresi': yazilimSuresi,
        'ilgilendigiAlanlar': ilgilendigiAlanlar,
        'olusturulmaZamani': zaman,
        'githubKullaniciAdi': githubKullaniciAdi,
      });
    } catch (e) {
      rethrow;
    }
  }
}
