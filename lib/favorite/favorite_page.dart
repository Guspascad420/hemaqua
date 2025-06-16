import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_back_button.dart';
import 'package:hematologi/static_grid.dart';
import '../cards/species_card.dart';
import '../provider/providers.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFavorites = ref.watch(favoriteSpeciesStreamProvider);
    return asyncFavorites.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (favoriteSpecies) {
        return Scaffold(
            backgroundColor: const Color(0xFFF4FBFF),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF4FBFF),
              centerTitle: true,
              leading: const ReusableBackButton(),
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
                        speciesCard(context, species, true),
                    ]
                )
            )
        );
      }
    );
  }

}