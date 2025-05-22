import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/gallery/gallery_category.dart';

class GuestHomePage extends StatelessWidget {
  const GuestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 70, bottom: 20),
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
                      Image.asset('images/sun_rise.png', scale: 3.5)
                    ],
                  ),
                ],
              ),
            ),
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
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const GalleryCategory())
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
                            Image.asset('images/image_32.png', scale: 2.3),
                            Text('Darah',
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
          ],
        ),
      )
    );
  }

}