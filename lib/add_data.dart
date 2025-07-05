import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/bottom_nav_bar.dart';
import 'package:hematologi/hematologi/hematologi_profile.dart';
import 'package:hematologi/hemosit/hemosit_profile.dart';
import 'package:hematologi/water%20quality/wq_profile.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FBFF),
        centerTitle: true,
        leading: const SizedBox(),
        title: Text('Tambah Data',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 1),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HematologiProfile()),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Image.asset('images/fish3.png', scale: 3),
                  const SizedBox(width: 15),
                  Text('Data Hematologi',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
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
                MaterialPageRoute(builder: (context) => const HemositProfile()),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  Image.asset('images/shell.png', scale: 3),
                  const SizedBox(width: 15),
                  Text('Data Hemosit',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
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
                  MaterialPageRoute(builder: (context) => const WaterQualityProfile()),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Image.asset('images/testing_wq2.png', scale: 2),
                    const SizedBox(width: 15),
                    Text('Kualitas Air',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600
                        ))
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

}