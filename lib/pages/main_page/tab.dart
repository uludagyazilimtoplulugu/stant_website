import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/pages/admin/login.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class MainPageTab extends ConsumerStatefulWidget {
  const MainPageTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageTabState();
}

class _MainPageTabState extends ConsumerState<MainPageTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  children: [
                    TextSpan(
                      text: 'Selam',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' 👋',
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Extensions.boslukHeight(context, 0.03),
              Text(
                'Bursa Uludağ Üniversitesi Yazılım Topluluğu stant sayfasına hoşgeldin.',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              Extensions.boslukHeight(context, 0.01),
              Text(
                'Burayı görüntüleyebilmek için lütfen mobil cihazını kullan.',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              Extensions.boslukHeight(context, 0.02),
              // admin giris butonu
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminLoginPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.4,
                    MediaQuery.of(context).size.height * 0.05,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Admin Girişi',
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
