import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget documentaryCard(String imageRes, String title, String content) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    margin: const EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Image.asset(imageRes, scale: 2.8),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color(0xFF3B82F6),
                fontWeight: FontWeight.w600
            )),
            const SizedBox(height: 7),
            SizedBox(
              width: 180,
              child: RichText(
                  text: TextSpan(
                    text: content,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                    children: [
                      TextSpan(text: ' Read More', style: GoogleFonts.poppins(color: Colors.blue))
                    ]
                  ),
              )
            )
          ],
        )
      ],
    )
  );
}