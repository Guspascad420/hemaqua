import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hematologi/hematologi_results.dart';
import 'package:hematologi/hemosit/hemosit_results.dart';
import 'package:hematologi/models/species.dart';

import '../database/database_service.dart';

class GalleryPage extends StatefulWidget {
  final List<Map<String, dynamic>> calculationResults;
  final void Function(Map<String, dynamic>) removeCalculationResult;
  final String category;

  const GalleryPage({super.key, required this.category, required this.calculationResults, required this.removeCalculationResult});


  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  DatabaseService service = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _calculationResults = [];

  Future<void> _showDeleteDialog(BuildContext context, Map<String, dynamic> species) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
            "Apakah kamu yakin untuk menghapus item ini?",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w500
            )
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel action
              child: Text(
                  "Batal",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  )
                ),
            ),
            TextButton(
              onPressed: () {
                widget.removeCalculationResult(species);
                setState(() {
                  _calculationResults.remove(species);
                });
                service.removeCalculationResult(species, auth.currentUser!.uid);
                Navigator.of(context).pop();
              },
              child: Text("Hapus", style: GoogleFonts.poppins(fontSize: 15,
                  fontWeight: FontWeight.w500, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calculationResults = widget.calculationResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: widget.calculationResults.isEmpty
          ? null : AppBar(
            backgroundColor: const Color(0xFFEFF6FF),
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
            title: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(
                  hintText: "Cari...",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 15,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
        ),
      body: _calculationResults.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/dead_fish.png', scale: 2.3),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text('Tidak ada riwayat yang tersedia',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 21,
                            fontWeight: FontWeight.bold
                        ))
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _calculationResults.length,
              itemBuilder: (context, index) {
                Species species = Species.fromCalculationResultMap(widget.calculationResults[index]);
                var calculationResults = widget.calculationResults[index]['type'] == 'fish'
                 ? {
                    'Eritrosit': (widget.calculationResults[index]['eritrosit'] as num).toDouble(),
                    'Leukosit': (widget.calculationResults[index]['leukosit'] as num).toDouble(),
                    "Hematokrit": (widget.calculationResults[index]['hematokrit'] as num).toDouble(),
                    "Hemoglobin": (widget.calculationResults[index]['hemoglobin'] as num).toDouble(),
                    "Mikronuklei": (widget.calculationResults[index]['mikronuklei'] as num).toDouble(),
                    "Limfosit": (widget.calculationResults[index]['limfosit'] as num).toDouble(),
                    "Monosit": (widget.calculationResults[index]['monosit'] as num).toDouble(),
                    "Neutrofil": (widget.calculationResults[index]['neutrofil'] as num).toDouble()
                   }
                 : {
                    'THC': (widget.calculationResults[index]['thc'] as num).toDouble(),
                    'Hyalin': (widget.calculationResults[index]['hyalin'] as num).toDouble(),
                    'Granular': (widget.calculationResults[index]['granular'] as num).toDouble(),
                    'Semi Granular': (widget.calculationResults[index]['semi_granular'] as num).toDouble(),
                   };
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                      widget.calculationResults[index]['type'] == 'fish'
                          ? HematologiResults(
                              calculationResults: calculationResults, species: species,
                              station: widget.calculationResults[index]['station'],
                              showBottomNav: false
                            )
                          : HemositResults(
                              calculationResults: calculationResults,
                              species: species,
                              station: widget.calculationResults[index]['station'],
                              showBottomNav: false
                            )
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          child: Image.network(widget.calculationResults[index]['image_url'], scale: 2.5),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.calculationResults[index]['name'],
                                    style: GoogleFonts.poppins(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                    )),
                                const SizedBox(height: 4),
                                Text(widget.calculationResults[index]['latin_name'],
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500
                                    ),
                                    softWrap: true,  // Ensure wrapping is enabled
                                    maxLines: 2,     // Optional: Limit to 2 lines
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.blue, size: 30),
                                        const SizedBox(width: 4),
                                        Text("Stasiun ${widget.calculationResults[index]['station']}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                            )),
                                      ],
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF4FBFF),
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            _showDeleteDialog(context, widget.calculationResults[index]);
                                          },
                                          icon: const Icon(Icons.delete_outline, color: Colors.red,)
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                  )
                );
              },
            ),
    );
  }

}