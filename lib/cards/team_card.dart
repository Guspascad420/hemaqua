import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget teamCard(String imageRes, String name) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3), // Shadow color
          offset: const Offset(5, 5), // Shadow position (x, y)
          blurRadius: 7, // Blur intensity
          spreadRadius: 2, // Spread of the shadow
        ),
      ],
    ),
    child: Column(
      children: [
        Image.asset(imageRes, scale: 2,),
        const SizedBox(height: 20),
        Text(name,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w600
            )),
        const SizedBox(height: 10),
        Text('Posisi',
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500
            )),
        const SizedBox(height: 20),
        Image.asset('images/group_14400.png'),
      ],
    )
  );
}