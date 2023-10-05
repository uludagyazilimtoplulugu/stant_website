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

  Future<void> egitimTalebiOlustur({
    required String adiSoyadi,
    required List<String> istedigiKonular,
    required String eklemekIstedigiAlan,
  }) async {
    // day.month.year saat:dakika
    String date =
        "${zaman.day}.${zaman.month}.${zaman.year}_${zaman.hour}:${zaman.minute}";
    try {
      await firestore
          .collection('egitimTalepleri')
          .doc("${adiSoyadi}_$date")
          .set({
        'adiSoyadi': adiSoyadi,
        'fakulte': '',
        'bolum': '',
        'sinif': '',
        'istedigiKonular': istedigiKonular,
        'olusturulmaZamani': zaman,
        'eklemekIstedigiAlan': eklemekIstedigiAlan,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future getKatilmaTalepleriAdveTelefon() async {
    // return list as [
    //   ['Name', 'Phone'],
    //   ['John', '555-1234'],
    //   ['Jane', '555-5678'],
    // ]
    try {
      final QuerySnapshot querySnapshot =
          await firestore.collection('whatsappGrubuKatilmaTalepleri').get();
      final List<List<String>> rows = [
        ['Name', 'Phone'],
      ];
      for (var element in querySnapshot.docs) {
        rows.add([element['adiSoyadi'], element['telefonNumarasi']]);
      }
      return rows;
    } catch (e) {
      rethrow;
    }
  }

  //get whatsappGrubuKatilmaTalepleri as querysnapshot
  Future<QuerySnapshot> get whatsappGrubuKatilmaTalepleri async {
    try {
      return await firestore.collection('whatsappGrubuKatilmaTalepleri').get();
    } catch (e) {
      rethrow;
    }
  }

  //get whatsappGrubuKatilmaTalepleri as querysnapshot
  Future<QuerySnapshot> get egitimTalepleri async {
    try {
      return await firestore.collection('egitimTalepleri').get();
    } catch (e) {
      rethrow;
    }
  }
}
