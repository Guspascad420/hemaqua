import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/reusableTextField.dart';
import 'package:hematologi/water%20quality/wq_outputs.dart';

class WaterQualityParameters extends StatefulWidget {
  const WaterQualityParameters({super.key});

  @override
  State<WaterQualityParameters> createState() => _WaterQualityParametersState();
}

class _WaterQualityParametersState extends State<WaterQualityParameters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const WaterQualityOutputs())
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // reusableTextField('Suhu (Celcius)', TextInputType.number),
                // reusableTextField('pH', TextInputType.number),
                // reusableTextField('DO (mg/L)', TextInputType.number),
                // reusableTextField('COD (mg/L)', TextInputType.number),
                // reusableTextField('Nitrit (mg/L)', TextInputType.number),
                // reusableTextField('Nitrat (mg/L)', TextInputType.number),
                // reusableTextField('Amonia (mg/L)', TextInputType.number),
                // reusableTextField('Fosfat (mg/L)', TextInputType.number),
                // reusableTextField('TOM (mg/L)', TextInputType.number),
                // reusableTextField('TDS (mg/L)', TextInputType.number),
                // reusableTextField('TSS (mg/L)', TextInputType.number),
                // reusableTextField('Kecepatan Arus (m/s)', TextInputType.number),
                // reusableTextField('Fenol', TextInputType.number),
                // reusableTextField('Surfaktan', TextInputType.number),
              ],
            ),
          )
        )
    );
  }

}