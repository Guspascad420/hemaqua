import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hemosit/hemosit_add_species.dart';
import 'package:hematologi/hemosit/hemosit_species_list.dart';
import 'package:hematologi/station_selection.dart';

class HemositProfile extends StatelessWidget {
  const HemositProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StationSelection(nextWidget: (int station) => HemositSpeciesList(station: station,)))
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  )
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text('Next',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ))
              )
          )
      ),
      body: Column(
        children: [
          const SizedBox(height: 80),
          Center(
            child: Image.asset('images/group_42312.png', scale: 2.3),
          ),
          const SizedBox(height: 20),
          Text('Profil Hemosit',
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text("Analisis komposisi darah pada moluska untuk pemantauan"
                  " sistem kekebalan moluska dan kualitas lingkungan perairan",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500
                  ))
          )
        ],
      )
    );
  }

}