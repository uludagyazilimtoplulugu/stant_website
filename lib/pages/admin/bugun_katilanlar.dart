import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/models/whatsapp_talebi.dart';
import 'package:yazilim_toplulugu/services/excel_service.dart';
import 'package:yazilim_toplulugu/services/firestore_service.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class BugunKatilanlarPage extends ConsumerStatefulWidget {
  const BugunKatilanlarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BugunKatilanlarPageState();
}

class _BugunKatilanlarPageState extends ConsumerState<BugunKatilanlarPage> {
  List<WhatsappTalebi> secilenTalepler = [];
  List<String> selectedOgrenciNo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // download
          selectedOgrenciNo.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    List<List<String>> list = [
                      ['Name', 'Phone'],
                    ];
                    // list as [
                    //   ['Name', 'Phone'],
                    //   ['John', '555-1234'],
                    //   ['Jane', '555-5678'],
                    // ]
                    for (var element in secilenTalepler) {
                      list.add([
                        element.adiSoyadi.toString(),
                        element.telefonNumarasi.toString()
                      ]);
                    }
                    // print(list);
                    ExcelService().createExcel(data: list);
                  },
                  icon: const Icon(
                    Icons.download,
                  ),
                )
              : const SizedBox(),
        ],
        title: Text(
          'Bugün Katılanlar',
          style: GoogleFonts.poppins(
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirestoreService().whatsappGrubuKatilmaTalepleri,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<WhatsappTalebi> talepler = [];
            List<WhatsappTalebi> bugunkuTalepler = [];

            snapshot.data.docs.forEach((element) {
              talepler.add(WhatsappTalebi.dokumandanUret(element));
            });

            if (talepler.isEmpty) {
              return Center(
                child: Text(
                  'Talep bulunamadı',
                  style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            // sort by olusturulmaZamani
            talepler.sort(
                (a, b) => b.olusturulmaZamani!.compareTo(a.olusturulmaZamani!));

            for (var element in talepler) {
              if (element.olusturulmaZamani!.toDate().day ==
                      DateTime.now().day &&
                  element.olusturulmaZamani!.toDate().month ==
                      DateTime.now().month &&
                  element.olusturulmaZamani!.toDate().year ==
                      DateTime.now().year) {
                bugunkuTalepler.add(element);
              }
            }

            if (bugunkuTalepler.isEmpty) {
              return Center(
                child: Text(
                  'Bugün talep bulunamadı',
                  style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectedOgrenciNo.length == talepler.length
                    ? TextButton(
                        // tümünü kaldır
                        onPressed: () {
                          secilenTalepler.clear();
                          selectedOgrenciNo.clear();
                          setState(() {});
                        },
                        child: Text(
                          'Tümünü Kaldır',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : TextButton(
                        // tümünü seç
                        onPressed: () {
                          secilenTalepler.clear();
                          selectedOgrenciNo.clear();
                          for (var element in bugunkuTalepler) {
                            selectedOgrenciNo.add(element.ogrenciNo.toString());
                            secilenTalepler.add(element);
                          }
                          setState(() {});
                        },
                        child: Text(
                          'Tümünü Seç',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      shrinkWrap: true,
                      itemCount: bugunkuTalepler.length,
                      itemBuilder: (context, index) {
                        // index = 1;
                        WhatsappTalebi talep = bugunkuTalepler[index];

                        return ListTile(
                          onTap: () {
                            if (selectedOgrenciNo.contains(talep.ogrenciNo)) {
                              selectedOgrenciNo.remove(talep.ogrenciNo);
                              // removeWhere
                              secilenTalepler.removeWhere((element) =>
                                  element.ogrenciNo == talep.ogrenciNo);
                            } else {
                              selectedOgrenciNo.add(talep.ogrenciNo.toString());
                              secilenTalepler.add(talep);
                              debugPrint("${talep.ogrenciNo} eklendi");
                            }
                            selectedOgrenciNo =
                                selectedOgrenciNo.toSet().toList();
                            secilenTalepler = secilenTalepler.toSet().toList();
                            setState(() {});
                          },
                          leading: Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            fillColor: MaterialStateProperty.all<Color>(
                              selectedOgrenciNo.contains(talep.ogrenciNo)
                                  ? CustomColors.primaryColor
                                  : Theme.of(context).scaffoldBackgroundColor,
                            ),
                            value: selectedOgrenciNo.contains(talep.ogrenciNo),
                            onChanged: (value) {
                              if (selectedOgrenciNo.contains(talep.ogrenciNo)) {
                                selectedOgrenciNo.remove(talep.ogrenciNo);
                                // removeWhere
                                secilenTalepler.removeWhere((element) =>
                                    element.ogrenciNo == talep.ogrenciNo);
                              } else {
                                selectedOgrenciNo
                                    .add(talep.ogrenciNo.toString());
                                secilenTalepler.add(talep);
                                debugPrint("${talep.ogrenciNo} eklendi");
                              }
                              // remove duplicates from list
                              selectedOgrenciNo =
                                  selectedOgrenciNo.toSet().toList();
                              secilenTalepler =
                                  secilenTalepler.toSet().toList();

                              setState(() {});
                            },
                          ),
                          trailing: Text(
                            "${DateTime.fromMillisecondsSinceEpoch(bugunkuTalepler[index].olusturulmaZamani!.millisecondsSinceEpoch).day}.${DateTime.fromMillisecondsSinceEpoch(bugunkuTalepler[index].olusturulmaZamani!.millisecondsSinceEpoch).month}.${DateTime.fromMillisecondsSinceEpoch(bugunkuTalepler[index].olusturulmaZamani!.millisecondsSinceEpoch).year} - ${DateTime.fromMillisecondsSinceEpoch(bugunkuTalepler[index].olusturulmaZamani!.millisecondsSinceEpoch).hour} : ${DateTime.fromMillisecondsSinceEpoch(bugunkuTalepler[index].olusturulmaZamani!.millisecondsSinceEpoch).minute}",
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          title: Text(
                            talep.adiSoyadi.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            talep.telefonNumarasi.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Bir hata oluştu'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColors.primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
