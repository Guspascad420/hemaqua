import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/add_data.dart';
import 'package:hematologi/bottom_nav_bar.dart';
import 'package:hematologi/cards/empty_fish_card.dart';
import 'package:hematologi/database/database_service.dart';
import 'package:hematologi/favorite/favorite_page.dart';
import 'package:hematologi/history/history_category.dart';
import 'package:hematologi/models/species.dart';

import '../cards/species_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseService service = DatabaseService();
  Map<String, dynamic> _user = {};
  bool _isLoading = true;
  late Future<Map<String, dynamic>> futureUserData;
  List<Map<String, dynamic>> _calculationResults = [];
  List<Map<String, dynamic>> _favoriteSpecies = [];

  FirebaseAuth auth = FirebaseAuth.instance;

  void _removeCalculationResult(Map<String, dynamic> species) {
    setState(() {
      _calculationResults.remove(species);
    });
  }

  void _removeSpeciesFromFavorite(Map<String, dynamic> species) {
    setState(() {
      _favoriteSpecies = _favoriteSpecies.where((value) => value['name'] != species['name']).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
    futureUserData = service.retrieveUserData(auth.currentUser!.uid);
    futureUserData.then((value) => {
      setState(() {
        _user = value;
        _calculationResults = (_user['calculation_results'] as List)
            .map((species) => species as Map<String, dynamic>)
            .toList();
        _favoriteSpecies = (_user['favorite_species'] as List)
            .map((species) => species as Map<String, dynamic>)
            .toList();
        _isLoading = false;
      })
    });
  }

  Future<void> _loadImage() async {
    try {
      // Get the download URL
      String downloadURL = await FirebaseStorage.instance
          .ref('fishes/mujair.png')
          .getDownloadURL();

      debugPrint('Download URL : $downloadURL');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 0, user: _isLoading ? {} : _user,),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: futureUserData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text('Halo, ${snapshot.data!["username"]}!',
                                  style: GoogleFonts.poppins(
                                      fontSize: 21,
                                      color: const Color(0xFF3B82F6),
                                      fontWeight: FontWeight.bold
                                  ));
                            }
                            return Text('Halo, !',
                                style: GoogleFonts.poppins(
                                    fontSize: 21,
                                    color: const Color(0xFF3B82F6),
                                    fontWeight: FontWeight.bold
                                ));
                          }
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: -60,
                      top: -60,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -110,
                      bottom: -40,
                      child: Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 230,
                                padding: const EdgeInsets.only(left: 25, top: 35),
                                child: Text('Mulai Tambahkan Data Hematologi dan Hemosit Anda, dan juga ukur kualitas air!',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
                                    ))
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 25, top: 10),
                              child: FilledButton(
                                  onPressed: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => const AddData())
                                    );
                                  },
                                  style: FilledButton.styleFrom(
                                      backgroundColor: const Color(0xFF89B4F9),
                                      shape: const RoundedRectangleBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(10)),
                                          side: BorderSide(
                                              color: Color(0xFF97BDFA),
                                              width: 2,
                                              style: BorderStyle.solid
                                          )
                                      )
                                  ),
                                  child: Text('Tambah Data',
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ))
                              ),
                            )
                          ],
                        ),
                        Image.asset('images/sun_rise.png', width: MediaQuery.of(context).size.width * 0.3)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text('Favorit',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF3B82F6),
                              fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FavoritePage(favoriteSpecies:
                                  _favoriteSpecies, removeSpeciesFromFavorite: _removeSpeciesFromFavorite))
                              );
                            },
                            child: Text('Lihat semua',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: const Color(0xFF3B82F6),
                                ))
                        )
                    )
                  ],
                ),
                _favoriteSpecies.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          speciesCard(context, Species.fromMap(_favoriteSpecies[0]), _removeSpeciesFromFavorite),
                          const SizedBox(width: 15),
                          // fishCard('images/betta_transparent.png', 'Fish Name', 'Species Name')
                          _favoriteSpecies.length > 1
                              ? speciesCard(context, Species.fromMap(_favoriteSpecies[1]), _removeSpeciesFromFavorite)
                              : SizedBox()
                        ],
                    )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          emptyFishCard(),
                          const SizedBox(width: 15),
                          emptyFishCard()
                        ],
                      )
              ],
            ),
              // FutureBuilder(
              //     future: futureUserData,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Container(
              //                   margin: const EdgeInsets.only(bottom: 10),
              //                   child: Text('Favorit',
              //                     style: GoogleFonts.poppins(
              //                       fontSize: 18,
              //                       color: const Color(0xFF3B82F6),
              //                       fontWeight: FontWeight.bold
              //                       )),
              //                 ),
              //                 Container(
              //                   margin: const EdgeInsets.only(bottom: 10),
              //                   child: TextButton(
              //                       onPressed: () {
              //                         Navigator.of(context).push(MaterialPageRoute(
              //                             builder: (context) => FavoritePage(favoriteSpecies:
              //                             snapshot.data!['favorite_species'].cast<Map<String, dynamic>>()))
              //                         );
              //                       },
              //                       child: Text('Lihat semua',
              //                           style: GoogleFonts.poppins(
              //                             fontSize: 18,
              //                             color: const Color(0xFF3B82F6),
              //                           ))
              //                   )
              //                 )
              //               ],
              //             ),
              //             (snapshot.data!['favorite_species'].cast<Map<String, dynamic>>()).isNotEmpty
              //                 ? Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       fishCard(context, Species(name: snapshot.data!['favorite_species'][0]["name"],
              //                           latin_name: snapshot.data!['favorite_species'][0]["latin_name"],
              //                           type: snapshot.data!['favorite_species'][0]["type"],
              //                           image_url: snapshot.data!['favorite_species'][0]["image_url"],
              //                           description: snapshot.data!['favorite_species'][0]["description"])),
              //                       const SizedBox(width: 15),
              //                       // fishCard('images/betta_transparent.png', 'Fish Name', 'Species Name')
              //                       (snapshot.data!['favorite_species'].cast<Map<String, dynamic>>()).length > 1
              //                         ? fishCard(context, Species(name: snapshot.data!['favorite_species'][1]["name"],
              //                             latin_name: snapshot.data!['favorite_species'][1]["latin_name"],
              //                             type: snapshot.data!['favorite_species'][1]["type"],
              //                             image_url: snapshot.data!['favorite_species'][1]["image_url"],
              //                             description: snapshot.data!['favorite_species'][1]["description"]))
              //                         : SizedBox()
              //                     ],
              //                   )
              //                 : Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       emptyFishCard(),
              //                       const SizedBox(width: 15),
              //                       emptyFishCard()
              //                     ],
              //                   )
              //           ],
              //         );
              //       }
              //       return const Center(
              //         child: CircularProgressIndicator(color: Colors.blue),
              //       );
              //     }
              // ),
              const SizedBox(height: 15),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Riwayat',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: const Color(0xFF3B82F6),
                                  fontWeight: FontWeight.bold
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HistoryCategory(calculationResults: _calculationResults,
                                        removeCalculationResult: _removeCalculationResult))
                                );
                              },
                              child: Text('Lihat semua',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: const Color(0xFF3B82F6),
                                  ))
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset('images/image_30.png', scale: 2.3),
                              Text('Ikan',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500
                                  )),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Image.asset('images/image_25.png', scale: 2.3),
                              Text('Moluska',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500
                                  )),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Image.asset('images/flowing_water.png', scale: 2.3),
                              Text('Air',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 15),
            ],
          ),
        )
      )
    );
  }
}