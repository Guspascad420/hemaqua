import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hemaqua_team.dart';
import 'package:hematologi/home/guest_home_page.dart';
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
  bool _isLoading = false;
  int _currentPage = 0;
  final PageController controller = PageController();

  Future<void> _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;

      if (user != null) {
        print("Signed in anonymously. UID: ${user.uid}");
        // Navigate to your main app content
        // Example:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const GuestHomePage()),
        );
      } else {
        // This case generally shouldn't happen if signInAnonymously succeeds
        print("Anonymous sign-in failed: User is null.");
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
      print("Unexpected Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 17, left: 10, right: 10),
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
                        fontSize: 16, color: const Color(0xFF4B5563)))),
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
                : const SizedBox(width: 22)
          ],
        ),
      ),
      body: PageView(
        controller: controller,
        children: [
          onboardingContent('images/med_research.png', 'Penilaian Komprehensif Kesehatan Air Sungai',
              'Aplikasi Analisis Profil Hematologi Ikan, Hemosit Gastropoda dan Kualitas Air untuk Menilai Kesehatan Perairan Sungai', false),
          onboardingTeamPage('images/researchers.png', 'Tim Kami', 'Aplikasi ini dibuat oleh Tim FPIK Universitas Brawijaya',
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HemaquaTeam())
                    );
                  }
          ),
          onboardingContent('images/med_research.png', 'Ayo Mulai!', 'Bersiap menjadi kontributor untuk analisis Profil Hematologi Ikan, Hemosit Gastropoda, dan Kualitas Air', true,
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