import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/models/whatsapp_talebi.dart';
import 'package:yazilim_toplulugu/pages/admin/kullanici_ara.dart';
import 'package:yazilim_toplulugu/services/firestore_service.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class TumKatilimcilarPage extends ConsumerStatefulWidget {
  const TumKatilimcilarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TumKatilimcilarPageState();
}

class _TumKatilimcilarPageState extends ConsumerState<TumKatilimcilarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tüm Katılımcılar',
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

            return Column(
              children: [
                // search text field
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KullaniciAraPage(
                            list: talepler,
                          ),
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Ara...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Extensions.boslukHeight(context, 0.02),
                      shrinkWrap: true,
                      itemCount: talepler.length,
                      itemBuilder: (context, index) {
                        WhatsappTalebi talep = talepler[index];

                        return Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: CustomColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: CustomColors.primaryColor,
                              child: Text(
                                talep.adiSoyadi!.substring(0, 1).toUpperCase(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            title: Text(
                              talep.adiSoyadi!,
                              style: GoogleFonts.poppins(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              talep.bolum!,
                              style: GoogleFonts.poppins(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            children: [
                              customTile(
                                title: "Öğrenci Numarası",
                                subtitle: talep.ogrenciNo.toString(),
                              ),
                              customTile(
                                title: "Telefon Numarası",
                                subtitle: talep.telefonNumarasi!,
                              ),
                              customTile(
                                  title: "Fakültesi", subtitle: talep.fakulte!),
                              customTile(
                                  title: "Bölümü", subtitle: talep.bolum!),
                              customTile(
                                  title: "Sınıfı", subtitle: talep.sinif!),
                              customTile(
                                title: "Yazılım Bilgisi Puanı",
                                subtitle: talep.yazilimBilgisiPuani!,
                              ),
                              customTile(
                                title: "Yazılım Süresi",
                                subtitle: talep.yazilimSuresi!,
                              ),
                              customTile(
                                title: "Github Kullanıcı Adı",
                                subtitle: talep.githubKullaniciAdi!,
                              ),
                              customTile(
                                title: "Oluşturulma Zamanı",
                                subtitle:
                                    "${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).day}.${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).month}.${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).year} - ${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).hour} : ${DateTime.fromMillisecondsSinceEpoch(talepler[index].olusturulmaZamani!.millisecondsSinceEpoch).minute}",
                              ),
                            ],
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

  Widget customTile({
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.black.withOpacity(0.7),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          color: Colors.black.withOpacity(0.6),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
