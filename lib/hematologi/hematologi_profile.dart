import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hematologi/hematologi_add_species.dart';
import 'package:hematologi/station_selection.dart';

class HematologiProfile extends StatelessWidget {
  const HematologiProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StationSelection(nextWidget: HematologiAddSpecies()))
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
            child: Image.asset('images/image_782.png', scale: 2.3),
          ),
          const SizedBox(height: 20),
          Text('Profil Hematologi',
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500
                ))
          )
        ],
      ),
    );
  }

}