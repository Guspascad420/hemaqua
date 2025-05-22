import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  fontSize: 21,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white
                ),
                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 15),
                margin: const EdgeInsets.only(top: 25, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('POLLUTION INDEX (IP)',
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500
                        )),
                    FittedBox(
                      child: Text(widget.wqi.toStringAsFixed(2),
                          style: GoogleFonts.poppins(
                              fontSize: 74,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          )),
                    ),
                    const SizedBox(height: 15),
                    Text('Status hasil: ',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600
                        )),
                    Text(widget.resultStatus,
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600
                        )),
                    const SizedBox(height: 10),
                    Text(widget.copywriteText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (widget.showSaveButton) Container(
                  width: double.infinity,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      onPressed: (){
                        DateTime now = DateTime.now();
                        String formattedDate =
                            '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                        var calculationResult = {
                          "pollution_index": widget.wqi,
                          "station": widget.station,
                          "date": formattedDate,
                          "type": "water quality"
                        };
                        service.addCalculationResult(calculationResult, auth.currentUser!.uid);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const DataSaved())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                      ),
                      child: Text('Simpan hasil',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          ))
                  )
              )
            ],
          ),
        )
    );
  }

}