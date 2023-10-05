// ignore_for_file: use_build_context_synchronously

import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:yazilim_toplulugu/helpers/departments.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/helpers/toast.dart';
import 'package:yazilim_toplulugu/pages/main_page/desktop.dart';
import 'package:yazilim_toplulugu/pages/main_page/main_page.dart';
import 'package:yazilim_toplulugu/pages/main_page/mobile.dart';
import 'package:yazilim_toplulugu/pages/main_page/tab.dart';
import 'package:yazilim_toplulugu/services/firestore_service.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class JoinWhatsappPage extends ConsumerStatefulWidget {
  const JoinWhatsappPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JoinWhatsappPageState();
}

class _JoinWhatsappPageState extends ConsumerState<JoinWhatsappPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController studentNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController githubUsernameController = TextEditingController();

  ExpansionTileController facultyTileController = ExpansionTileController();
  ExpansionTileController departmentTileController = ExpansionTileController();
  ExpansionTileController gradeTileController = ExpansionTileController();
  ExpansionTileController developmentDurationTileController =
      ExpansionTileController();
  ExpansionTileController developmentPointTileController =
      ExpansionTileController();

  List<String> developmentDurationList = [
    'Hiç kod yazmadım',
    '0-1 Yıl',
    '1-3 Yıl',
    '3-5 Yıl',
    '5-10 Yıl',
    '10+ Yıl'
  ];

  List<String> grades = [
    'Hazırlık',
    '1. Sınıf',
    '2. Sınıf',
    '3. Sınıf',
    '4. Sınıf',
    '5. Sınıf',
    '6. Sınıf'
  ];

  bool isNameTapped = false;
  bool isOgrenciNumarasiTapped = false;
  bool isGithubUsernameTapped = false;

  List<String> selectedDevelopmentAreas = [];
  List developmentAreas = [
    'Mobil Uygulama Geliştirme',
    'Web Geliştirme',
    'Web Geliştirme (Frontend)',
    'Web Geliştirme (Backend)',
    'Masaüstü Uygulama Geliştirme',
    'Oyun Geliştirme',
    'Blockchain',
    'Siber Güvenlik',
    'Yapay Zeka',
    'Prompt Mühendisliği (GPT)',
    'Veri Bilimi',
    'Gömülü Sistemler',
    'Robotik',
    'Donanım',
    'Nesnelerin İnterneti',
    'Diğer',
    'Henüz İlgi Duyduğuğum Alan Yok',
  ];

  List<String> softwareInfoPoints = [
    'Hiç kod yazmadım',
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  String selectedFaculty = "";
  String selectedDepartment = "";
  String selectedGrade = "";
  String selectedSoftwareInfoPoint = "";
  String selectedDevelopmentDuration = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // false
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                'Whatsapp Grubuna Katıl',
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
                              isNameTapped = false;
                              isOgrenciNumarasiTapped = false;
                              isGithubUsernameTapped = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              isNameTapped = true;
                              isOgrenciNumarasiTapped = false;
                              isGithubUsernameTapped = false;
                            });
                          },
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: CustomColors.primaryColor,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            filled: true,
                            fillColor: isNameTapped
                                ? CustomColors.primaryColor.withOpacity(0.2)
                                : CustomColors.primaryColor.withOpacity(0.1),
                            labelStyle: GoogleFonts.poppins(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CustomColors.primaryColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CustomColors.primaryColor.withOpacity(0.1),
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
                  title('Öğrenci Numaran'),
                  Extensions.boslukHeight(context, 0.01),
                  Row(
                    children: [
                      Extensions.boslukWidth(context, 0.05),
                      Expanded(
                        child: TextField(
                          controller: studentNumberController,
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isNameTapped = false;
                              isOgrenciNumarasiTapped = false;
                              isGithubUsernameTapped = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              isNameTapped = false;
                              isOgrenciNumarasiTapped = true;
                              isGithubUsernameTapped = false;
                            });
                          },
                          maxLength: 9,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          cursorColor: CustomColors.primaryColor,
                          decoration: InputDecoration(
                            counterText: "",
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            filled: true,
                            fillColor: isOgrenciNumarasiTapped
                                ? CustomColors.primaryColor.withOpacity(0.2)
                                : CustomColors.primaryColor.withOpacity(0.1),
                            labelStyle: GoogleFonts.poppins(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CustomColors.primaryColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CustomColors.primaryColor.withOpacity(0.1),
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
                  //telefon numaran
                  title('Telefon Numaran'),
                  Extensions.boslukHeight(context, 0.01),
                  Row(
                    children: [
                      Extensions.boslukWidth(context, 0.05),
                      Expanded(
                        child: TextField(
                          controller: phoneNumberController,
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isNameTapped = false;
                              isOgrenciNumarasiTapped = false;
                              isGithubUsernameTapped = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              isNameTapped = false;
                              isOgrenciNumarasiTapped = false;
                              isGithubUsernameTapped = true;
                            });
                          },
                          maxLength: 12,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            PhoneInputFormatter(
                              allowEndlessPhone: false,
                              defaultCountryCode: 'TR',
                            )
                          ],
                          cursorColor: CustomColors.primaryColor,
                          decoration: InputDecoration(
                            counterText: "",
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            filled: true,
                            fillColor: isGithubUsernameTapped
                                ? CustomColors.primaryColor.withOpacity(0.2)
                                : CustomColors.primaryColor.withOpacity(0.1),
                            labelStyle: GoogleFonts.poppins(fontSize: 12),
                            contentPadding: const EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CustomColors.primaryColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    CustomColors.primaryColor.withOpacity(0.1),
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
                  Row(
                    children: [
                      Extensions.boslukWidth(context, 0.05),
                      Expanded(child: getFacultyDrop()),
                      Extensions.boslukWidth(context, 0.05),
                    ],
                  ),
                  Extensions.boslukHeight(context, 0.03),
                  Row(
                    children: [
                      Extensions.boslukWidth(context, 0.05),
                      Expanded(child: getDepartmentDrop()),
                      Extensions.boslukWidth(context, 0.05),
                    ],
                  ),
                  Extensions.boslukHeight(context, 0.03),
                  Row(
                    children: [
                      Extensions.boslukWidth(context, 0.05),
                      Expanded(child: getClassDrop()),
                      Extensions.boslukWidth(context, 0.05),
                    ],
                  ),
                  Extensions.boslukHeight(context, 0.03),
                  Row(
                    children: [
                      Extensions.boslukWidth(context, 0.05),
                      Expanded(child: getSoftwareInfoDrop()),
                      Extensions.boslukWidth(context, 0.05),
                    ],
                  ),
                  Extensions.boslukHeight(context, 0.03),
                  selectedSoftwareInfoPoint.isNotEmpty &&
                          selectedSoftwareInfoPoint != 'Hiç kod yazmadım' &&
                          int.parse(selectedSoftwareInfoPoint) > 1
                      ? Column(
                          children: [
                            title('Github Kullanıcı Adın (Opsiyonel)'),
                            Extensions.boslukHeight(context, 0.01),
                            Row(
                              children: [
                                Extensions.boslukWidth(context, 0.05),
                                Expanded(
                                  child: TextField(
                                    controller: githubUsernameController,
                                    onTapOutside: (_) {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        isNameTapped = false;
                                        isOgrenciNumarasiTapped = false;
                                        isGithubUsernameTapped = false;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        isNameTapped = false;
                                        isOgrenciNumarasiTapped = false;
                                        isGithubUsernameTapped = true;
                                      });
                                    },
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    cursorColor: CustomColors.primaryColor,
                                    decoration: InputDecoration(
                                      hintStyle: GoogleFonts.poppins(
                                          color: Colors.grey),
                                      filled: true,
                                      fillColor: isGithubUsernameTapped
                                          ? CustomColors.primaryColor
                                              .withOpacity(0.2)
                                          : CustomColors.primaryColor
                                              .withOpacity(0.1),
                                      labelStyle:
                                          GoogleFonts.poppins(fontSize: 12),
                                      contentPadding:
                                          const EdgeInsets.only(left: 30),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustomColors.primaryColor
                                              .withOpacity(0.1),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: CustomColors.primaryColor
                                              .withOpacity(0.1),
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
                          ],
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      Extensions.boslukWidth(context, 0.05),
                      Expanded(child: getDevelopmentDurationDrop()),
                      Extensions.boslukWidth(context, 0.05),
                    ],
                  ),
                  Extensions.boslukHeight(context, 0.03),
                  title(
                      'İlgi duyduğun alan var mı, varsa hangileri? (Opsiyonel)'),
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
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          itemsTextStyle: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
                            selectedDevelopmentAreas.isEmpty
                                ? 'İlgi alanlarını seç'
                                : '${selectedDevelopmentAreas.length} ilgi alanı seçildi',
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
                          items: developmentAreas
                              .map((e) => MultiSelectItem(e, e))
                              .toList(),
                          onConfirm: (values) {
                            setState(() {
                              selectedDevelopmentAreas =
                                  values.map((e) => e.toString()).toList();
                            });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            onTap: (value) {
                              setState(() {
                                selectedDevelopmentAreas.remove(value);
                              });
                            },
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
                          message: 'İsim en az 3 karakter olmalı.',
                        );
                        return;
                      }
                      if (studentNumberController.text.isEmpty) {
                        Toast.showErrorToast(
                          context,
                          message: 'Öğrenci numarası boş bırakılamaz.',
                        );
                        return;
                      }
                      if (studentNumberController.text.length != 9) {
                        Toast.showErrorToast(
                          context,
                          message: 'Öğrenci numarası 9 haneli olmalı.',
                        );
                        return;
                      }
                      if (phoneNumberController.text.isEmpty) {
                        Toast.showErrorToast(
                          context,
                          message: 'Telefon numarası boş bırakılamaz.',
                        );
                        return;
                      }
                      if (phoneNumberController.text.length != 12) {
                        Toast.showErrorToast(
                          context,
                          message: 'Telefon numarası 10 haneli olmalı.',
                        );
                        return;
                      }
                      if (selectedFaculty == 'Fakülteni Seç' ||
                          selectedFaculty.isEmpty) {
                        Toast.showErrorToast(
                          context,
                          message: 'Fakülte seçmelisin.',
                        );
                        return;
                      }
                      if (selectedDepartment == 'Bölümünü Seç' ||
                          selectedDepartment.isEmpty) {
                        Toast.showErrorToast(
                          context,
                          message: 'Bölüm seçmelisin.',
                        );
                        return;
                      }
                      if (selectedGrade == 'Sınıfını Seç' ||
                          selectedGrade.isEmpty) {
                        Toast.showErrorToast(
                          context,
                          message: 'Sınıf seçmelisin.',
                        );
                        return;
                      }
                      if (selectedSoftwareInfoPoint == 'Puanla' ||
                          selectedSoftwareInfoPoint.isEmpty) {
                        Toast.showErrorToast(
                          context,
                          message: 'Yazılım bilginizi puanlamalısın.',
                        );
                        return;
                      }
                      // if (selectedDevelopmentDuration == 'Seç' ||
                      //     selectedDevelopmentDuration.isEmpty) {
                      //   Toast.showErrorToast(
                      //     context,
                      //     message: 'Ne kadardır kod yazdığınızı seçmelisin.',
                      //   );
                      //   return;
                      // }
                      // if (selectedDevelopmentAreas.isEmpty) {
                      //   Toast.showErrorToast(
                      //     context,
                      //     message: 'En az bir ilgi alanı seçmelisiniz.',
                      //   );
                      //   return;
                      // }
                      // if (selectedSoftwareInfoPoint.isNotEmpty &&
                      //     selectedSoftwareInfoPoint != 'Puanla' &&
                      //     int.parse(selectedSoftwareInfoPoint) != 0 &&
                      //     githubUsernameController.text.isEmpty) {
                      //   Toast.showErrorToast(
                      //     context,
                      //     message: 'Github kullanıcı adı boş bırakılamaz.',
                      //   );
                      //   return;
                      // }
                      saveValues();
                    },
                    child: Text(
                      'Whatsapp Grubuna Katıl',
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

  Widget getFacultyDrop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fakülteni Seç',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Extensions.boslukHeight(context, 0.002),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        //   child: Card(
        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       children: <Widget>[
        //         Expanded(
        //           child: Padding(
        //             padding: const EdgeInsets.only(left: 12),
        //             child: DirectSelectList<String>(
        //               onItemSelectedListener: (value, selectedIndex, context) {
        //                 debugPrint(value);
        //                 setState(() {
        //                   facultyIndex = selectedIndex;
        //                   selectedFaculty = value;
        //                   departmentIndex = 0;
        //                   selectedDepartment =
        //                       DepartmentListsHelper.getDepartmentData(
        //                               selectedFaculty)
        //                           .first;
        //                 });
        //               },
        //               onUserTappedListener: () => _showScaffold(),
        //               values: DepartmentListsHelper.fakulteler,
        //               defaultItemIndex: facultyIndex,
        //               itemBuilder: (String value) => getDropDownMenuItem(value),
        //               focusedItemDecoration: _getDslDecoration(),
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(right: 8),
        //           child: _getDropdownIcon(),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.primaryColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
                controller: facultyTileController,
                title: selectedFaculty.isEmpty
                    ? Text(
                        'Seç',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        selectedFaculty,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: DepartmentListsHelper.fakulteler.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            DepartmentListsHelper.fakulteler[index],
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedFaculty =
                                  DepartmentListsHelper.fakulteler[index];

                              selectedDepartment =
                                  DepartmentListsHelper.getDepartmentData(
                                          selectedFaculty)
                                      .first;
                              facultyTileController.collapse();
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withOpacity(0.5),
                        );
                      },
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  getDepartmentDrop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bölümünü Seç',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Extensions.boslukHeight(context, 0.002),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.primaryColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
                controller: departmentTileController,
                title: selectedDepartment.isEmpty
                    ? Text(
                        'Seç',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        selectedDepartment,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: DepartmentListsHelper.getDepartmentData(
                              selectedFaculty)
                          .length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            DepartmentListsHelper.getDepartmentData(
                                    selectedFaculty)[index]
                                .toString(),
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedDepartment =
                                  DepartmentListsHelper.getDepartmentData(
                                          selectedFaculty)[index]
                                      .toString();
                              departmentTileController.collapse();
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withOpacity(0.5),
                        );
                      },
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  Widget getClassDrop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sınıfını Seç',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Extensions.boslukHeight(context, 0.002),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.primaryColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
                controller: gradeTileController,
                title: selectedGrade.isEmpty
                    ? Text(
                        'Seç',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        selectedGrade,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: grades.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            grades[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedGrade = grades[index].toString();
                              gradeTileController.collapse();
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withOpacity(0.5),
                        );
                      },
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  Widget getSoftwareInfoDrop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yazılım bilgini 0 - 5 arasında puanlar mısın?',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Extensions.boslukHeight(context, 0.002),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.primaryColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
                controller: developmentPointTileController,
                title: selectedSoftwareInfoPoint.isEmpty
                    ? Text(
                        'Seç',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        selectedSoftwareInfoPoint,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: softwareInfoPoints.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            softwareInfoPoints[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedSoftwareInfoPoint =
                                  softwareInfoPoints[index].toString();
                              developmentPointTileController.collapse();
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withOpacity(0.5),
                        );
                      },
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  Widget getDevelopmentDurationDrop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ne kadar süredir kodlama yapıyorsun? (Opsiyonel)',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Extensions.boslukHeight(context, 0.002),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.primaryColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
                controller: developmentDurationTileController,
                title: selectedDevelopmentDuration.isEmpty
                    ? Text(
                        'Seç',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Text(
                        selectedDevelopmentDuration,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: developmentDurationList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            developmentDurationList[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedDevelopmentDuration =
                                  developmentDurationList[index].toString();
                              developmentDurationTileController.collapse();
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey.withOpacity(0.5),
                        );
                      },
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
      itemHeight: 56,
      value: value,
      itemBuilder: (context, value) {
        return Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        );
      },
    );
  }

  void saveValues() async {
    try {
      setState(() {
        isLoading = true;
      });
      // bool katilmaTalebiOlusturmusMu =
      //     await FirestoreService().whatsappKatilmaTalebiOlusturmusMu(
      //   ogrenciNo: studentNumberController.text,
      // );
      // if (katilmaTalebiOlusturmusMu) {
      //   setState(() {
      //     isLoading = false;
      //   });
      //   UIHelpers.getCustomDialog(
      //     icon: FontAwesomeIcons.triangleExclamation,
      //     iconColor: CustomColors.primaryColor,
      //     title: 'Uyarı',
      //     subtitle:
      //         'Bu öğrenci numarası ile daha önce başvuru yapılmış. Eğer devam ederseniz doldurduğunuz bilgiler eski başvurunuzun üzerine yazılacak. Devam etmek istiyor musunuz?',
      //     buttons: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: CustomColors.primaryColor,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             fixedSize: Size(
      //               MediaQuery.of(context).size.width * 0.65,
      //               MediaQuery.of(context).size.height * 0.06,
      //             ),
      //           ),
      //           onPressed: () async {
      //             await FirestoreService().whatsappGrubuKatilmaTalebiOlustur(
      //               adiSoyadi: nameController.text,
      //               ogrenciNo: studentNumberController.text,
      //               telefonNumarasi: phoneNumberController.text,
      //               fakulte: selectedFaculty,
      //               bolum: selectedDepartment,
      //               sinif: selectedGrade,
      //               yazilimBilgisiPuani: selectedSoftwareInfoPoint,
      //               yazilimSuresi: selectedDevelopmentDuration.isEmpty
      //                   ? ''
      //                   : selectedDevelopmentDuration,
      //               ilgilendigiAlanlar: selectedDevelopmentAreas,
      //               githubKullaniciAdi: githubUsernameController.text.isEmpty
      //                   ? ''
      //                   : githubUsernameController.text,
      //             );
      //             setState(() {
      //               isLoading = false;
      //             });

      //             Toast.showSuccesToast(
      //               context,
      //               'Başvurunuz alınmıştır. En kısa zamanda Whatsapp grubuna ekleneceksiniz.',
      //               seconds: 5,
      //             );
      //             Navigator.pushAndRemoveUntil(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => Responsive(
      //                   mobileView: const MainPageMobile(),
      //                   tabView: const MainPageTab(),
      //                   webView: const MainPageDesktop(),
      //                 ),
      //               ),
      //               (route) => false,
      //             );
      //           },
      //           child: Text(
      //             "Devam Et",
      //             style: GoogleFonts.poppins(
      //               fontSize: 17,
      //               fontWeight: FontWeight.w600,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: CustomColors.secondaryColor,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             fixedSize: Size(
      //               MediaQuery.of(context).size.width * 0.65,
      //               MediaQuery.of(context).size.height * 0.06,
      //             ),
      //           ),
      //           onPressed: () {
      //             Navigator.pop(
      //                 GlobalcontextService.navigatorKey.currentContext!);
      //           },
      //           child: Text(
      //             "Vazgeç",
      //             style: GoogleFonts.poppins(
      //               fontSize: 17,
      //               fontWeight: FontWeight.w600,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   );
      // } else {
      await FirestoreService().whatsappGrubuKatilmaTalebiOlustur(
        adiSoyadi: nameController.text,
        ogrenciNo: studentNumberController.text,
        telefonNumarasi: phoneNumberController.text,
        fakulte: selectedFaculty,
        bolum: selectedDepartment,
        sinif: selectedGrade,
        yazilimBilgisiPuani: selectedSoftwareInfoPoint,
        yazilimSuresi: selectedDevelopmentDuration,
        ilgilendigiAlanlar:
            selectedDevelopmentAreas.isEmpty ? [] : selectedDevelopmentAreas,
        githubKullaniciAdi: githubUsernameController.text,
      );
      setState(() {
        isLoading = false;
      });

      Toast.showSuccesToast(
        context,
        'Başvurunuz alınmıştır. En kısa Whatsapp grubuna ekleneceksiniz.',
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
      // }
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
}
