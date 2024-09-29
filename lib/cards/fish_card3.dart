import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget fishCard3(String imageRes) {
  return Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    child: Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xFFF4FBFF),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Image.asset(imageRes, scale: 2.5),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fish Name',
                style: GoogleFonts.poppins(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                )),
            Text('Species Name',
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                )),
            const SizedBox(height: 25),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue, size: 30,),
                const SizedBox(width: 4),
                Text('Location',
                    style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    )),
              ],
            ),
          ],
        )
      ],
    ),
  );
}