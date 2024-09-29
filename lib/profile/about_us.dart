import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/profile/member_details.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        centerTitle: true,
        title: Text('About Us',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  Text('About Our App',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(height: 10),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                      ' sed do eiusmod tempor incididunt ut labore et dolore magna'
                      ' aliqua. Id venenatis a condimentum vitae sapien pellentesque '
                      'habitant morbi.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      )),
                  const SizedBox(height: 35),
                  Text('Why Our App',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(height: 10),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                      ' sed do eiusmod tempor incididunt ut labore et dolore magna'
                      ' aliqua. Id venenatis a condimentum vitae sapien pellentesque '
                      'habitant morbi.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  Text('Visions',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(height: 10),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                      ' sed do eiusmod tempor incididunt ut labore et dolore magna'
                      ' aliqua. Id venenatis a condimentum vitae sapien pellentesque '
                      'habitant morbi.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 35),
                  Text('Missions',
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(height: 10),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                      ' sed do eiusmod tempor incididunt ut labore et dolore magna'
                      ' aliqua. Id venenatis a condimentum vitae sapien pellentesque '
                      'habitant morbi.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 35),
                  Text('Our Team Members',
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
                        Image.asset('images/4266925.png', scale: 2)
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
                              MaterialPageRoute(builder: (context) => const MemberDetails()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              )
                          ),
                          child: Text('View member details',
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