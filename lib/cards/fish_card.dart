import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget fishCard(String imageRes, String fishName, String speciesName) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageRes, scale: 2.5),
        const SizedBox(height: 10),
        Text(fishName,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w500
            )),
        Text(speciesName,
            style: GoogleFonts.poppins(
                fontSize: 17,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500
            )),
      ],
    ),
  );
}