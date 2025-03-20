import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/models/species.dart';
import 'package:hematologi/species/species_details.dart';

Widget bloodCard(BuildContext context, Species species) {
  return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SpeciesDetails(species: species,
                station: 1, isFavoriteSpecies: false, showBottomNav: true, addSpeciesToCart: (Species) {}))
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(species.image_url, scale: 2.3),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(species.name,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: const Color(0xFF3B82F6),
                          fontWeight: FontWeight.w500
                      )),
                ],
              ),
            )
          ],
        ),
      )
  );
}