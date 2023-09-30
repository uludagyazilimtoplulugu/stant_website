import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:toastification/toastification.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class Toast {
  static showSuccesToast(BuildContext context, String message,
      {int seconds = 3}) {
    Toastification().showSuccess(
      backgroundColor: Colors.green,
      context: context,
      title: message,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      autoCloseDuration: Duration(seconds: seconds),
    );
  }

  static showErrorToast(BuildContext context,
      {String message = 'Bir hata oluştu. Daha sonra tekrar deneyiniz.'}) {
    Toastification().showError(
      backgroundColor: CustomColors.primaryRed,
      context: context,
      title: message,
      icon: const Icon(FontAwesomeIcons.xmark),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static showWarningToast(BuildContext context,
      {String message =
          'Eksik veya hatalı bilgi girdiniz. Lütfen kontrol ediniz.'}) {
    Toastification().showWarning(
      backgroundColor: CustomColors.primaryRed,
      context: context,
      title: message,
      icon: const Icon(FontAwesomeIcons.triangleExclamation),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
