import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget memberCard(String imageRes) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white
    ),
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageRes),
        const SizedBox(height: 15),
        Text('Name',
            style: GoogleFonts.poppins(
                fontSize: 23,
                color: Colors.blue,
                fontWeight: FontWeight.w500
            )),
        Text('Position',
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500
            )),
        const SizedBox(height: 15),
        Text('Lorem ipsum dolor sit amet, '
            'consectetur adipiscing elit. Nunc vulputate libero '
            'et velit interdum, ac aliquet odio mattis.',
            style: GoogleFonts.poppins(
                fontSize: 18,
            )),
        const SizedBox(height: 15),
        Image.asset('images/group_14400.png', scale: 2)
      ],
    ),
  );
}