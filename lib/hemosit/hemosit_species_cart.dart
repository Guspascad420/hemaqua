import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/cards/species_card3.dart';
import 'package:hematologi/hemosit/hemosit_parameters.dart';

import '../models/species.dart';

class HemositSpeciesCart extends StatefulWidget {
  final List<Species> speciesInCart;
  final int station;
  final void Function(Species) removeSpeciesFromCart;

  const HemositSpeciesCart({super.key, required this.speciesInCart,
    required this.removeSpeciesFromCart, required this.station});

  @override
  State<HemositSpeciesCart> createState() => _HemositSpeciesCartState();
}

class _HemositSpeciesCartState extends State<HemositSpeciesCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: widget.speciesInCart.isEmpty ? null : GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HemositParameters(
                      species: widget.speciesInCart[0], station: widget.station
                  ))
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
                widget.speciesInCart.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 120),
                          Image.asset('images/group_42310.png', scale: 2.5,),
                          Text('Keranjang kosong',
                              style: GoogleFonts.poppins(
                                  fontSize: 21,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600
                              )),
                          Text('Keranjang Anda kosong. Mulailah menambahkan data!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              )),
                        ],
                    )
                    : speciesCard3(widget.speciesInCart[0], widget.station, widget.removeSpeciesFromCart)
              ],
            )
        )
    );
  }

}