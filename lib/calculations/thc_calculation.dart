import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/utils/reusableTextField.dart';

class THCCalculation extends StatefulWidget {
  final void Function(double, double) calculationFunc;
  const THCCalculation({super.key, required this.calculationFunc});

  @override
  State<StatefulWidget> createState() => _THCCalculationState();
}

class _THCCalculationState extends State<THCCalculation> {
  TextEditingController totalCells = TextEditingController();
  TextEditingController fp = TextEditingController();

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
          title: Text("THC",
              style: GoogleFonts.poppins(
                  fontSize: 21,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('images/thc_formula.png', scale: 2.5),
                      Text('Keterangan',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600
                          )),
                      Text('n : jumlah eritrosit di kotak yang diambil',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500
                          ))
                    ],
                  ),
                ),
                reusableTextField('Jumlah sel total', totalCells, TextInputType.number),
                const SizedBox(height: 10),
                reusableTextField('FP', fp, TextInputType.number),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () {
                      widget.calculationFunc(double.parse(totalCells.text), double.parse(fp.text));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        child: Text('Simpan',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ))
                    )
                )
              ],
            )
        )
    );
  }

}