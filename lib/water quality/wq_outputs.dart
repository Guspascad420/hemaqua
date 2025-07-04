import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/gauge/water_quality_gauge.dart';
import 'package:hematologi/data_saved.dart';
import 'package:hematologi/database/database_service.dart';

class WaterQualityOutputs extends StatefulWidget {
  final double wqi;
  final int station;
  final String resultStatus;
  final String copywriteText;
  final bool showSaveButton;

  const WaterQualityOutputs({super.key, required this.wqi, required this.resultStatus,
    required this.copywriteText, required this.station, required this.showSaveButton});

  @override
  State<WaterQualityOutputs> createState() => _WaterQualityOutputsState();
}

class _WaterQualityOutputsState extends State<WaterQualityOutputs> {
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
          title: Text('Hasil',
              style: GoogleFonts.poppins(
                  fontSize: 21.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
        ),
        bottomNavigationBar: !widget.showSaveButton
            ? null
            : Container(
                width: double.infinity,
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: ElevatedButton(
                    onPressed: () {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                      var calculationResult = {
                        "pollution_index": widget.wqi,
                        "station_id": "Stasiun ${widget.station}",
                        "date": formattedDate,
                        "type": "water_quality",
                        'created_at': Timestamp.now(),
                        "user_id": auth.currentUser!.uid
                      };
                      service.addCalculationResult(calculationResult);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const DataSaved())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.r))
                        )
                    ),
                    child: Text('Simpan hasil',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ))
                )
            ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: Colors.white
                  ),
                  padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 15.w),
                  margin: EdgeInsets.only(top: 25.h, bottom: 30.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('POLLUTION INDEX (IP)',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500
                          )),
                      SizedBox(
                          height: 220.h,
                          child: WaterQualityGauge(value: widget.wqi)
                      ),
                      Text('Status result: ',
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w600
                          )),
                      Text(widget.resultStatus,
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                      SizedBox(height: 10.h),
                      Text(widget.copywriteText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20.h)
              ],
            )
          ),
        )
    );
  }

}