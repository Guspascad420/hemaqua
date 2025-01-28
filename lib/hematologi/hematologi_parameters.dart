import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/calculations/eritrosit_calculation.dart';
import 'package:hematologi/calculations/hematokrit_calculation.dart';
import 'package:hematologi/calculations/hemoglobin_calculation.dart';
import 'package:hematologi/calculations/leukosit_calculation.dart';
import 'package:hematologi/calculations/leukositdiff_calculation.dart';
import 'package:hematologi/calculations/mikronuklei_calculation.dart';
import 'package:hematologi/cards/fish_card3.dart';
import 'package:hematologi/data_saved.dart';
import 'package:hematologi/hematologi/hematologi_results.dart';
import 'package:hematologi/parameter_box.dart';

class HematologiParameters extends StatefulWidget {
  const HematologiParameters({super.key});

  @override
  State<HematologiParameters> createState() => _HematologiParametersState();
}

class _HematologiParametersState extends State<HematologiParameters> with SingleTickerProviderStateMixin {

  double leukosit = 0;
  double eritrosit = 0;
  double hematokrit = 0;
  double diffLeukosit = 0;
  double mikronuklei = 0;
  double hemoglobin = 0;

  void calculateLeukosit(double n) {
    setState(() {
      leukosit = n * 20 / 0.4;
    });
  }

  void calculateMikronuklei(double micronucleatedCells, double totalCells) {
    setState(() {
      mikronuklei = (micronucleatedCells / totalCells) * 100;
    });
  }

  void calculateEritrosit(double n) {
    setState(() {
      eritrosit = n * 20 / 0.4;
    });
  }

  void calculateHematokrit(double rbcVolume, double totalBlood) {
    setState(() {
     hematokrit = (rbcVolume / totalBlood) * 100;
    });
  }

  void calculateHemoglobin(double sampleAbsorbance, double standardAbsorbance, double standardConcentration) {
    setState(() {
      hemoglobin = (sampleAbsorbance / standardAbsorbance) * standardConcentration;
    });
  }

  void calculateDiffLeukosit(double cellCount, double totalLeukosit) {
    setState(() {
      diffLeukosit = (cellCount / totalLeukosit) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GestureDetector(
            onTap: () {
              Map<String, double> calculationResults = {
                'leukosit': leukosit,
                'eritrosit': eritrosit,
                'hematokrit': hematokrit,
                'diffLeukosit': diffLeukosit,
                'mikronuklei': mikronuklei,
                'hemoglobin': hemoglobin,
              };
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HematologiResults(calculationResults: calculationResults))
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
          child: ExpandableNotifier(
              child: Column(
                children: [
                  parameterBox('Eritrosit', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            EritrositCalculation(calculationFunc: calculateEritrosit))
                    );
                  }),
                  parameterBox('Leukosit', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            LeukositCalculation(calculationFunc: calculateLeukosit))
                    );
                  }),
                  parameterBox('Hematokrit', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            HematokritCalculation(calculationFunc: calculateHematokrit))
                    );
                  }),
                  parameterBox('Hemoglobin', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            HemoglobinCalculation(calculationFunc: calculateHemoglobin))
                    );
                  }),
                  parameterBox('Mikronuklei', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            MikronukleiCalculation(calculationFunc: calculateMikronuklei))
                    );
                  }),
                  parameterBox('Diferensial Leukosit', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            LeukositDiffCalculation(calculationFunc: calculateDiffLeukosit))
                    );
                  }),
                  parameterBox('Neutrofil', () {}),
                  parameterBox('Eusinofil', () {}),
                  parameterBox('Basofil', () {}),
                  parameterBox('Limfosit', () {}),
                  parameterBox('Monosit', () {}),
                  const SizedBox(height: 30)
                ],
              ),
          )
        )
    );
  }

}