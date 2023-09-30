import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yazilim_toplulugu/main_page.dart';
import 'package:yazilim_toplulugu/main_page/desktop.dart';
import 'package:yazilim_toplulugu/main_page/mobile.dart';
import 'package:yazilim_toplulugu/main_page/tab.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class GlobalcontextService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalcontextService.navigatorKey,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Yazılım Topluluğu',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
        useMaterial3: true,
      ),
      home: Responsive(
        mobileView: const MainPageMobile(),
        tabView: const MainPageTab(),
        webView: const MainPageDesktop(),
      ),
    );
  }
}
