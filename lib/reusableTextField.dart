import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget reusableTextField(String label, [TextInputType? keyboardType]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 5, bottom: 3),
        child: Text(label,
            style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.w500
            )),
      ),
      TextField(
        // controller: _passwordTextController,
        style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: true,
        enableSuggestions: false,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          fillColor: const Color(0xFFEFF6FF),
        ),
      ),
      const SizedBox(height: 20)
    ],
  );
}