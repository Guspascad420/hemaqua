import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget emptyFishCard() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0xFFD8E6FD),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
          child: Image.asset('images/empty_img.png', scale: 2.5),
        ),
        const SizedBox(height: 20),
        Text('Nama',
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w500
            )),
        Text('Nama Latin',
            style: GoogleFonts.poppins(
                fontSize: 17,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
            )),
        const SizedBox(height: 30),
      ],
    ),
  );
}