import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/cards/blood_card.dart';
import 'package:hematologi/models/species.dart';

import '../cards/fish_card2.dart';
import '../database/database_service.dart';
import '../static_grid.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key, required this.category});

  final String category;

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  String searchText = '';
  DatabaseService service = DatabaseService();
  late Future<List<Species>> futureSpeciesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.category == 'fish') {
      futureSpeciesList = service.retrieveFishes();
    } else if (widget.category == 'molluscs') {
      futureSpeciesList = service.retrieveMolluscs();
    }
    setState(() {
      if (widget.category == 'fish') {
        searchText = 'Cari Ikan...';
      } else if (widget.category == 'molluscs') {
        searchText = 'Cari Moluska...';
      } else {
        searchText = 'Cari Darah...';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
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
              margin: const EdgeInsets.only(left: 20),
              child: IconButton(
                padding: const EdgeInsets.only(left: 7),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
              )
          ),
          title: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF60A5FA).withOpacity(0.3),
                    blurRadius: 3,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: 310,
            child: Row(
              children: [
                const SizedBox(width: 15),
                const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 30),
                const SizedBox(width: 5),
                Text(searchText,
                    style: GoogleFonts.inter(
                        fontSize: 14, color: const Color(0xFF9CA3AF)))
              ],
            ),
          )
      ),
      body: FutureBuilder(
          future: futureSpeciesList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Mohon cek koneksi internet kamu');
            }
            var speciesList = snapshot.data!;

            return SingleChildScrollView(
                child: StaticGrid(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    gap: 20,
                    children: [
                      for(var species in speciesList)
                        speciesCard(context, species, (Species) {})
                    ]
                )
            );
          }
      )
    );
  }

}