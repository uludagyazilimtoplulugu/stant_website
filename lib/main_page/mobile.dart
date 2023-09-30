import 'dart:ui';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:yazilim_toplulugu/helpers/dialogs.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class MainPageMobile extends ConsumerStatefulWidget {
  const MainPageMobile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

const double _bottomPaddingForButton = 150.0;
const double _buttonHeight = 56.0;
const double _pagePadding = 16.0;
const double _pageBreakpoint = 768.0;

class _MainPageState extends ConsumerState<MainPageMobile> {
  // scrollController
  ScrollController scrollController = ScrollController();
  bool showAppBarText = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController studentNoController = TextEditingController();

  bool isLoading = false;

  int bugunKatilanlar = 0;
  int etkinliklereKatilanlar = 8371;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    int mod5 = now.day % 6;
    if (now.day.isEven) {
      bugunKatilanlar = now.day + 89 + mod5;
    } else {
      bugunKatilanlar = now.day + 69 + mod5;
    }
    scrollController.addListener(() {
      if (scrollController.offset > 100) {
        setState(() {
          showAppBarText = true;
        });
      } else {
        setState(() {
          showAppBarText = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageIndexNotifier = ValueNotifier(0);

    WoltModalSheetPage page1(
      BuildContext modalSheetContext,
    ) {
      return WoltModalSheetPage.withSingleChild(
        hasSabGradient: false,
        stickyActionBar: Padding(
          padding: const EdgeInsets.all(_pagePadding),
          child: Column(
            children: [
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: CustomColors.primaryColor,
                ),
                onPressed: () {
                  if (phoneController.text.length == 12) {
                    pageIndexNotifier.value = pageIndexNotifier.value + 1;
                    // open keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  } else if (phoneController.text.isEmpty) {
                    // show dialog
                    UIHelpers.getCustomWarningDialog(
                      subtitle: "Lütfen telefon numaranı gir.",
                    );
                  } else {
                    // show dialog
                    UIHelpers.getCustomWarningDialog(
                      subtitle: "Lütfen geçerli bir telefon numarası gir.",
                    );
                  }
                },
                child: SizedBox(
                  height: _buttonHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'İlerle',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        topBarTitle: Text(
          'Telefon Numaranı Gir',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize:
                  MediaQuery.of(context).size.width > _pageBreakpoint ? 24 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(_pagePadding),
          icon: const Icon(Icons.close),
          onPressed: Navigator.of(modalSheetContext).pop,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _pagePadding,
            _pagePadding,
            _pagePadding,
            _bottomPaddingForButton,
          ),
          child: TextFormField(
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
            maxLength: 12,
            controller: phoneController,
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Telefon Numaran',
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                borderSide: BorderSide(
                  color: CustomColors.primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      );
    }

    WoltModalSheetPage page2(BuildContext modalSheetContext) {
      return WoltModalSheetPage.withSingleChild(
        leadingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(_pagePadding),
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () =>
              pageIndexNotifier.value = pageIndexNotifier.value - 1,
        ),
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(_pagePadding),
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(modalSheetContext).pop();
            pageIndexNotifier.value = 0;
          },
        ),
        hasSabGradient: false,
        stickyActionBar: Padding(
          padding: const EdgeInsets.all(_pagePadding),
          child: Column(
            children: [
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: CustomColors.primaryColor,
                ),
                onPressed: () {
                  if (studentNoController.text.length == 9) {
                    Navigator.of(modalSheetContext).pop();
                    saveValues();
                  } else if (studentNoController.text.isEmpty) {
                    // show dialog
                    UIHelpers.getCustomWarningDialog(
                      subtitle: "Lütfen öğrenci numaranı gir.",
                    );
                  } else {
                    // show dialog
                    UIHelpers.getCustomWarningDialog(
                      subtitle: "Lütfen geçerli bir öğrenci numarası gir.",
                    );
                  }
                },
                child: SizedBox(
                  height: _buttonHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'İlerle',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        topBarTitle: Text(
          'Öğrenci Numaranı Gir',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize:
                  MediaQuery.of(context).size.width > _pageBreakpoint ? 24 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        isTopBarLayerAlwaysVisible: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            _pagePadding,
            _pagePadding,
            _pagePadding,
            _bottomPaddingForButton,
          ),
          child: TextFormField(
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 9,
            controller: studentNoController,
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Öğrenci Numaran',
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                borderSide: BorderSide(
                  color: CustomColors.primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColors.primaryColor,
                  CustomColors.secondaryColor,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  // shadowColor: Colors.transparent,
                  backgroundColor: showAppBarText
                      ? Colors.transparent.withOpacity(0.1)
                      : Colors.transparent,
                  elevation: 0,
                  // centerTitle: false,
                  primary: false,
                  title: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: showAppBarText
                        ? MediaQuery.of(context).size.height * 0.05
                        : 0,
                    child: Center(
                      child: Text(
                        showAppBarText ? 'Uludağ Yazılım Topluluğu' : '',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                  // floating: true,
                  // snap: true,
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1,
                      left: MediaQuery.of(context).size.width * 0.06,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        children: [
                          TextSpan(
                            text: 'Selam',
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * 0.1,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: ' 👋',
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * 0.1,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Text(
                      'Yazılım Topluluğu standına hoşgeldin!',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/welcome.svg',
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Bugün Aramıza\nKatılanlar',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            Countup(
                              begin: 0,
                              end: bugunKatilanlar.toDouble(),
                              duration: const Duration(seconds: 2),
                              separator: ',',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Geçen Sene\nEtkinliklere Katılanlar',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            Countup(
                              begin: 0,
                              end: etkinliklereKatilanlar.toDouble(),
                              duration: const Duration(seconds: 3),
                              separator: ',',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Bugüne Kadar\nYazılan Satır Sayısı',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            Countup(
                              begin: 0,
                              end: 1882692,
                              duration: const Duration(seconds: 4),
                              separator: ',',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Extensions.boslukHeight(context, 0.03),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1,
                      left: MediaQuery.of(context).size.width * 0.06,
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Text(
                      'Whatsapp grubuna katılmak için aşağıdaki butonu kullan.',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.07,
                        ),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          Text(
                            "Whatsapp Grubuna Katıl",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        WoltModalSheet.show<void>(
                          pageIndexNotifier: pageIndexNotifier,
                          context: context,
                          pageListBuilder: (modalSheetContext) {
                            return [
                              page1(modalSheetContext),
                              page2(modalSheetContext),
                            ];
                          },
                          modalTypeBuilder: (context) {
                            final size = MediaQuery.of(context).size.width;
                            if (size < _pageBreakpoint) {
                              return WoltModalType.bottomSheet;
                            } else {
                              return WoltModalType.dialog;
                            }
                          },
                          onModalDismissedWithBarrierTap: () {
                            debugPrint('Closed modal sheet with barrier tap');
                            Navigator.of(context).pop();
                            pageIndexNotifier.value = 0;
                          },
                          maxDialogWidth: 560,
                          minDialogWidth: 400,
                          minPageHeight: 0.0,
                          maxPageHeight: 0.9,
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1,
                      left: MediaQuery.of(context).size.width * 0.06,
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Text(
                      'Yazılım öğrenmek istiyorsan butona tıkla. Böylece öğrenmek istediğin alan hakkında daha fazla çalışırız.',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.07,
                        ),
                        backgroundColor: CustomColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.laptopCode,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          Text(
                            "Yazılım Eğitimi Al",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1,
                      left: MediaQuery.of(context).size.width * 0.06,
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Text(
                      'Discord sunucumuza katılarak topluluk üyeleriyle sohbet edebilirsin.',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.07,
                        ),
                        backgroundColor: const Color(0xff36393e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.discord,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          Text(
                            "Discord",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: Text(
                      'Ayrıca, topluluğumuzun sosyal medya hesaplarını takip etmeyi unutma!',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.instagram,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            try {
                              bool launched =
                                  // ignore: deprecated_member_use
                                  await launch(
                                'https://www.instagram.com/uludagdev',
                                forceSafariVC: false,
                              );

                              if (!launched) {
                                // ignore: deprecated_member_use
                                launch('https://www.instagram.com/uludagdev');
                              }
                            } catch (e) {
                              // ignore: deprecated_member_use
                              launch('https://www.instagram.com/uludagdev');
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            try {
                              bool launched =
                                  // ignore: deprecated_member_use
                                  await launch(
                                'https://www.instagram.com/gdsculudag/',
                                forceSafariVC: false,
                              );

                              if (!launched) {
                                // ignore: deprecated_member_use
                                launch('https://www.instagram.com/gdsculudag/');
                              }
                            } catch (e) {
                              // ignore: deprecated_member_use
                              launch('https://www.instagram.com/gdsculudag/');
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            try {
                              bool launched =
                                  // ignore: deprecated_member_use
                                  await launch(
                                'https://www.linkedin.com/company/uludagdev/',
                                forceSafariVC: false,
                              );

                              if (!launched) {
                                // ignore: deprecated_member_use
                                launch(
                                    'https://www.linkedin.com/company/uludagdev/');
                              }
                            } catch (e) {
                              // ignore: deprecated_member_use
                              launch(
                                  'https://www.linkedin.com/company/uludagdev/');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Extensions.boslukHeight(context, 0.1),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text(
                        '''Built & Developed by Uludag Developers''',
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '''with Flutter 💙''',
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  saveValues() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
    UIHelpers.getCustomSuccessDialog(
      subtitle: 'Whatsapp grubuna katılma isteğin gönderildi.',
    );
  }
}
