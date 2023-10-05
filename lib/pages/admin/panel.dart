import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yazilim_toplulugu/helpers/extensions.dart';
import 'package:yazilim_toplulugu/models/admin.dart';
import 'package:yazilim_toplulugu/pages/admin/bugun_katilanlar.dart';
import 'package:yazilim_toplulugu/pages/admin/egitim_talepleri.dart';
import 'package:yazilim_toplulugu/pages/admin/statistics.dart';
import 'package:yazilim_toplulugu/pages/admin/tum_katilimcilar.dart';
import 'package:yazilim_toplulugu/pages/admin/whatsapp_talepleri.dart';
import 'package:yazilim_toplulugu/utils/colors.dart';

class AdminPaneliPage extends ConsumerStatefulWidget {
  final Admin admin;
  const AdminPaneliPage({super.key, required this.admin});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminPaneliPageState();
}

class _AdminPaneliPageState extends ConsumerState<AdminPaneliPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFf5f5f5),
        title: Text(
          'Selam ${widget.admin.name}',
          style: GoogleFonts.poppins(
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WhatsappTalepleriPage(),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.whatsapp,
                        color: CustomColors.primaryColor,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Extensions.boslukHeight(context, 0.02),
                      Text(
                        'Whatsapp\nTalepleri',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BugunKatilanlarPage(),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.calendarDay,
                        color: CustomColors.primaryColor,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Extensions.boslukHeight(context, 0.02),
                      Text(
                        'Bugün\nKatılanlar',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IstatistiklerPage(),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.chartColumn,
                        color: CustomColors.primaryColor,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Extensions.boslukHeight(context, 0.02),
                      Text(
                        'İstatistikler',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EgitimTalepleriPage(),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.school,
                        color: CustomColors.primaryColor,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Extensions.boslukHeight(context, 0.02),
                      Text(
                        'Eğitim\nTalepleri',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TumKatilimcilarPage(),
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.users,
                        color: CustomColors.primaryColor,
                        size: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Extensions.boslukHeight(context, 0.02),
                      Text(
                        'Tüm\nKatılanlar',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
