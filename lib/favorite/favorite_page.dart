import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/models/species.dart';
import 'package:hematologi/static_grid.dart';
import '../cards/species_card.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteSpecies;
  final void Function(Map<String, dynamic>) removeSpeciesFromFavorite;

  const FavoritePage({super.key, required this.favoriteSpecies,
    required this.removeSpeciesFromFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FBFF),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.blue)
        ),
        title: Text('Favorit',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
        child: favoriteSpecies.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Image.asset('images/empty_fav.png', scale: 2.5,),
                  const SizedBox(height: 20),
                  Text('Tidak ada favorit',
                      style: GoogleFonts.poppins(
                          fontSize: 21,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600
                      )),
                  Text('Anda belum punya apa pun di daftar Anda. Tidak ada kata terlambat untuk mengubahnya',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                      )),
                ],
              )
            : StaticGrid(
                gap: 20,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  for (var species in favoriteSpecies)
                    speciesCard(context, Species(name: species["name"],
                        latin_name: species["latin_name"],
                        type: species["type"],
                        image_url: species["image_url"],
                        description: species["description"]), removeSpeciesFromFavorite),
                ]
            )
      )
    );
  }

}