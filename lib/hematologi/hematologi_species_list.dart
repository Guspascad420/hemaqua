import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hematologi/hematologi_add_species.dart';
import 'package:hematologi/hematologi/hematologi_species_cart.dart';
import 'package:hematologi/static_grid.dart';
import '../cards/species_card2.dart';
import '../database/database_service.dart';
import '../models/species.dart';
import 'package:collection/collection.dart';

class HematologiSpeciesList extends StatefulWidget {
  final int station;

  const HematologiSpeciesList({super.key, required this.station});

  @override
  State<HematologiSpeciesList> createState() => _HematologiSpeciesListState();
}

class _HematologiSpeciesListState extends State<HematologiSpeciesList> {

  DatabaseService service = DatabaseService();
  late Future<List<Species>> futureFishList;
  FirebaseAuth auth = FirebaseAuth.instance;

  List<Species> _speciesInCart = [];
  List<Species> _favoriteSpeciesList = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    futureFishList = service.retrieveFishes();
  }

  void _showSnackBar(BuildContext context, String textContent, MaterialColor backgroundColor) {
    SnackBar snackBar = SnackBar(
      content: Text(textContent),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _addSpeciesToCart(Species species) {
    setState(() {
      if (_speciesInCart.isEmpty) {
        service.addSpeciesToCart(species, auth.currentUser!.uid, 'hematologi_species_in_cart');
        _speciesInCart.add(species);
        _showSnackBar(context, 'Berhasil menambahkan spesies', Colors.blue);
      } else {
        _showSnackBar(context, 'Ikan sudah ditambahkan', Colors.red);
      }
    });
  }

  void _removeSpeciesFromCart(Species species) {
    setState(() {
      service.removeSpeciesFromCart(species, auth.currentUser!.uid, 'hematologi_species_in_cart');
      _speciesInCart.remove(species);
    });
    _showSnackBar(context, 'Berhasil menghapus spesies', Colors.blue);
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic> userData = await service.retrieveUserData(auth.currentUser!.uid);
    List<Map<String, dynamic>> favoriteSpeciesData = (userData["favorite_species"] as List).map((e) => Map<String, dynamic>.from(e)).toList();
    print(favoriteSpeciesData[0]);
    setState(() {
      _favoriteSpeciesList.addAll(favoriteSpeciesData.map((e) => Species.fromMap(e)));
      _speciesInCart.add(Species.fromMap(userData["hematologi_species_in_cart"][0]));
    });
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
                      MaterialPageRoute(builder: (context) => HematologiSpeciesCart(speciesInCart: _speciesInCart,
                        removeSpeciesFromCart: _removeSpeciesFromCart, station: widget.station))
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
            onTap: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HematologiAddSpecies(station: widget.station))
              );
              setState(() {
                _loadUserData();
                futureFishList = service.retrieveFishes();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 22),
              color: Colors.blue,
              child: Text('Tambah spesies baru', textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.white)),
            )
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
          fishList = fishList.where((fish) => fish.stations!.contains(widget.station))
              .toList();
          return SingleChildScrollView(
            child: StaticGrid(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                gap: 20,
                children: [
                  for(var fish in fishList)
                    speciesCard2(context, fish, widget.station,
                        _favoriteSpeciesList.any((e) => const MapEquality().equals(e.toMap(), fish.toMap())) ? true : false, _addSpeciesToCart),
                ]
            )
          );
        }
      )
    );
  }

}