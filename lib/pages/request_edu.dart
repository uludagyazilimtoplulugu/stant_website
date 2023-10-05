// ignore_for_file: use_build_context_synchronously

import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/helpers/toast.dart';
import 'package:yazilim_toplulugu/pages/main_page/desktop.dart';
import 'package:yazilim_toplulugu/pages/main_page/main_page.dart';
import 'package:yazilim_toplulugu/pages/main_page/mobile.dart';
import 'package:yazilim_toplulugu/pages/main_page/tab.dart';
import 'package:yazilim_toplulugu/services/firestore_service.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class EgitimAnketiPage extends ConsumerStatefulWidget {
  const EgitimAnketiPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EgitimAnketiPageState();
}

class _EgitimAnketiPageState extends ConsumerState<EgitimAnketiPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController moreTextController = TextEditingController();

  List<String> grades = [
    'Sınıfını Seç',
    'Hazırlık',
    '1. Sınıf',
    '2. Sınıf',
    '3. Sınıf',
    '4. Sınıf',
    '5. Sınıf',
    '6. Sınıf'
  ];

  List<String> konular = [
    'Web tasarım ve geliştirme',
    'Oyun geliştirme',
    'Uygulama geliştirme',
    'Siber güvenlik',
    'Veri bilimi',
    'Yapay zeka',
    'C',
    'Python',
    'C#',
    'Excel',
    'JavaScript',
    'Google teknolojileri',
    'Flutter',
    'Kriptoloji ve uygulama alanları',
    'Mülakat taktikleri',
    'Etkili sunum taktikleri',
    'Etkili cv& linkedin eğitimi',
    'İş hayatında başarılı olmak',
    'Diğer',
  ];
  List<String> selectedKonular = [];

  bool isLoading = false;

  bool isNameTapped = false;
  bool isMoreTextTapped = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          DirectSelectContainer(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  'Eğitim Al',
                  style: GoogleFonts.poppins(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                leading: BackButton(
                  color: Colors.black.withOpacity(0.8),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Extensions.boslukHeight(context, 0.02),
                    title('Adın Soyadın'),
                    Extensions.boslukHeight(context, 0.01),
                    Row(
                      children: [
                        Extensions.boslukWidth(context, 0.05),
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isMoreTextTapped = false;
                                isNameTapped = false;
                              });
                            },
                            onTap: () {
                              setState(() {
                                isMoreTextTapped = false;
                                isNameTapped = true;
                              });
                            },
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: CustomColors.primaryColor,
                            decoration: InputDecoration(
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.grey),
                              filled: true,
                              fillColor: isNameTapped
                                  ? CustomColors.primaryColor.withOpacity(0.2)
                                  : Colors.blueGrey[50],
                              labelStyle: GoogleFonts.poppins(fontSize: 12),
                              contentPadding: const EdgeInsets.only(left: 30),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey[50]!,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey[50]!,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Extensions.boslukWidth(context, 0.05),
                      ],
                    ),
                    Extensions.boslukHeight(context, 0.03),
                    title('Hangi alanlarda eğitim almak istersin?'),
                    Extensions.boslukHeight(context, 0.01),
                    Row(
                      children: [
                        Extensions.boslukWidth(context, 0.05),
                        Expanded(
                          child: MultiSelectBottomSheetField(
                            initialChildSize: 0.4,
                            backgroundColor: Colors.white,
                            checkColor: Colors.white,
                            cancelText: Text(
                              'İptal',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            confirmText: Text(
                              'Tamam',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: CustomColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selectedItemsTextStyle: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            itemsTextStyle: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                            searchIcon: Icon(
                              Icons.search,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            buttonIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            selectedColor: CustomColors.primaryColor,
                            // unselectedColor: Colors.white,
                            listType: MultiSelectListType.CHIP,
                            searchable: true,
                            buttonText: Text(
                              selectedKonular.isEmpty
                                  ? 'Konu Seç'
                                  : '${selectedKonular.length} konu seçildi',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            title: Text(
                              'İlgi alanlarını seç',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            items: konular
                                .map((e) => MultiSelectItem(e, e))
                                .toList(),
                            onConfirm: (values) {
                              setState(() {
                                selectedKonular =
                                    values.map((e) => e.toString()).toList();
                              });
                            },
                            chipDisplay: MultiSelectChipDisplay(
                              onTap: (value) {
                                setState(() {
                                  selectedKonular.remove(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Extensions.boslukWidth(context, 0.05),
                      ],
                    ),
                    Extensions.boslukHeight(context, 0.03),
                    title('Başka eklemek istediğin bir şey var mı?'),
                    Extensions.boslukHeight(context, 0.01),
                    Row(
                      children: [
                        Extensions.boslukWidth(context, 0.05),
                        Expanded(
                          child: TextField(
                            controller: moreTextController,
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                isNameTapped = false;
                                isMoreTextTapped = false;
                              });
                            },
                            onTap: () {
                              setState(() {
                                isNameTapped = false;
                                isMoreTextTapped = true;
                              });
                            },
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            cursorColor: CustomColors.primaryColor,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.grey),
                              filled: true,
                              fillColor: isMoreTextTapped
                                  ? CustomColors.primaryColor.withOpacity(0.2)
                                  : Colors.blueGrey[50],
                              labelStyle: GoogleFonts.poppins(fontSize: 12),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey[50]!,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey[50]!,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Extensions.boslukWidth(context, 0.05),
                      ],
                    ),
                    Extensions.boslukHeight(context, 0.03),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: CustomColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.9,
                          MediaQuery.of(context).size.height * 0.07,
                        ),
                      ),
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          Toast.showErrorToast(
                            context,
                            message: 'İsim boş bırakılamaz.',
                          );
                          return;
                        }
                        if (nameController.text.length < 3) {
                          Toast.showErrorToast(
                            context,
                            message: 'İsim en az 3 karakter olmalıdır.',
                          );
                          return;
                        }
                        if (selectedKonular.isEmpty) {
                          Toast.showErrorToast(
                            context,
                            message: 'Konu seçmelisin.',
                          );
                          return;
                        }
                        saveValues();
                      },
                      child: Text(
                        'Gönder',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Extensions.boslukHeight(context, 0.15),
                  ],
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void saveValues() async {
    try {
      setState(() {
        isLoading = true;
      });

      await FirestoreService().egitimTalebiOlustur(
        adiSoyadi: nameController.text,
        istedigiKonular: selectedKonular,
        eklemekIstedigiAlan: moreTextController.text,
      );
      setState(() {
        isLoading = false;
      });

      Toast.showSuccesToast(
        context,
        'Başvurun alınmıştır. Zaman ayırdığın için teşekkür ederiz.',
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Responsive(
            mobileView: const MainPageMobile(),
            tabView: const MainPageTab(),
            webView: const MainPageDesktop(),
          ),
        ),
        (route) => false,
      );
    } catch (e) {
      debugPrint("hata");
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
      Toast.showWarningToast(
        context,
        message: "Bir hata oluştu. LÜtfen daha sonra tekrar deneyin.",
      );
    }
  }

  title(String title) {
    return Row(
      children: [
        Extensions.boslukWidth(context, 0.05),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Extensions.boslukWidth(context, 0.05),
      ],
    );
  }
}
