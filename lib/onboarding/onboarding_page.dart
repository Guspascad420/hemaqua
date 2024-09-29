import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/login_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hematologi/onboarding/onboarding_content.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController controller = PageController();

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
          onboardingContent('images/researchers.png', 'Tim Kami', '', false),
          onboardingContent('images/med_research.png', 'Ayo Mulai!', 'Bersiap menjadi kontributor untuk analisis Profil Hematologi Ikan, Hemosit Gastropoda, dan Kualitas Air', true,
                  () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage())
                    );
                  }),
        ],
      ),
    );
  }

}