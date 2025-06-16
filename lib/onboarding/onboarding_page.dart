import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hemaqua_team.dart';
import 'package:hematologi/guest/guest_main_page.dart';
import 'package:hematologi/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hematologi/onboarding/onboarding_content.dart';

import 'onboarding_team_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentPage = 0;
  final PageController controller = PageController();

  Future<void> _signInAnonymously() async {

    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        // Navigate to your main app content
        // Example:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const GuestMainPage()),
        );
      } else {
        // This case generally shouldn't happen if signInAnonymously succeeds
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal masuk sebagai tamu. Mohon coba lagi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'operation-not-allowed') {
        errorMessage = 'Anonymous authentication is not enabled in Firebase for this project.';
      } else {
        errorMessage = 'An error occurred during guest login: ${e.message}';
      }
      print("Firebase Auth Error: $errorMessage");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        _currentPage = controller.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 17.h, left: 10.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LoginPage())
                  );
                },
                child: Text('Lewati',
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, color: const Color(0xFF4B5563)))),
            SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const ExpandingDotsEffect(
                  dotColor: Color(0xFFB0CEFC),
                  activeDotColor: Colors.blue
                ),
            ),
            _currentPage == 0 || _currentPage == 1
                ? const Icon(Icons.arrow_forward, color: Colors.blue)
                : SizedBox(width: 22.w)
          ],
        ),
      ),
      body: PageView(
        controller: controller,
        children: [
          onboardingContent('images/med_research.png', 'Penilaian Komprehensif Kesehatan Air Sungai', screenHeight,
              'Aplikasi Analisis Profil Hematologi Ikan, Hemosit Gastropoda dan Kualitas Air untuk Menilai Kesehatan Perairan Sungai', false),
          onboardingTeamPage('images/researchers.png', 'Tim Kami', 'Aplikasi ini dibuat oleh Tim FPIK Universitas Brawijaya',
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HemaquaTeam())
                    );
                  }
          ),
          onboardingContent('images/med_research.png', 'Ayo Mulai!', screenHeight, 'Bersiap menjadi kontributor untuk analisis Profil Hematologi Ikan, Hemosit Gastropoda, dan Kualitas Air', true,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage())
                    );
                  },
                  _signInAnonymously),
        ],
      ),
    );
  }

}