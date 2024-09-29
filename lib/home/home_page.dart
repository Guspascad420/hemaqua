import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/bottom_nav_bar.dart';
import 'package:hematologi/documentary_card.dart';
import 'package:hematologi/favorite/favorite_page.dart';
import 'package:hematologi/cards/fish_card.dart';
import 'package:hematologi/home/history_page.dart';
import 'package:hematologi/gallery/gallery_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    try {
      // Get the download URL
      String downloadURL = await FirebaseStorage.instance
          .ref('fishes/mujair.png') // Replace with your image path in storage
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
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 0),
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
                      Text('Halo, User!',
                          style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: const Color(0xFF3B82F6),
                              fontWeight: FontWeight.bold
                          )),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue,),
                          Text('Lokasi',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                              ))
                        ],
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const HistoryPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: const Color(0xFFF2F2F2))
                        ),
                        child: const Icon(Icons.history, color: Colors.blue, size: 30),
                      )
                  )
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
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => const HomePage()), (route) => false
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
                        Image.asset('images/betta_fish.png')
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Favorit',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: const Color(0xFF3B82F6),
                          fontWeight: FontWeight.bold
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FavoritePage())
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  fishCard('images/clown_fish.png', 'Fish Name', 'Species Name'),
                  const SizedBox(width: 15),
                  fishCard('images/betta_transparent.png', 'Fish Name', 'Species Name')
                ],
              ),
              const SizedBox(height: 20),
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
                          Text('Galeri',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: const Color(0xFF3B82F6),
                                  fontWeight: FontWeight.bold
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const GalleryCategory())
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
                              Image.asset('images/rectangle_3.png', scale: 2.3),
                              Text('Halfmoon',
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
                              Image.asset('images/rectangle_15.png', scale: 2.3),
                              Text('Crown Tail',
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
                              Image.asset('images/rectangle_20.png', scale: 2.3),
                              Text('Sarawak',
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
              Text('Tentang Kami',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: const Color(0xFF3B82F6),
                      fontWeight: FontWeight.bold
                  )),
              const SizedBox(height: 15),
              documentaryCard('images/sampling-water.png', 'Aplikasi Kami',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Nisl quam vulputate enim ultricies maecenas sed...'),
            ],
          ),
        )
      )
    );
  }
}