import 'package:cloud_firestore/cloud_firestore.dart';

class WhatsappTalebi {
  String? adiSoyadi;
  String? ogrenciNo;
  String? telefonNumarasi;
  String? fakulte;
  String? bolum;
  String? sinif;
  String? yazilimBilgisiPuani;
  String? yazilimSuresi;
  List? ilgilendigiAlanlar;
  String? githubKullaniciAdi;
  Timestamp? olusturulmaZamani;

  WhatsappTalebi({
    this.adiSoyadi,
    this.ogrenciNo,
    this.telefonNumarasi,
    this.fakulte,
    this.bolum,
    this.sinif,
    this.yazilimBilgisiPuani,
    this.yazilimSuresi,
    this.ilgilendigiAlanlar,
    this.olusturulmaZamani,
    this.githubKullaniciAdi,
  });

  factory WhatsappTalebi.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return WhatsappTalebi(
      adiSoyadi: (docData as Map)['adiSoyadi'],
      ogrenciNo: docData['ogrenciNo'],
      telefonNumarasi: docData['telefonNumarasi'],
      fakulte: docData['fakulte'],
      bolum: docData['bolum'],
      sinif: docData['sinif'],
      yazilimBilgisiPuani: docData['yazilimBilgisiPuani'],
      yazilimSuresi: docData['yazilimSuresi'],
      ilgilendigiAlanlar: docData['ilgilendigiAlanlar'],
      olusturulmaZamani: docData['olusturulmaZamani'],
      githubKullaniciAdi: docData['githubKullaniciAdi'],
    );
  }
}
