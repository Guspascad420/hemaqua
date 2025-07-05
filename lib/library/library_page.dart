import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bottom_nav_bar.dart';
import '../cards/species_card2.dart';
import '../models/species.dart';
import '../provider/providers.dart';
import '../species/species_details.dart';
import '../static_grid.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final selectedStatus = ref.watch(speciesTypeFilterProvider);
    final List<Species> favoriteSpeciesList = ref.watch(favoriteSpeciesListProvider);
    final speciesAsync = ref.watch(filteredSpeciesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
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
            margin: EdgeInsets.only(left: 20.w),
            child: IconButton(
              padding: const EdgeInsets.only(left: 7),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
            )
        ),
        title: Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: GoogleFonts.poppins(fontSize: 15),
            onChanged: (text) {
              ref.read(speciesSearchQueryProvider.notifier).state = text;
            },
            decoration: InputDecoration(
              hintText: "Cari...",
              hintStyle: GoogleFonts.poppins(
                fontSize: 15.sp,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF4FBFF),
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(label: Text('Semua', style: GoogleFonts.poppins(color: selectedStatus == 'Semua' ? Colors.white : Colors.black
                    , fontWeight: FontWeight.w500)),
                    onSelected: (b) {
                      ref.read(speciesTypeFilterProvider.notifier).state = 'Semua';
                    },
                    selectedColor: Colors.blue,
                    checkmarkColor: Colors.white,
                    selected: selectedStatus == 'Semua'),
                SizedBox(width: 15.w),
                ChoiceChip(label: Text('Ikan', style: GoogleFonts.poppins(color: selectedStatus == 'fish' ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500)),
                    onSelected: (b) {
                      ref.read(speciesTypeFilterProvider.notifier).state = 'fish';
                    },
                    selectedColor: Colors.blue,
                    checkmarkColor: Colors.white,
                    selected: selectedStatus == 'fish'),
                SizedBox(width: 15.w),
                ChoiceChip(label: Text('Moluska', style: GoogleFonts.poppins(color: selectedStatus == 'mollusc' ? Colors.white : Colors.black
                    , fontWeight: FontWeight.w500)),
                    onSelected: (b) {
                      ref.read(speciesTypeFilterProvider.notifier).state = 'mollusc';
                    },
                    selectedColor: Colors.blue,
                    checkmarkColor: Colors.white,
                    selected: selectedStatus == 'mollusc'),
              ],
            ),
            speciesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (speciesList) {
                if (speciesList.isEmpty) {
                  return const Center(child: Text("Tidak ada spesies yang cocok."));
                }
                return StaticGrid(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                    gap: 20,
                    children: [
                      for(var species in speciesList)
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => SpeciesDetails(species: species,
                                      station: 1,
                                      isFavoriteSpecies: favoriteSpeciesList.any((e) => const MapEquality().equals(e.toMap(), species.toMap())) ? true : false,
                                      showBottomNav: false))
                              );
                            },
                            child: speciesCard2(ref, context, species)
                        )
                    ]
                );
              },
            )
          ],
        ),
      ),
    );
  }

}