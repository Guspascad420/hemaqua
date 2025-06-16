import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/calculations/granular_calculation.dart';
import 'package:hematologi/calculations/hyalin_calculation.dart';
import 'package:hematologi/calculations/semi_granular_calculation.dart';
import 'package:hematologi/calculations/thc_calculation.dart';
import 'package:hematologi/hemosit/hemosit_results.dart';
import 'package:hematologi/parameter_box.dart';

import '../models/species.dart';

class HemositParameters extends StatefulWidget {
  final Species species;
  final int station;

  const HemositParameters({super.key, required this.species, required this.station});

  @override
  State<HemositParameters> createState() => _HemositParametersState();
}

class _HemositParametersState extends State<HemositParameters> {

  double thc = 0;
  double hyalin = 0;
  double granular = 0;
  double semiGranular = 0;

  void calculateTHC(double totalCells, double fp) {
    setState(() {
      thc = totalCells * 5 * 10000 * (fp / 10);
    });
  }

  void calculateHyalin(double hyalinCells, double totalHemosit) {
    setState(() {
      hyalin = (hyalinCells / totalHemosit) * 100;
    });
  }

  void calculateGranular(double granularCells, double totalHemosit) {
    setState(() {
      granular = (granularCells / totalHemosit) * 100;
    });
  }

  void calculateSemiGranular(double semiGranularCells, double totalHemosit) {
    setState(() {
      semiGranular = (semiGranularCells / totalHemosit) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GestureDetector(
            onTap: () {
              Map<String, double> calculationResults = {
                'THC': thc,
                'Hyalin': hyalin,
                'Granular': granular,
                'Semi Granular': semiGranular,
              };
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HemositResults(calculationResults: calculationResults,
                    species: widget.species, station: widget.station, showBottomNav: true))
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
          title: Text('Parameter',
              style: GoogleFonts.poppins(
                  fontSize: 21,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              parameterBox('THC', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        THCCalculation(calculationFunc: calculateTHC))
                );
              }),
              parameterBox('Hyalin', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        HyalinCalculation(calculationFunc: calculateHyalin))
                );
              }),
              parameterBox('Granular', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        GranularCalculation(calculationFunc: calculateGranular))
                );
              }),
              parameterBox('Semi granular', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        SemiGranularCalculation(calculationFunc: calculateSemiGranular))
                );
              }),
              const SizedBox(height: 30)
            ],
          ),
        )
    );
  }

}