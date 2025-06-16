import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/calculations/calculation_result.dart';
import 'package:hematologi/calculations/checker/hematologi_checker.dart';
import 'package:hematologi/data_saved.dart';
import 'package:hematologi/database/database_service.dart';

import '../models/species.dart';
import '../parameter_box.dart';

class HematologiResults extends StatelessWidget {
  final int station;
  final Species species;
  final bool showBottomNav;
  final Map<String, dynamic> calculationResults;

  const HematologiResults({super.key, required this.calculationResults,
    required this.species, required this.station, required this.showBottomNav});

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      bottomNavigationBar: !showBottomNav ? null : GestureDetector(
          onTap: () {
            var calculationResult = {
              'name': species.name,
              'latin_name': species.latin_name,
              'image_url': species.image_url,
              'station': station,
              'type': 'fish',
              'eritrosit': calculationResults['Eritrosit'],
              'leukosit': calculationResults['Leukosit'],
              'hematokrit': calculationResults['Hematokrit'],
              'hemoglobin': calculationResults['Hemoglobin'],
              'mikronuklei': calculationResults['Mikronuklei'],
              'limfosit': calculationResults['Limfosit'],
              'monosit': calculationResults['Monosit'],
              'neutrofil': calculationResults['Neutrofil']
            };
            service.addCalculationResult(calculationResult, auth.currentUser!.uid);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DataSaved()),
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
        title: Text('Hasil',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          if (calculationResults['Eritrosit']! != 0.0) parameterBox('Eritrosit', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Eritrosit']!,
                resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                    'Eritrosit', calculationResults['Eritrosit']!)
                )
              ),
            );
          }),
          if (calculationResults['Leukosit']! != 0.0) parameterBox('Leukosit', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Leukosit']!,
                  resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                  'Leukosit', calculationResults['Leukosit']!)
                )
              ),
            );
          }),
          if (calculationResults['Hematokrit']! != 0.0) parameterBox('Hematokrit', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Hematokrit']!,
                  resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                      'Hematokrit', calculationResults['Hematokrit']!)
                )
              ),
            );
          }),
          if (calculationResults['Hemoglobin']! != 0.0)  parameterBox('Hemoglobin', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Hemoglobin']!,
                  resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                      'Hemoglobin', calculationResults['Hemoglobin']!)
                )
              ),
            );
          }),
          if (calculationResults['Mikronuklei']! != 0.0) parameterBox('Mikronuklei', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Mikronuklei']!,
                  resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                      'Mikronuklei', calculationResults['Mikronuklei']!)
                )
              ),
            );
          }),
          if (calculationResults['Limfosit']! != 0.0) parameterBox('Limfosit', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Limfosit']!,
                  resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                      'Limfosit', calculationResults['Limfosit']!)
              )
              ),
            );
          }),
          if (calculationResults['Monosit']! != 0.0) parameterBox('Monosit', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Monosit']!,
                  resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                      'Monosit', calculationResults['Monosit']!)
              )
              ),
            );
          }),
          if (calculationResults['Neutrofil']! != 0.0) parameterBox('Neutrofil', () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CalculationResult(result: calculationResults['Neutrofil']!,
                  resultStatus: HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
                      'Neutrofil', calculationResults['Neutrofil']!)
              )
              ),
            );
          }),
        ],
      ),
    );
  }

}