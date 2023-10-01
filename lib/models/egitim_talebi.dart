import 'package:cloud_firestore/cloud_firestore.dart';

class EgitimTalebi {
  String? adiSoyadi;

  String? fakulte;
  String? bolum;
  String? sinif;
  List<dynamic>? istedigiEgitimler;

  Timestamp? olusturulmaZamani;
  String? eklemekIstedigiAlan;

  EgitimTalebi({
    this.adiSoyadi,
    this.fakulte,
    this.bolum,
    this.sinif,
    this.olusturulmaZamani,
    this.istedigiEgitimler,
    this.eklemekIstedigiAlan,
  });

  factory EgitimTalebi.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return EgitimTalebi(
      adiSoyadi: (docData as Map)['adiSoyadi'],
      fakulte: docData['fakulte'],
      bolum: docData['bolum'],
      sinif: docData['sinif'],
      istedigiEgitimler: docData['istedigiKonular'],
      olusturulmaZamani: docData['olusturulmaZamani'],
      eklemekIstedigiAlan: docData['eklemekIstedigiAlan'],
    );
  }
}
