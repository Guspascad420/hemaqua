import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/cards/species_card3.dart';
import 'package:hematologi/hematologi/hematologi_parameters.dart';
import 'package:hematologi/models/species.dart';

import '../provider/providers.dart';

class HematologiSpeciesCart extends ConsumerWidget {
  const HematologiSpeciesCart({super.key, required this.station});

  final int station;

  void _showSnackBar(BuildContext context, String textContent, MaterialColor backgroundColor) {
    SnackBar snackBar = SnackBar(
      content: Text(textContent),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _removeSpeciesFromCart(BuildContext context, Species species, WidgetRef ref) {
    ref.read(databaseServiceProvider).removeSpeciesFromHematologiCart(species,
        ref.read(authStateProvider).asData!.value!.uid);
    _showSnackBar(context, 'Berhasil menghapus spesies', Colors.blue);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Species> speciesList = ref.watch(hematologiCartListProvider);

    return Scaffold(
      bottomNavigationBar: speciesList.isEmpty ? null : GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HematologiParameters(
                    species: speciesList[0], station: station
                ))
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            color: Colors.blue,
            child: Text('Selanjutnya', textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 20, color: Colors.white)),
          )
      ),
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
        title: Text('Keranjang',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              speciesList.isEmpty
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 120),
                      Image.asset('images/group_42310.png', scale: 2.5,),
                      Text('Keranjang kosong',
                          style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                      Text('Keranjang Anda kosong. Mulailah menambahkan data!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          )),
                    ],
                  )
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: speciesCard3(context, ref, speciesList[0], station,
                          MediaQuery.of(context).size.width * 0.3, _removeSpeciesFromCart)
                  )
            ],
          )
      )
    );
  }

}