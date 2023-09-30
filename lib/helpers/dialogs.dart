import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/main.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class UIHelpers {
  static getCustomDialog({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required List<Widget> buttons,
  }) {
    showDialog(
      context: GlobalcontextService.navigatorKey.currentContext!,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Extensions.boslukHeight(context, 0.023),
              Icon(
                icon,
                color: iconColor,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              Extensions.boslukHeight(context, 0.023),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.028,
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
                children: buttons,
              ),
              Extensions.boslukHeight(context, 0.023),
            ],
          ),
        );
      },
    );
  }

  static getCustomErrorDialog({
    String title = "Hata",
    String subtitle = "Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",
  }) {
    showDialog(
      context: GlobalcontextService.navigatorKey.currentContext!,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Extensions.boslukHeight(context, 0.023),
              Icon(
                FontAwesomeIcons.circleXmark,
                color: CustomColors.primaryColor,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              Extensions.boslukHeight(context, 0.023),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.028,
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
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.65,
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

  static getCustomErrorDialogWithoutButton({
    String title = "Hata",
    String subtitle = "Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.",
  }) {
    showDialog(
      context: GlobalcontextService.navigatorKey.currentContext!,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Extensions.boslukHeight(context, 0.023),
              Icon(
                FontAwesomeIcons.circleXmark,
                color: CustomColors.primaryColor,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              Extensions.boslukHeight(context, 0.023),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.028,
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
            ],
          ),
        );
      },
    );
  }

  static getCustomWarningDialog({
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
              borderRadius: BorderRadius.circular(20.0)), //this right here
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
                          MediaQuery.of(context).size.width,
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

  static getCustomSuccessDialog({
    String title = "Başarılı!",
    String subtitle = "İşlem başarıyla gerçekleştirildi",
  }) {
    showDialog(
      context: GlobalcontextService.navigatorKey.currentContext!,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Extensions.boslukHeight(context, 0.023),
              Icon(
                FontAwesomeIcons.circleCheck,
                color: CustomColors.primaryColor,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              Extensions.boslukHeight(context, 0.023),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.028,
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
                          MediaQuery.of(context).size.width,
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

  static getCustomSuccessDialogWithoutButton({
    String title = "Başarılı!",
    String subtitle = "İşlem başarıyla gerçekleştirildi",
  }) {
    showDialog(
      context: GlobalcontextService.navigatorKey.currentContext!,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Extensions.boslukHeight(context, 0.023),
              Icon(
                FontAwesomeIcons.circleCheck,
                color: CustomColors.primaryColor,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
              Extensions.boslukHeight(context, 0.023),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.028,
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
              Extensions.boslukHeight(context, 0.023),
            ],
          ),
        );
      },
    );
  }
}
