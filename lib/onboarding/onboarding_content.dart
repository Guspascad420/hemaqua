import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget onboardingContent(String imageRes, String title, String content,
    bool isLastPage, [void Function()? onButtonPressed]) {
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
      isLastPage
          ? Column(
              children: [
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
                        child: Text('Get Started',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ))
                    )
                ),
                const SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                        onPressed: onButtonPressed,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                  style: BorderStyle.solid
                                )
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12)),

                        child: Text('Login as guest',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ))
                    )
                ),
              ],
            )
          : const SizedBox()
    ],
  );
}