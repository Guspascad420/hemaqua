import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/history/history_page.dart';
import 'package:hematologi/history/wq_gallery_page.dart';
import 'package:hematologi/static_grid.dart';

class HistoryCategory extends StatelessWidget {
  final List<Map<String, dynamic>> calculationResults;
  final void Function(Map<String, dynamic>) removeCalculationResult;

  const HistoryCategory({super.key, required this.calculationResults, required this.removeCalculationResult});

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
        title: Text('Pilih Kategori',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
        child: StaticGrid(
            padding: const EdgeInsets.all(20),
            gap: 35,
            children: [
              GestureDetector(
                onTap: () {
                  List<Map<String, dynamic>> fishCalculationResults = calculationResults.where((species) => species['type'] == 'fish').toList();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HistoryPage(calculationResults: fishCalculationResults,
                          category: 'fish', removeCalculationResult: removeCalculationResult))
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('images/fish3.png', scale: 2.3),
                      const SizedBox(height: 10,),
                      Text('Hematologi',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  List<Map<String, dynamic>> molluskCalculationResults = calculationResults.where((species) => species['type'] == 'molluscs').toList();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HistoryPage(
                          calculationResults: molluskCalculationResults,
                          category: 'molluscs',
                          removeCalculationResult: removeCalculationResult
                      ))
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(

                    children: [
                      Image.asset('images/shell.png', scale: 2.3),
                      const SizedBox(height: 10),
                      Text('Hemosit',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ),
              GestureDetector(
                onTap: () {
                  List<Map<String, dynamic>> waterCalculationResult = calculationResults.where((species) => species['type'] == 'water quality').toList();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WQGalleryPage(calculationResult: waterCalculationResult))
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('images/testing_wq2.png', scale: 1.7),
                      const SizedBox(height: 10),
                      Text('Kualitas air',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              )
            ]
        )
      ),
    );
  }

}