import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/cards/fish_card2.dart';
import 'package:hematologi/gallery/gallery_page.dart';
import 'package:hematologi/static_grid.dart';

class GalleryCategory extends StatelessWidget {
  const GalleryCategory({super.key});

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
        title: Text('Pilih Kategori',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
        child: StaticGrid(
            padding: const EdgeInsets.all(20),
            gap: 35,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const GalleryPage(category: 'fish'))
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Image.asset('images/fish.png', scale: 2.3),
                      const SizedBox(height: 5,),
                      Text('Ikan',
                          style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const GalleryPage(category: 'molluscs'))
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Image.asset('images/squid.png', scale: 5),
                      const SizedBox(height: 5,),
                      Text('Moluska',
                          style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                    ],
                  ),
                )
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const GalleryPage(category: 'blood'))
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Image.asset('images/water.png', scale: 2.5),
                      const SizedBox(height: 5,),
                      Text('Darah',
                          style: GoogleFonts.poppins(
                              fontSize: 21,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                    ],
                  ),
                )
              )
            ]
        )
      ),
    );
  }

}