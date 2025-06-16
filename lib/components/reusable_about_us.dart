import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget reusableAboutUs() {
  return Column(
    children: [
      const SizedBox(height: 20),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.blue
        ),
        child: Column(
          children: [
            FittedBox(
              child: Text('Tentang aplikasi kami',
                  style: GoogleFonts.poppins(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  )),
            ),
            const SizedBox(height: 10),
            Text("HEMAQUA adalah aplikasi inovatif yang dirancang untuk memudahkan analisis hematologi ikan dan hemosit moluska sebagai biomarker kualitas air. Aplikasi ini ditujukan untuk para peneliti, ahli lingkungan, dan pengelola sumber daya alam dalam memantau kesehatan ekosistem perairan. Dengan menggunakan parameter biologis dari organisme akuatik, HEMAQUA memberikan alat yang canggih untuk mendeteksi masalah kualitas air yang dapat memengaruhi kehidupan akuatik. "
                "Fitur utama aplikasi ini meliputi analisis profil darah ikan, "
                "analisis hemosit pada moluska, pemantauan kualitas air, "
                "perhitungan indeks pencemaran, dan penyimpanan data "
                "jangka panjang untuk analisis lebih lanjut.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                )),
            const SizedBox(height: 35),
            FittedBox(
              child: Text('Mengapa aplikasi kami?',
                  style: GoogleFonts.poppins(
                      fontSize: 23,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  )),
            ),
            const SizedBox(height: 10),
            Text("HEMAQUA hadir untuk memberikan solusi yang lebih efisien "
                "dan berbasis data dalam pemantauan kualitas air dan kesehatan "
                "ekosistem perairan. Dengan menggabungkan teknologi hematologi "
                "dan hemositologi yang canggih, aplikasi ini memungkinkan pengguna"
                " untuk mendeteksi potensi ancaman lingkungan lebih cepat dan akurat. "
                "Dibandingkan dengan metode konvensional, HEMAQUA menawarkan pendekatan yang "
                "lebih holistik dengan mengintegrasikan data kualitas air dan kesehatan organisme "
                "akuatik dalam satu platform yang mudah digunakan. Aplikasi ini tidak hanya membantu "
                "penelitian dan pengelolaan sumber daya alam, tetapi juga mendukung upaya konservasi dan "
                "perlindungan lingkungan yang lebih berkelanjutan.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                )),
          ],
        ),
      ),
    ],
  );
}