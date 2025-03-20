import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget onboardingTeamPage(String imageRes, String title, String content, [void Function()? onButtonPressed]) {
  return Column(
    children: [
      const SizedBox(height: 80),
      Image.asset(imageRes, scale: 2.5),
      const SizedBox(height: 20),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(title, textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 27, color: const Color(0xFF3B82F6), fontWeight: FontWeight.w500
              ))
      ),
      const SizedBox(height: 20),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(content, textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.w500
              ))
      ),
      const SizedBox(height: 70),
      Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  padding: const EdgeInsets.symmetric(vertical: 12)),
              child: Text('Lihat semua anggota',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ))
          )
      ),
    ],
  );
}