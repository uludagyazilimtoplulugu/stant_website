import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/models/egitim_talebi.dart';
import 'package:yazilim_toplulugu/services/firestore_service.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class EgitimTalepleriPage extends ConsumerStatefulWidget {
  const EgitimTalepleriPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EgitimTalepleriPageState();
}

class _EgitimTalepleriPageState extends ConsumerState<EgitimTalepleriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: BackButton(
          color: Colors.black.withOpacity(0.7),
        ),
        title: Text(
          'Eğitim Talepleri',
          style: GoogleFonts.poppins(
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirestoreService().egitimTalepleri,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<EgitimTalebi> talepler = [];
            snapshot.data.docs.forEach((element) {
              talepler.add(EgitimTalebi.dokumandanUret(element));
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

            return Scrollbar(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                itemCount: talepler.length,
                itemBuilder: (context, index) {
                  EgitimTalebi talep = talepler[index];

                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        '${talep.adiSoyadi}',
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${talep.bolum}',
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Text(
                        "${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).day}.${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).month}.${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).year} - ${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).hour} : ${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).minute}",
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'Fakültesi',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${talep.fakulte}',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Bölümü',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${talep.bolum}',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Sınıfı',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${talep.sinif}',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Oluşturulma Zamanı',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            "${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).day}.${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).month}.${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).year} - ${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).hour} : ${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).minute}",
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'İstediği Eğitimler',
                            style: GoogleFonts.poppins(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            shrinkWrap: true,
                            itemCount: talep.istedigiEgitimler!.length,
                            itemBuilder: (context, index) {
                              String istedigiEgitim =
                                  talep.istedigiEgitimler![index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${index + 1} - $istedigiEgitim",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
