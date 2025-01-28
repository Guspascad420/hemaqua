import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/calculations/calculation_result.dart';

import '../parameter_box.dart';

class HemositResults extends StatelessWidget {
  final Map<String, double> calculationResults;

  const HemositResults({super.key, required this.calculationResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
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
          parameterBox('THC', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    CalculationResult(result: calculationResults['thc']!))
            );
          }),
          parameterBox('Hyalin', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    CalculationResult(result: calculationResults['hyalin']!))
            );
          }),
          parameterBox('Granular', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    CalculationResult(result: calculationResults['granular']!))
            );
          }),
          parameterBox('Semi Granular', () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    CalculationResult(result: calculationResults['semi_granular']!))
            );
          }),
        ],
      ),
    );
  }

}