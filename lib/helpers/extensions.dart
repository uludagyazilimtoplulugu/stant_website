import 'package:flutter/material.dart';

class Extensions {
  static Widget boslukHeight(BuildContext context, double deger) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * deger,
    );
  }

  static Widget boslukWidth(BuildContext context, double deger) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * deger,
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
