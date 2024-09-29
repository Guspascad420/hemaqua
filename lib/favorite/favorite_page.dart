import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/static_grid.dart';

import '../cards/fish_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FBFF),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.blue)
        ),
        title: Text('Favorite',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
        child: StaticGrid(
            gap: 20,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              fishCard('images/clown_fish.png', 'Fish Name', 'Species Name'),
              fishCard('images/betta_transparent.png', 'Fish Name', 'Species Name'),
              fishCard('images/purple_squid.png', 'Mollusca Name', 'Species Name'),
              fishCard('images/conch_shell.png', 'Mollusca Name', 'Species Name'),
            ]
        ),
      )
    );
  }

}