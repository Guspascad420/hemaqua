import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hemosit/hemosit_add_species.dart';
import 'package:hematologi/hemosit/hemosit_species_cart.dart';
import 'package:hematologi/static_grid.dart';
import '../cards/species_card2.dart';
import '../models/species.dart';
import '../provider/providers.dart';


class HemositSpeciesList extends ConsumerWidget {
  final int station;

  const HemositSpeciesList({super.key, required this.station});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Species> favoriteSpeciesList = ref.watch(favoriteSpeciesListProvider);
    final asyncMolluscs = ref.watch(speciesesStreamProvider('mollusc'));

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FBFF),
        centerTitle: true,
        leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF60A5FA).withOpacity(0.3),
                  blurRadius: 3,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            margin: const EdgeInsets.only(left: 20),
            child: IconButton(
              padding: const EdgeInsets.only(left: 7),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
            )
        ),
        title: Text('Daftar Spesies',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      bottomNavigationBar: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HemositAddSpecies(station: station))
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 22),
              color: Colors.blue,
              child: Text('Tambah spesies baru', textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.white)),
            )
      ),
      body: asyncMolluscs.when(
        data: (molluscs) {
          return SingleChildScrollView(
              child: StaticGrid(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  gap: 20,
                  children: [
                    for(var mollusc in molluscs)
                      speciesCard2(ref, context, mollusc, station,
                          favoriteSpeciesList.any((e) => const MapEquality().equals(e.toMap(), mollusc.toMap())) ? true : false),
                  ]
              )
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          debugPrint(stackTrace.toString());
          return Center(
            child: Text('Error: $error'),
          );
        },
      )
    );
  }

}