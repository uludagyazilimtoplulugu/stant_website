// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

enum ScreenType { mobile, tab, web }

class Responsive extends StatefulWidget {
  var mobileView, webView, tabView;

  Responsive({Key? key, this.mobileView, this.tabView, this.webView})
      : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    ScreenType scrType = getScreenType(context);
    switch (scrType) {
      case ScreenType.mobile:
        return widget.mobileView;
      case ScreenType.tab:
        return widget.tabView;
      case ScreenType.web:
        return widget.webView;
    }
  }
}

getMqWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

ScreenType getScreenType(BuildContext context) {
  double scrWidth = getMqWidth(context);
  if (scrWidth > 915) {
    return ScreenType.web;
  } else if (scrWidth < 650) {
    return ScreenType.mobile;
  }
  return ScreenType.tab;
}
