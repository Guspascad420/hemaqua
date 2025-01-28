import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/species.dart';

Widget fishCard3(Species species, void Function(Species) removeSpeciesFromCart) {
  return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    child: Dismissible(
        key: Key(species.image_url),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          removeSpeciesFromCart(species);
        },
        background: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFF4FBFF),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Image.network(species.image_url, scale: 2.5),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(species.name,
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      )),
                  Text(species.latin_name,
                      style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue, size: 30,),
                      const SizedBox(width: 4),
                      Text('Location',
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          )),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
    )
  );
}