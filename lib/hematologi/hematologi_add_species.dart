
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_add_species_ui.dart';


class HematologiAddSpecies extends StatelessWidget {
  final int station;

  const HematologiAddSpecies({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
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
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(left: 20),
              child: IconButton(
                padding: const EdgeInsets.only(left: 7),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
              )
          ),
          backgroundColor: Colors.transparent,
          title: Text('Stasiun $station',
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(height: double.infinity, color: Colors.blue),
            ReusableAddSpeciesUI(station: station, type: "fish")
          ],
        )
    );
  }
}
