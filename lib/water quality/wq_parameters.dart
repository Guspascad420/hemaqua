import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/utils/reusableTextField.dart';
import 'package:hematologi/water%20quality/wq_calculation.dart';
import 'package:hematologi/water%20quality/wq_outputs.dart';

class WaterQualityParameters extends StatefulWidget {
  final int station;

  const WaterQualityParameters({super.key, required this.station});

  @override
  State<WaterQualityParameters> createState() => _WaterQualityParametersState();
}

class _WaterQualityParametersState extends State<WaterQualityParameters> {
  TextEditingController ph = TextEditingController();
  TextEditingController DO = TextEditingController();
  TextEditingController bod = TextEditingController();
  TextEditingController cod = TextEditingController();
  TextEditingController nitrat = TextEditingController();
  TextEditingController nitrit = TextEditingController();
  TextEditingController amonia = TextEditingController();
  TextEditingController fosfat = TextEditingController();
  TextEditingController tds = TextEditingController();
  TextEditingController tss = TextEditingController();
  TextEditingController merkuri = TextEditingController();
  TextEditingController fenol = TextEditingController();
  TextEditingController sulfat = TextEditingController();
  TextEditingController timbal = TextEditingController();
  TextEditingController tembaga = TextEditingController();
  TextEditingController kromium = TextEditingController();

  Map<String, double> getValidatedValues() {
    Map<String, double> values = {};

    void addToMap(String key, TextEditingController controller) {
      if (controller.text.isNotEmpty) {
        double? value = double.tryParse(controller.text);
        if (value != null) {
          values[key] = value;
        }
      }
    }

    addToMap("pH", ph);
    addToMap("DO", DO);
    addToMap("BOD", bod);
    addToMap("COD", cod);
    addToMap("Nitrat", nitrat);
    addToMap("Nitrit", nitrit);
    addToMap("Amonia", amonia);
    addToMap("Fosfat", fosfat);
    addToMap("TDS", tds);
    addToMap("TSS", tss);
    addToMap("Merkuri", merkuri);
    addToMap("Fenol", fenol);
    addToMap("Sulfat", sulfat);
    addToMap("Timbal", timbal);
    addToMap("Tembaga", tembaga);
    addToMap("Kromium", kromium);

    return values;
  }

  @override
  void dispose() {
    ph.dispose();
    DO.dispose();
    bod.dispose();
    cod.dispose();
    nitrat.dispose();
    nitrit.dispose();
    amonia.dispose();
    fosfat.dispose();
    tds.dispose();
    tss.dispose();
    merkuri.dispose();
    fenol.dispose();
    sulfat.dispose();
    timbal.dispose();
    tembaga.dispose();
    kromium.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GestureDetector(
            onTap: () {
              double naturalTemp = 28.0;
              Map<String, double> validatedValues = getValidatedValues();

              try {
                double wqi = WaterPollutionIndex.calculateWQI(validatedValues, naturalTemp: naturalTemp);
                String resultStatus = WaterPollutionIndex.pollutionCategory(wqi);
                String copywriteText = WaterPollutionIndex.getCopywritingBasedOnCategory(wqi);

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WaterQualityOutputs(wqi: wqi, station: widget.station,
                        resultStatus: resultStatus, copywriteText: copywriteText, showSaveButton: true))
                );
              } on ArgumentError catch (e, _){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Minimal 6 parameter harus diberikan untuk perhitungan",
                          style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        )),
                      backgroundColor: Colors.red
                  ),
                );
              }
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
                reusableTextField('pH', ph, TextInputType.number),
                reusableTextField('DO (mg/L)', DO, TextInputType.number),
                reusableTextField('BOD (mg/L)', bod, TextInputType.number),
                reusableTextField('COD (mg/L)', cod, TextInputType.number),
                reusableTextField('Nitrit (mg/L)', nitrit, TextInputType.number),
                reusableTextField('Nitrat (mg/L)', nitrat, TextInputType.number),
                reusableTextField('Amonia (mg/L)', amonia, TextInputType.number),
                reusableTextField('Fosfat (mg/L)', fosfat, TextInputType.number),
                reusableTextField('TDS (mg/L)', tds, TextInputType.number),
                reusableTextField('TSS (mg/L)', tss, TextInputType.number),
                reusableTextField('Merkuri', merkuri, TextInputType.number),
                reusableTextField('Fenol', fenol, TextInputType.number),
                reusableTextField('Sulfat', sulfat, TextInputType.number),
                reusableTextField('Total Bakteri', timbal, TextInputType.number),
                reusableTextField('Tembaga', tembaga, TextInputType.number),
                reusableTextField('Kromium', kromium, TextInputType.number)
              ],
            ),
          )
        )
    );
  }

}