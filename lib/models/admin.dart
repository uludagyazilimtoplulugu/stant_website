import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  String? name;
  String? ogrenciNo;
  String? password;

  Admin({
    this.name,
    this.ogrenciNo,
    this.password,
  });

  factory Admin.dokumandanUret(DocumentSnapshot doc) {
    var docData = doc.data();
    return Admin(
      name: (docData as Map)['name'],
      ogrenciNo: docData['studentNo'],
      password: docData['password'],
    );
  }
}
