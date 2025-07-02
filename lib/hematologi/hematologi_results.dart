import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/calculations/calculation_result.dart';
import 'package:hematologi/calculations/checker/hematologi_checker.dart';
import 'package:hematologi/data_saved.dart';
import 'package:hematologi/database/database_service.dart';
import 'package:hematologi/utils/format_number.dart';

import '../models/species.dart';
import '../parameter_box.dart';

class HematologiResults extends StatelessWidget {
  final int station;
  final Species species;
  final bool showBottomNav;
  final Map<String, dynamic> calculationResults;

  const HematologiResults({super.key, required this.calculationResults,
    required this.species, required this.station, required this.showBottomNav});

  Widget _buildStatusChip(String status) {
    Color? backgroundColor;
    Color? textColor;

    switch (status) {
      case 'Normal':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'Tidak Normal':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
    }

    return Chip(
      label: Text(
        status,
        style: GoogleFonts.roboto(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    );
  }

  Widget _resultCard(String param, double resultValue) {
    final String genus = species.latin_name.split(' ')[0];
    final double lowerRange = HematologiChecker.normalRanges[genus]![param]![0];
    final double upperRange = HematologiChecker.normalRanges[genus]![param]![1];
    final String status = HematologiChecker.checkCalculation(species.latin_name.split(' ')[0],
        param, calculationResults[param]!);

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      shadowColor: Colors.black.withOpacity(0.08),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(param,
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    )),
                _buildStatusChip(status)
              ],
            ),
            const Divider(color: Colors.grey),
            Text('Hasil ukur: ${formatNumber(resultValue)}',
                style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500
                )),
            Text('Standar baku mutu: ${formatNumber(lowerRange)}-${formatNumber(upperRange)}',
                style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService service = DatabaseService();
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      bottomNavigationBar: !showBottomNav ? null : GestureDetector(
          onTap: () {
            var calculationResult = {
              'id': species.id!,
              'station': station,
              'created_at': Timestamp.now(),
              'type': 'fish_hematology',
              'eritrosit': calculationResults['Eritrosit'],
              'leukosit': calculationResults['Leukosit'],
              'hematokrit': calculationResults['Hematokrit'],
              'hemoglobin': calculationResults['Hemoglobin'],
              'mikronuklei': calculationResults['Mikronuklei'],
              'limfosit': calculationResults['Limfosit'],
              'monosit': calculationResults['Monosit'],
              'neutrofil': calculationResults['Neutrofil'],
              'user_id': auth.currentUser!.uid
            };
            service.addCalculationResult(calculationResult);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DataSaved()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            color: Colors.blue,
            child: Text('Simpan Data', textAlign: TextAlign.center,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (calculationResults['Eritrosit']! != 0.0)
              _resultCard('Eritrosit', calculationResults['Eritrosit']!),
            if (calculationResults['Leukosit']! != 0.0)
              _resultCard('Leukosit', calculationResults['Leukosit']!),
            if (calculationResults['Hematokrit']! != 0.0)
              _resultCard('Hematokrit', calculationResults['Hematokrit']!),
            if (calculationResults['Hemoglobin']! != 0.0)
              _resultCard('Hemoglobin', calculationResults['Hemoglobin']!),
            if (calculationResults['Mikronuklei']! != 0.0)
              _resultCard('Mikronuklei', calculationResults['Mikronuklei']!),
            if (calculationResults['Limfosit']! != 0.0)
              _resultCard('Limfosit', calculationResults['Limfosit']!),
            if (calculationResults['Monosit']! != 0.0)
              _resultCard('Monosit', calculationResults['Monosit']!),
            if (calculationResults['Neutrofil']! != 0.0)
              _resultCard('Neutrofil', calculationResults['Neutrofil']!),
          ],
        ),
      ),
    );
  }

}