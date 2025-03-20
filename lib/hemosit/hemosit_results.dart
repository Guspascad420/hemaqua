import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/calculations/calculation_result.dart';
import 'package:hematologi/calculations/checker/hemosit_checker.dart';

import '../data_saved.dart';
import '../database/database_service.dart';
import '../models/species.dart';
import '../parameter_box.dart';

class HemositResults extends StatelessWidget {
  final Map<String, double> calculationResults;
  final Species species;
  final bool showBottomNav;
  final int station;

  const HemositResults({super.key, required this.calculationResults,
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
              'type': 'molluscs',
              'thc': calculationResults['THC'],
              'hyalin': calculationResults['Hyalin'],
              'granular': calculationResults['Granular'],
              'semi_granular': calculationResults['Semi Granular'],
            };
            service.addCalculationResult(calculationResult, auth.currentUser!.uid);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DataSaved()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            color: Colors.blue,
            child: Text('Selanjutnya',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
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
            )),
        title: Text('Hasil',
            style: GoogleFonts.poppins(
                fontSize: 21, color: Colors.blue, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          if (calculationResults['THC']! != 0.0) parameterBox('THC', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CalculationResult(
                    result: calculationResults['THC']!,
                    resultStatus: species.klass == 'bivalvia'
                        ? HemositChecker.checkBivalviaCalculation(
                            species.latin_name.split(' ')[0],
                            'THC',
                            calculationResults['THC']!
                        )
                        : HemositChecker.checkTHCCalculation(
                            species.latin_name.split(' ')[0],
                            calculationResults['THC']!
                        )
                )
            ));
          }),
          if (calculationResults['Hyalin']! != 0.0) parameterBox('Hyalin', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CalculationResult(
                    result: calculationResults['Hyalin']!,
                    resultStatus: species.klass == 'bivalvia'
                        ? HemositChecker.checkBivalviaCalculation(
                            species.latin_name.split(' ')[0],
                            'Hyalin',
                            calculationResults['Hyalin']!
                    )
                        : HemositChecker.checkHyalunositCalculation(
                            species.latin_name.split(' ')[0],
                            calculationResults['Hyalin']!
                          )
                )
                  )
            );
          }),
          if (calculationResults['Granular']! != 0.0) parameterBox('Granular', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CalculationResult(
                    result: calculationResults['Granular']!,
                    resultStatus: species.klass == 'bivalvia'
                      ? HemositChecker.checkBivalviaCalculation(
                         species.latin_name.split(' ')[0],
                         'Granular',
                         calculationResults['Granular']!
                      )
                        : HemositChecker.checkGranularCalculation(
                            species.latin_name.split(' ')[0],
                            calculationResults['Granular']!
                        )
                )));
          }),
          if (calculationResults['Semi Granular']! != 0.0) parameterBox('Semi Granular', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CalculationResult(
                    result: calculationResults['Semi Granular']!,
                    resultStatus: species.klass == 'bivalvia'
                        ? HemositChecker.checkBivalviaCalculation(
                            species.latin_name.split(' ')[0],
                            'Semi Granular',
                            calculationResults['Semi Granular']!
                        )
                        : HemositChecker.checkGranularCalculation(
                            species.latin_name.split(' ')[0],
                            calculationResults['Semi Granular']!
                        )
                )
            ));
          }),
        ],
      ),
    );
  }
}
