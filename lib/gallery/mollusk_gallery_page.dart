import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/cards/species_card.dart';
import '../database/database_service.dart';
import '../models/species.dart';
import '../static_grid.dart';

class MolluskGalleryPage extends StatefulWidget {
  const MolluskGalleryPage({super.key});

  @override
  State<MolluskGalleryPage> createState() => _MolluskGalleryPageState();
}

class _MolluskGalleryPageState extends State<MolluskGalleryPage>  {
  DatabaseService service = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Daftar Spesies',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
        body: StreamBuilder<List<Species>>(
            stream: service.retrieveMolluscs(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text('Mohon cek koneksi internet kamu');
              }
              var molluskList = snapshot.data!;
              return SingleChildScrollView(
                  child: StaticGrid(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      gap: 20,
                      children: [
                        for(var mollusk in molluskList)
                          speciesCard(context, mollusk, false),
                      ]
                  )
              );
            }
        )
    );
  }

}