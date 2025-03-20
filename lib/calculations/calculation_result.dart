import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculationResult extends StatefulWidget {
  final double result;
  final String resultStatus;

  const CalculationResult({super.key, required this.result, required this.resultStatus});

  @override
  State<CalculationResult> createState() => _CalculationResultState();
}

class _CalculationResultState extends State<CalculationResult> {
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
        title: Text('Detail Hasil',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 15),
                margin: const EdgeInsets.only(top: 25, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('HASIL',
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500
                        )),
                    Text("${widget.result}",
                        style: GoogleFonts.poppins(
                            fontSize: 78,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                        )),
                    const SizedBox(height: 15),
                    Text('Status hasil: ${widget.resultStatus}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600
                        )),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                            widget.resultStatus == 'Normal'
                                ? 'Kabar baik! Komponen darah ikan Anda berada dalam kisaran sehat. '
                                'Hal ini menunjukkan kesehatan dan kesejahteraan yang optimal. '
                                'Teruslah berkarya dengan menjaga pola makan seimbang, air bersih, '
                                'dan pemantauan berkala. Jika Anda mempunyai kekhawatiran, konsultasikan '
                                'dengan spesialis untuk saran lebih lanjut'
                                : 'Komponen darah ikan Anda berada di luar kisaran normal, '
                                'yang mungkin mengindikasikan potensi masalah kesehatan. '
                                'Kami merekomendasikan untuk meninjau lingkungan, '
                                'pola makan, dan kualitas air mereka. Untuk diagnosis '
                                'rinci dan rencana pengobatan, konsultasikan dengan '
                                'spesialis kesehatan ikan sesegera mungkin',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500
                            ))
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }

}