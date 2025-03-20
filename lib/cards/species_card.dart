import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/species.dart';
import '../species/species_details.dart';

Widget speciesCard(BuildContext context, Species species,
  void Function(Map<String, dynamic>) removeSpeciesFromFavorite) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SpeciesDetails(species: species,
              station: 1, isFavoriteSpecies: true,
              showBottomNav: false, removeSpeciesFromFavorite: removeSpeciesFromFavorite,))
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      width: 175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(species.image_url, scale: 1.8),
          const SizedBox(height: 10),
          Text(species.name,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w500
              )),
          Text(species.latin_name,
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500
              )),
        ],
      ),
    )
  );
}