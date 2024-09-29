import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hematologi/hematologi_species_cart.dart';
import 'package:hematologi/static_grid.dart';
import 'package:hematologi/cards/fish_card2.dart';
import '../database/database_service.dart';


class HematologiSpeciesList extends StatefulWidget {
  const HematologiSpeciesList({super.key});

  @override
  State<HematologiSpeciesList> createState() => _HematologiSpeciesListState();
}

class _HematologiSpeciesListState extends State<HematologiSpeciesList> {

  DatabaseService service = DatabaseService();
  late Future<List<Map<String, dynamic>>> futureFishList;

  @override
  void initState() {
    super.initState();
    futureFishList = service.retrieveFishes();
  }


  @override
  Widget build(BuildContext context) {
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
                      MaterialPageRoute(builder: (context) => const HematologiSpeciesCart())
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
      body: FutureBuilder(
        future: futureFishList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text('Mohon cek koneksi internet kamu');
          }
          var fishList = snapshot.data!;
          return SingleChildScrollView(
            child: StaticGrid(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                gap: 20,
                children: [
                  for(var fish in fishList)
                    speciesCard(context, fish),
                ]
            )
          );
        }
      )
    );
  }

}