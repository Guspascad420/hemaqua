import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        centerTitle: true,
        title: Text('Riwayat',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, top: 30, bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                color: Color(0xFF83B0F9),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child: const Icon(Icons.history, color: Colors.white, size: 30),
                            ),
                            Text('Riwayat',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ))
                          ],
                        )
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 30),
                        child: Text('Lihat input riwayat dan detail riwayat Anda dengan mengklik baris di bawah ini',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ))
                      )
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
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: const BoxDecoration(
                          color: Color(0xFFC6DBFC),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title',
                              style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500
                              )),
                          Text('Description',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ))
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color(0xFFECF3FE),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.blue,)
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

}