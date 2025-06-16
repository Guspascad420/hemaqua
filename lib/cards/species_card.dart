import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/species.dart';
import '../species/species_details.dart';

Widget speciesCard(BuildContext context, Species species, bool isFavoriteSpecies) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SpeciesDetails(species: species,
              station: 1, isFavoriteSpecies: isFavoriteSpecies,
              showBottomNav: false,))
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: Colors.white,
      ),
      width: 175.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(species.image_url, scale: 1.8),
          const SizedBox(height: 10),
          Text(species.name,
              style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w500
              )),
          Text(species.latin_name,
              style: GoogleFonts.poppins(
                  fontSize: 17.sp,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500
              )),
        ],
      ),
    )
  );
}