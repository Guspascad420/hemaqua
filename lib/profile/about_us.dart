import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_about_us.dart';
import 'package:hematologi/components/reusable_back_button.dart';
import 'package:hematologi/hemaqua_team.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        centerTitle: true,
        title: Text('Tentang Kami',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
        leading: const ReusableBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            reusableAboutUs(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  Text('Visi',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(height: 10),
                  Text("Menjadi aplikasi terdepan dalam pemantauan kualitas "
                      "air berbasis analisis biologis yang mendukung kelestarian "
                      "ekosistem perairan global, memastikan kualitas air yang lebih baik "
                      "dan berkelanjutan untuk generasi mendatang.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 35),
                  Text('Misi',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(height: 10),
                  Text("1.	Mengembangkan teknologi canggih untuk analisis hematologi ikan dan hemosit moluska yang dapat memberikan gambaran yang lebih jelas tentang kondisi kualitas air."
                      "2.	Menyediakan alat yang efisien bagi peneliti dan pengelola sumber daya alam untuk mendeteksi ancaman terhadap ekosistem perairan dengan lebih cepat dan akurat."
                      "3.	Meningkatkan pemahaman masyarakat dan pihak berwenang mengenai pentingnya kualitas air dalam menjaga keseimbangan ekosistem dan kesehatan lingkungan."
                      "4.	Mendukung pengelolaan sumber daya perairan yang berkelanjutan melalui data yang dapat diakses dan dianalisis untuk pengambilan keputusan yang lebih baik.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 35),
                  Text('Anggota tim kami',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600
                      )),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset('images/asus_maizar.png', scale: 2),
                        Image.asset('images/m_asnin.png', scale: 2),
                        Image.asset('images/4266925.png', scale: 2),
                        Image.asset('images/kasyful.png', scale: 2)
                      ],
                    )
                  ),
                  Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const HemaquaTeam()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              )
                          ),
                          child: Text('Lihat detail anggota',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500
                              ))
                      )
                  )
                ],
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      )
    );
  }

}