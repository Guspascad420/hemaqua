import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget parameterBox(String title, void Function() onNavigate) {
  return GestureDetector(
    onTap: onNavigate,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF60A5FA).withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 21,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
              )),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.blue
            ),
            child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          )
        ],
      )
    )
  );
}