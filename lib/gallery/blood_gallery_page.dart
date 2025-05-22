import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../database/database_service.dart';
import '../static_grid.dart';

class BloodGalleryPage extends StatefulWidget {
  const BloodGalleryPage({super.key});

  @override
  State<BloodGalleryPage> createState() => _BloodGalleryPageState();
}

class _BloodGalleryPageState extends State<BloodGalleryPage>  {
  DatabaseService service = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  late Future<List<Map<String, dynamic>>> futureBloodList;

  @override
  void initState() {
    super.initState();
    futureBloodList = service.retrieveBloods();
  }

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
        body: FutureBuilder(
            future: futureBloodList,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text('Mohon cek koneksi internet kamu');
              }
              var bloodsList = snapshot.data!;
              return SingleChildScrollView(
                  child: StaticGrid(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      gap: 20,
                      children: [
                        for(var blood in bloodsList)
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            width: 175,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Image.network(blood['image_url'], scale: 1.8),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    margin: const EdgeInsets.only(left: 15, bottom: 15),
                                    child: Text(blood['name'],
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: const Color(0xFF3B82F6),
                                            fontWeight: FontWeight.w500
                                        ))
                                )
                              ],
                            ),
                          )
                      ]
                  )
              );
            }
        )
    );
  }

}