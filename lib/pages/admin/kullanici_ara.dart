import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/models/whatsapp_talebi.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class KullaniciAraPage extends ConsumerStatefulWidget {
  final List<WhatsappTalebi> list;
  const KullaniciAraPage({super.key, required this.list});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KullaniciAraPageState();
}

class _KullaniciAraPageState extends ConsumerState<KullaniciAraPage> {
  TextEditingController editingController = TextEditingController();
  List<WhatsappTalebi> searchList = [];

  @override
  void initState() {
    super.initState();
    searchList = widget.list;
  }

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
          'Kullanıcı Ara',
          style: GoogleFonts.poppins(
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // text field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                hintText: "Kullanıcı Ara",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: searchList.length,
              separatorBuilder: (context, index) =>
                  Extensions.boslukHeight(context, 0.02),
              itemBuilder: (context, index) {
                WhatsappTalebi talep = searchList[index];
                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
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
                    children: [
                      customTile(
                        title: "Öğrenci Numarası",
                        subtitle: talep.ogrenciNo.toString(),
                      ),
                      customTile(
                        title: "Telefon Numarası",
                        subtitle: talep.telefonNumarasi!,
                      ),
                      customTile(title: "Fakültesi", subtitle: talep.fakulte!),
                      customTile(title: "Bölümü", subtitle: talep.bolum!),
                      customTile(title: "Sınıfı", subtitle: talep.sinif!),
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
                            "${DateTime.fromMillisecondsSinceEpoch(searchList[index].olusturulmaZamani!.millisecondsSinceEpoch).day}.${DateTime.fromMillisecondsSinceEpoch(searchList[index].olusturulmaZamani!.millisecondsSinceEpoch).month}.${DateTime.fromMillisecondsSinceEpoch(searchList[index].olusturulmaZamani!.millisecondsSinceEpoch).year} - ${DateTime.fromMillisecondsSinceEpoch(searchList[index].olusturulmaZamani!.millisecondsSinceEpoch).hour} : ${DateTime.fromMillisecondsSinceEpoch(searchList[index].olusturulmaZamani!.millisecondsSinceEpoch).minute}",
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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

  void filterSearchResults(String query) {
    setState(() {
      searchList = widget.list.where((item) {
        String nameAndSurname = item.adiSoyadi.toString().toLowerCase() +
            item.ogrenciNo.toString().toLowerCase() +
            item.ogrenciNo.toString() +
            item.telefonNumarasi.toString();
        return nameAndSurname.contains(query.toLowerCase());
      }).toList();
    });
  }
}
