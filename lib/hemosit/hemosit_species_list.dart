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
        actions: [
          Container(
              height: 40,
              width: 40,
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
              margin: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HemositSpeciesCart(station: station))
                  );
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.blue),
              )
          ),
        ],
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
      body: StreamBuilder<List<Species>>(
          stream: ref.read(databaseServiceProvider).retrieveMolluscs(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Mohon cek koneksi internet kamu');
            }
            List<Species> molluscList = snapshot.data!;
            molluscList = molluscList.where((mollusk) =>
                mollusk.stations!.contains(station)).toList();
            return SingleChildScrollView(
                child: StaticGrid(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    gap: 20,
                    children: [
                      for(var mollusk in molluscList)
                        speciesCard2(context, mollusk, station,
                            favoriteSpeciesList.contains(mollusk)),
                    ]
                )
            );
          }
      )
    );
  }

}