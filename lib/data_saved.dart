import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/home/home_page.dart';

class DataSaved extends StatelessWidget {
  const DataSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      body: Column(
        children: [
          const SizedBox(height: 70),
          Image.asset('images/confirmed_amico.png', scale: 2.5),
          Text('Data berhasil disimpan',
              style: GoogleFonts.poppins(
                  fontSize: 23,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500
                  ))
          ),
          const SizedBox(height: 20),
          Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                            (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      )
                  ),
                  child: Text('Kembali ke halaman',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ))
              )
          )
        ],
      ),
    );
  }

}