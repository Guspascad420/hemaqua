import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/cards/fish_card3.dart';
import 'package:hematologi/hematologi/hematologi_parameters.dart';
import 'package:hematologi/models/species.dart';

class HematologiSpeciesCart extends StatefulWidget {
  final List<Species> speciesInCart;
  final void Function(Species) removeSpeciesFromCart;

  const HematologiSpeciesCart({super.key, required this.speciesInCart,
    required this.removeSpeciesFromCart});

  @override
  State<HematologiSpeciesCart> createState() => _HematologiSpeciesCartState();
}

class _HematologiSpeciesCartState extends State<HematologiSpeciesCart> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.speciesInCart.isEmpty ? null : GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HematologiParameters())
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            color: Colors.blue,
            child: Text('Selanjutnya', textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 20, color: Colors.white)),
          )
      ),
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
        title: Text('Keranjang',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              widget.speciesInCart.isEmpty ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: fishCard3(widget.speciesInCart[0], widget.removeSpeciesFromCart)
                  )
            ],
          )
      )
    );
  }

}