import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/profile/member_card.dart';

class MemberDetails extends StatelessWidget {
  const MemberDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        centerTitle: true,
        title: Text('Member Details',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            memberCard('images/asus_maizar.png'),
            memberCard('images/m_asnin.png'),
            memberCard('images/4266925.png'),
          ],
        ),
      ),
    );
  }

}