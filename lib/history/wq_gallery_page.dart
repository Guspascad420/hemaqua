import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hematologi/hematologi_results.dart';
import 'package:hematologi/hemosit/hemosit_results.dart';
import 'package:hematologi/models/species.dart';
import 'package:hematologi/water%20quality/wq_calculation.dart';
import 'package:hematologi/water%20quality/wq_outputs.dart';

class WQGalleryPage extends StatefulWidget {
  final List<Map<String, dynamic>> calculationResult;

  const WQGalleryPage({super.key, required this.calculationResult});


  @override
  State<WQGalleryPage> createState() => _WQGalleryPageState();
}

class _WQGalleryPageState extends State<WQGalleryPage> {

  String searchText = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: widget.calculationResult.isEmpty
          ? null : AppBar(
          backgroundColor: const Color(0xFFEFF6FF),
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
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF60A5FA).withOpacity(0.3),
                  blurRadius: 3,
                  offset: const Offset(0, 3), // Shadow position
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(vertical: 5),
            width: 310,
            child: Row(
              children: [
                const SizedBox(width: 15),
                const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 30),
                const SizedBox(width: 5),
                Text(searchText,
                    style: GoogleFonts.inter(
                        fontSize: 14, color: const Color(0xFF9CA3AF)))
              ],
            ),
          )
      ),
      body: widget.calculationResult.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/dead_fish.png', scale: 2.3),
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text('Tidak ada riwayat yang tersedia',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                          ))
                  ),
                  const SizedBox(height: 50),
                ],
              ),
      )
          : ListView.builder(
              itemCount: widget.calculationResult.length,
              itemBuilder: (context, index) {
                var calculationResults = widget.calculationResult[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                          WaterQualityOutputs(
                              showSaveButton: false,
                              wqi: calculationResults["pollution_index"],
                              station: calculationResults["station"],
                              resultStatus: WaterPollutionIndex.pollutionCategory(
                                  calculationResults["pollution_index"]
                              ),
                              copywriteText: WaterPollutionIndex.getCopywritingBasedOnCategory(
                                  calculationResults["pollution_index"]
                              )
                          )
                        )
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          // Container(
                          //   decoration: const BoxDecoration(
                          //       color: Color(0xFFF4FBFF),
                          //       borderRadius: BorderRadius.all(Radius.circular(20))
                          //   ),
                          //   padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                          //   child: Image.network(widget.calculationResult[index]['image_url'], scale: 2.5),
                          // ),
                          // const SizedBox(width: 15),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.calculationResult[index]['date'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500
                                      )),
                                  const SizedBox(height: 25),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.blue, size: 30),
                                      const SizedBox(width: 4),
                                      Text("Stasiun ${widget.calculationResult[index]['station']}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                          )),
                                    ],
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    )
                );
              },
      ),
    );
  }

}