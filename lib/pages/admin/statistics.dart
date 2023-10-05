import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/models/egitim_talebi.dart';
import 'package:yazilim_toplulugu/models/whatsapp_talebi.dart';
import 'package:yazilim_toplulugu/services/firestore_service.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class IstatistiklerPage extends ConsumerStatefulWidget {
  const IstatistiklerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IstatistiklerPageState();
}

class _IstatistiklerPageState extends ConsumerState<IstatistiklerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            'İstatistikler',
            style: GoogleFonts.poppins(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black.withOpacity(0.7),
            ),
          )),
      body: FutureBuilder(
        future: FirestoreService().whatsappGrubuKatilmaTalepleri,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<WhatsappTalebi> talepler = [];

            snapshot.data.docs.forEach((element) {
              talepler.add(WhatsappTalebi.dokumandanUret(element));
            });

            // if (talepler.isEmpty) {
            //   return Center(
            //     child: Text(
            //       'Talep bulunamadı',
            //       style: GoogleFonts.poppins(
            //         color: Colors.black.withOpacity(0.7),
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   );
            // }

            // sort by olusturulmaZamani
            talepler.sort(
                (a, b) => b.olusturulmaZamani!.compareTo(a.olusturulmaZamani!));

            List<String> bolumler = [];
            for (var element in talepler) {
              if (!bolumler.contains(element.bolum)) {
                bolumler.add(element.bolum!);
              }
            }

            List<String> siniflar = [];
            for (var element in talepler) {
              if (!siniflar.contains(element.sinif)) {
                siniflar.add(element.sinif!);
              }
            }

            List<String> kodYazmaSureleri = [];
            for (var element in talepler) {
              if (!kodYazmaSureleri.contains(element.yazilimSuresi)) {
                kodYazmaSureleri.add(element.yazilimSuresi!);
              }
            }

            List<String> yazilimBilgisiPuani = [];
            for (var element in talepler) {
              if (!yazilimBilgisiPuani.contains(element.yazilimBilgisiPuani)) {
                yazilimBilgisiPuani.add(element.yazilimBilgisiPuani!);
              }
            }

            List<String> katildigiGunler = [];
            for (var element in talepler) {
              // if element.olusturulmaZamani is different than others, add it to katildigiGunler
              // olusturulmaZamani is TimeStamp, so we need to convert it to String
              if (!katildigiGunler.contains(element.olusturulmaZamani!
                  .toDate()
                  .toString()
                  .split(' ')[0])) {
                katildigiGunler.add(element.olusturulmaZamani!
                    .toDate()
                    .toString()
                    .split(' ')[0]);
              }
            }

            List<String> kisilerinIlgilendigiAlanlar = [];
            for (var element in talepler) {
              for (var element in element.ilgilendigiAlanlar!) {
                if (!kisilerinIlgilendigiAlanlar.contains(element)) {
                  kisilerinIlgilendigiAlanlar.add(element);
                }
              }
            }

            // sort siniflar by count
            siniflar.sort((a, b) {
              int aCount = 0;
              int bCount = 0;
              for (var element in talepler) {
                if (element.sinif == a) {
                  aCount++;
                }
                if (element.sinif == b) {
                  bCount++;
                }
              }
              return bCount.compareTo(aCount);
            });

            // sort bolumler by count
            bolumler.sort((a, b) {
              int aCount = 0;
              int bCount = 0;
              for (var element in talepler) {
                if (element.bolum == a) {
                  aCount++;
                }
                if (element.bolum == b) {
                  bCount++;
                }
              }
              return bCount.compareTo(aCount);
            });

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Extensions.boslukHeight(context, 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Kişilerin Bölümleri',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              itemCount: bolumler.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    bolumler[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Text(
                                    talepler
                                        .where((element) =>
                                            element.bolum == bolumler[index])
                                        .length
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Extensions.boslukHeight(context, 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Kişilerin Sınıfları',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              itemCount: siniflar.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    siniflar[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Text(
                                    talepler
                                        .where((element) =>
                                            element.sinif == siniflar[index])
                                        .length
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Extensions.boslukHeight(context, 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Kişilerin Yazılım Bilgisi Puanları',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              itemCount: yazilimBilgisiPuani.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    yazilimBilgisiPuani[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Text(
                                    talepler
                                        .where((element) =>
                                            element.yazilimBilgisiPuani ==
                                            yazilimBilgisiPuani[index])
                                        .length
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Extensions.boslukHeight(context, 0.02),
                    // kod yazma süreleri
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Kişilerin Kod Yazma Süreleri',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              itemCount: kodYazmaSureleri.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    kodYazmaSureleri[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Text(
                                    talepler
                                        .where((element) =>
                                            element.yazilimSuresi ==
                                            kodYazmaSureleri[index])
                                        .length
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Extensions.boslukHeight(context, 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Kişilerin İlgilendiği Alanlar',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              itemCount: kisilerinIlgilendigiAlanlar.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    kisilerinIlgilendigiAlanlar[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Text(
                                    talepler
                                        .where(
                                          (element) {
                                            // if (element.ilgilendigiAlanlar !=
                                            //     null) {
                                            //   return element.ilgilendigiAlanlar!
                                            //       .contains(
                                            //           kisilerinIlgilendigiAlanlar[
                                            //               index]);
                                            // } else {
                                            //   return false;
                                            // }

                                            // sort this by count

                                            List<int> list = [];
                                            list = element.ilgilendigiAlanlar!
                                                .map((e) =>
                                                    kisilerinIlgilendigiAlanlar
                                                        .indexOf(e))
                                                .toList();
                                            list.sort();

                                            return list.contains(index);
                                          },
                                        )
                                        .length
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Extensions.boslukHeight(context, 0.02),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Kişilerin Katıldığı Günler',
                          style: GoogleFonts.poppins(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              itemCount: katildigiGunler.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    katildigiGunler[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: Text(
                                    talepler
                                        .where((element) =>
                                            element.olusturulmaZamani!
                                                .toDate()
                                                .toString()
                                                .split(' ')[0] ==
                                            katildigiGunler[index])
                                        .length
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Extensions.boslukHeight(context, 0.02),
                    Divider(
                      endIndent: MediaQuery.of(context).size.width * 0.02,
                      indent: MediaQuery.of(context).size.width * 0.02,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Extensions.boslukHeight(context, 0.02),
                    FutureBuilder(
                        future: FirestoreService().egitimTalepleri,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<EgitimTalebi> egitimTalepleri = [];
                            List<String> alanlar = [];
                            snapshot.data.docs.forEach((element) {
                              egitimTalepleri
                                  .add(EgitimTalebi.dokumandanUret(element));
                            });

                            for (var element in egitimTalepleri) {
                              for (var element in element.istedigiEgitimler!) {
                                alanlar.add(element);
                              }
                            }
                            return Container(
                              decoration: BoxDecoration(
                                color:
                                    CustomColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ExpansionTile(
                                title: Text(
                                  'Eğitim Talepleri',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: ListView.builder(
                                      itemCount: alanlar.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            alanlar[index],
                                            style: GoogleFonts.poppins(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          trailing: Text(
                                            egitimTalepleri
                                                .where(
                                                  (element) {
                                                    List<int> list = [];
                                                    list = element
                                                        .istedigiEgitimler!
                                                        .map((e) =>
                                                            alanlar.indexOf(e))
                                                        .toList();
                                                    list.sort();

                                                    return list.contains(index);
                                                  },
                                                )
                                                .length
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox();
                        }),
                  ],
                ),
              ),
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
