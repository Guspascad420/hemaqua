import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hemosit/hemosit_species_cart.dart';
import 'package:hematologi/static_grid.dart';
import 'package:hematologi/cards/fish_card2.dart';

import '../database/database_service.dart';
import '../models/species.dart';


class HemositSpeciesList extends StatefulWidget {

  const HemositSpeciesList({super.key});

  @override
  State<HemositSpeciesList> createState() => _HemositSpeciesListState();
}

class _HemositSpeciesListState extends State<HemositSpeciesList> {

  DatabaseService service = DatabaseService();
  late Future<List<Species>> futureMolluscslist;
  FirebaseAuth auth = FirebaseAuth.instance;

  List<Species> _speciesInCart = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    futureMolluscslist = service.retrieveMolluscs();
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
        service.addSpeciesToCart(species, auth.currentUser!.uid, 'hemosit_species_in_cart');
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
    setState(() {
      _speciesInCart.addAll(userData["hemosit_species_in_cart"]);
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
                      MaterialPageRoute(builder: (context) => HemositSpeciesCart(speciesInCart: _speciesInCart,
                        removeSpeciesFromCart: _removeSpeciesFromCart,))
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
          future: futureMolluscslist,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Mohon cek koneksi internet kamu');
            }
            var molluscsList = snapshot.data!;
            return SingleChildScrollView(
                child: StaticGrid(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    gap: 20,
                    children: [
                      for(var molluscs in molluscsList)
                        speciesCard(context, molluscs, _addSpeciesToCart),
                    ]
                )
            );
          }
      )
    );
  }

}