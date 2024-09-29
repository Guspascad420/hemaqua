import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget parameterBox(String title, bool isChecked, void Function(bool?) onChanged) {
  return GestureDetector(
    onTap: () {
      onChanged(!isChecked);
    },
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
          Checkbox(value: isChecked, onChanged: onChanged, activeColor: Colors.blue,)
        ],
      ),
    )
  );
}