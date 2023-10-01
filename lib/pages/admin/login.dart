// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/helpers/toast.dart';
import 'package:yazilim_toplulugu/main.dart';
import 'package:yazilim_toplulugu/models/admin.dart';
import 'package:yazilim_toplulugu/pages/admin/panel.dart';
import 'package:yazilim_toplulugu/pages/main_page/main_page.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class AdminLoginPage extends ConsumerStatefulWidget {
  const AdminLoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends ConsumerState<AdminLoginPage> {
  bool isLoading = false;
  bool isShowPassword = false;

  bool isOgrenciNumarasiTapped = false;
  bool isSifreTapped = false;

  TextEditingController ogrenciNumarasiController = TextEditingController();
  TextEditingController sifreController = TextEditingController();

  TextEditingController adminTelefonNumarasiController =
      TextEditingController();
  TextEditingController adminAdiController = TextEditingController();
  TextEditingController adminOgrenciNumarasiController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenType scrType = getScreenType(context);
    if (scrType == ScreenType.web) {
      return desktop();
    } else {
      return mobile();
    }
  }

  mobile() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFf5f5f5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFf5f5f5),
            leading: const BackButton(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: _formLogin(),
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

  desktop() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFf5f5f5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFf5f5f5),
            leading: const BackButton(
              color: Colors.black,
            ),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uludağ Yazılım Topluluğu \nStant Admin Girişi',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Extensions.boslukHeight(context, 0.02),
                    Text(
                      "Giriş yaparak stant bilgilerine ulaşabilirsin.",
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      'images/developer.svg',
                      width: MediaQuery.of(context).size.width * 0.2,
                    )
                  ],
                ),
              ),

              // MediaQuery.of(context).size.width >= 1300 //Responsive
              //     ? Image.asset(
              //         'images/illustration-1.png',
              //         width: 300,
              //       )
              //     : SizedBox(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.2,
                child: _formLogin(),
              ),
            ],
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

  Widget _formLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: ogrenciNumarasiController,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();

            setState(() {
              isOgrenciNumarasiTapped = false;
              isSifreTapped = false;
            });
          },
          onTap: () {
            setState(() {
              isOgrenciNumarasiTapped = true;
              isSifreTapped = false;
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
            hintText: 'Öğrenci Numarası',
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
            filled: true,
            fillColor: isOgrenciNumarasiTapped
                ? CustomColors.primaryColor.withOpacity(0.2)
                : Colors.blueGrey[50],
            labelStyle: GoogleFonts.poppins(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey[50]!,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey[50]!,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
          controller: sifreController,
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
            setState(() {
              isOgrenciNumarasiTapped = false;
              isSifreTapped = false;
            });
          },
          onTap: () {
            setState(() {
              isOgrenciNumarasiTapped = false;
              isSifreTapped = true;
            });
          },
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          obscureText: !isShowPassword,
          cursorColor: CustomColors.primaryColor,
          decoration: InputDecoration(
            hintText: 'Şifre',
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isShowPassword = !isShowPassword;
                });
              },
              icon: Icon(
                isShowPassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: isSifreTapped
                ? CustomColors.primaryColor.withOpacity(0.2)
                : Colors.blueGrey[50],
            labelStyle: GoogleFonts.poppins(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: CustomColors.secondaryColor.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              if (ogrenciNumarasiController.text.isEmpty ||
                  sifreController.text.isEmpty) {
                warningDialogWeb(
                  subtitle: "Lütfen boş alan bırakmayın.",
                );
              } else if (ogrenciNumarasiController.text.length < 9) {
                warningDialogWeb(
                  subtitle: "Öğrenci numaranı eksik girdin.",
                );
              } else if (sifreController.text.length < 6) {
                warningDialogWeb(
                  subtitle: "Şifre minimum 6 karakter olmalıdır.",
                );
              } else {
                _login();
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: CustomColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  "Giriş Yap",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static warningDialogWeb({
    String title = "Uyarı",
    String subtitle = "Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",
  }) {
    showDialog(
      context: GlobalcontextService.navigatorKey.currentContext!,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Extensions.boslukHeight(context, 0.023),
              Icon(
                FontAwesomeIcons.triangleExclamation,
                color: CustomColors.primaryColor,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              Extensions.boslukHeight(context, 0.023),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Extensions.boslukHeight(context, 0.004),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Extensions.boslukHeight(context, 0.013),
              // add buttons and space between them
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.3,
                          MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(
                            GlobalcontextService.navigatorKey.currentContext!);
                      },
                      child: Text(
                        "Tamam",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Extensions.boslukHeight(context, 0.023),
            ],
          ),
        );
      },
    );
  }

  void _login() async {
    try {
      setState(() {
        isLoading = true;
      });
      // get the adminler collection from firebase
      List<Admin> adminler = await FirebaseFirestore.instance
          .collection("adminler")
          .get()
          .then((value) =>
              value.docs.map((e) => Admin.dokumandanUret(e)).toList());
      setState(() {
        isLoading = false;
      });
      bool eslesenVarMi = false;
      for (var element in adminler) {
        if (element.ogrenciNo == ogrenciNumarasiController.text) {
          setState(() {
            eslesenVarMi = true;
          });
        }
      }
      if (!eslesenVarMi) {
        warningDialogWeb(
          subtitle: "Böyle bir admin bulunamadı.",
        );
      } else {
        for (var element in adminler) {
          if (element.ogrenciNo == ogrenciNumarasiController.text) {
            if (element.password == sifreController.text) {
              setState(() {
                isLoading = false;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPaneliPage(
                    admin: element,
                  ),
                ),
              );
            } else {
              warningDialogWeb(
                subtitle: "Şifreni yanlış girdin.",
              );
            }
          }
        }
      }
    } catch (e) {
      debugPrint("Hata: $e");
      setState(() {
        isLoading = false;
      });
      Toast.showErrorToast(
        context,
        message: "Bir hata oluştu. Lütfen daha sonra tekrar deneyin.",
      );
    }
  }
}
