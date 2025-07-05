import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/models/species.dart';
import 'package:hematologi/species/species_details.dart';

import '../provider/providers.dart';

Widget speciesCard2(WidgetRef ref, BuildContext context, Species species) {
  final imageUrlAsync = ref.watch(imageUrlProvider(species.image_url ?? ''));
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        imageUrlAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Center(child: Icon(Icons.error)),
            data: (url) {
              return Center(
                child: Image.network(url, scale: 1.8),
              );
            }
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
              Text(species.latin_name,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500
                  ))
            ],
          ),
        )
      ],
    ),
  );
}