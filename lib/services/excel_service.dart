import 'dart:html';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class ExcelService {
  Future<void> createExcel({required List<List<String>> data}) async {
    // //Create a Excel document.
    // //Creating a workbook.
    // final Workbook workbook = Workbook();
    // //Accessing via index.
    // final Worksheet sheet = workbook.worksheets[0];
    // // file title name
    // sheet.name = 'Yazılım Topluluğu Katılımcıları';
    // // Set the text value.
    // sheet.getRangeByName('A1').setText('Name');
    // sheet.getRangeByName('B1').setText('Given Name');
    // sheet.getRangeByName('C1').setText('Additional Name');
    // sheet.getRangeByName('D1').setText('Family Name');
    // sheet.getRangeByName('E1').setText('Yomi Name');
    // sheet.getRangeByName('F1').setText('Given Name Yomi');
    // sheet.getRangeByName('G1').setText('Additional Name Yomi');
    // sheet.getRangeByName('H1').setText('Family Name Yomi');
    // sheet.getRangeByName('I1').setText('Name Prefix');
    // sheet.getRangeByName('J1').setText('Name Suffix');
    // sheet.getRangeByName('K1').setText('Initials');
    // sheet.getRangeByName('L1').setText('Nickname');
    // sheet.getRangeByName('M1').setText('Short Name');
    // sheet.getRangeByName('N1').setText('Maiden Name');
    // sheet.getRangeByName('O1').setText('Birthday');
    // sheet.getRangeByName('P1').setText('Gender');
    // sheet.getRangeByName('Q1').setText('Location');
    // sheet.getRangeByName('R1').setText('Billing Information');
    // sheet.getRangeByName('S1').setText('Directory Server');
    // sheet.getRangeByName('T1').setText('Mileage');
    // sheet.getRangeByName('U1').setText('Occupation');
    // sheet.getRangeByName('V1').setText('Hobby');
    // sheet.getRangeByName('W1').setText('Sensitivity');
    // sheet.getRangeByName('X1').setText('Priority');
    // sheet.getRangeByName('Y1').setText('Subject');
    // sheet.getRangeByName('Z1').setText('Notes');
    // sheet.getRangeByName('AA1').setText('Language');
    // sheet.getRangeByName('AB1').setText('Photo');
    // sheet.getRangeByName('AC1').setText('Group Membership');
    // sheet.getRangeByName('AD1').setText('Phone 1 - Type');
    // sheet.getRangeByName('AE1').setText('Phone 1 - Value');

    // // Set the text value.
    // sheet.getRangeByName('A2').setText('Melih');
    // sheet.getRangeByName('AC2').setText('* myContacts');
    // sheet.getRangeByName('AD2').setText('Mobile');
    // sheet.getRangeByName('AE2').setText('+90 554 604 72 73');

    // //Save and launch the excel.
    // final List<int> bytes = workbook.saveAsStream();
    // //Dispose the document.
    // workbook.dispose();

    // //Download the output file
    // AnchorElement(
    //     href:
    //         "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    //   ..setAttribute("download", "contacts.csv")
    //   ..click();

    try {
      // CSV dosyasını oluştur
      final csv = const ListToCsvConverter().convert(data);

      // CSV dosyasını indirme bağlantısını oluştur
      final blob = Blob([csv]);
      final url = Url.createObjectUrlFromBlob(blob);

      // Indirme bağlantısını oluşturulduktan sonra kullanıcıya sun
      AnchorElement(href: url)
        ..setAttribute('download', 'contacts.csv') // Dosya adını ayarla
        ..click();

      // Kullanılmayan kaynakları temizle
      Url.revokeObjectUrl(url);
    } catch (e) {
      debugPrint("hata");
      debugPrint(e.toString());
      rethrow;
    }
  }
}
