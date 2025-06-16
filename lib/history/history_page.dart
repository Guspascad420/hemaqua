import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hematologi/hematologi_results.dart';
import 'package:hematologi/hemosit/hemosit_results.dart';
import 'package:hematologi/models/species.dart';
import 'package:hematologi/water%20quality/wq_outputs.dart';

import '../provider/providers.dart';
import '../water quality/wq_calculation.dart';

class HistoryPage extends ConsumerWidget {
  final String category;
  const HistoryPage({super.key, required this.category});

  Future<void> _showDeleteDialog(BuildContext context, Map<String, dynamic> speciesData, WidgetRef ref) async {
    final uid = ref.read(authStateProvider).asData?.value?.uid;
    if (uid == null) return;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
              "Apakah kamu yakin untuk menghapus item ini?",
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
              )
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                  "Batal",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(databaseServiceProvider).removeCalculationResult(speciesData, uid);
                Navigator.of(context).pop();
              },
              child: Text("Hapus", style: GoogleFonts.poppins(fontSize: 15,
                  fontWeight: FontWeight.w500, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _navigateToResultDetail(BuildContext context, Map<String, dynamic> result) {
    Species? species;
    Map<String, dynamic> calculationParams = {};

    final String type = result['type'];

    if (type == 'fish' || type == 'molluscs') {
      species = Species.fromCalculationResultMap(result);

      if (type == 'fish') {
        calculationParams = {
          'Eritrosit': (result['eritrosit'] as num).toDouble(),
          'Leukosit': (result['leukosit'] as num).toDouble(),
          "Hematokrit": (result['hematokrit'] as num).toDouble(),
          "Hemoglobin": (result['hemoglobin'] as num).toDouble(),
          "Mikronuklei": (result['mikronuklei'] as num).toDouble(),
          "Limfosit": (result['limfosit'] as num).toDouble(),
          "Monosit": (result['monosit'] as num).toDouble(),
          "Neutrofil": (result['neutrofil'] as num).toDouble()
        };
      } else { // type == 'molluscs'
        calculationParams = {
          'THC': (result['thc'] as num).toDouble(),
          'Hyalin': (result['hyalin'] as num).toDouble(),
          'Granular': (result['granular'] as num).toDouble(),
          'Semi Granular': (result['semi_granular'] as num).toDouble(),
        };
      }
    } else {
      calculationParams = {
        'pollution_index': (result['pollution_index'] as num).toDouble(),
        'station': (result['station'] as num).toInt(),
      };
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        if (type == 'fish') {
          return HematologiResults(
            calculationResults: calculationParams,
            species: species!, // Aman pakai ! karena sudah pasti diisi jika type 'fish'
            station: result['station'],
            showBottomNav: false,
          );
        } else if (type == 'molluscs') {
          return HemositResults(
            calculationResults: calculationParams,
            species: species!, // Aman pakai ! karena sudah pasti diisi jika type 'molluscs'
            station: result['station'],
            showBottomNav: false,
          );
        } else { // 'water quality'
          return WaterQualityOutputs(
            wqi: result['pollution_index'],
            station: result['station'],
            resultStatus: WaterPollutionIndex.pollutionCategory(
                result["pollution_index"]
            ),
            copywriteText: WaterPollutionIndex.getCopywritingBasedOnCategory(
                result["pollution_index"]
            ),
            showSaveButton: false,
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAllResults = ref.watch(calculationResultsProvider);

    return asyncAllResults.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (allResults) {
        final filteredResults = allResults.where((result) => result['type'] == category).toList();
        return Scaffold(
          backgroundColor: const Color(0xFFEFF6FF),
          appBar: AppBar(
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
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(
                  hintText: "Cari...",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          body: filteredResults.isEmpty
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
                  itemCount: filteredResults.length,
                  itemBuilder: (context, index) {
                    final result = filteredResults[index];
                    return GestureDetector(
                        onTap: () {
                          _navigateToResultDetail(context, result);
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
                              if (category != "water quality")...[
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFF4FBFF),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                                  margin: const EdgeInsets.only(right: 15),
                                  child: Image.network(result['image_url'],
                                      width: MediaQuery.of(context).size.width * 0.3),
                                )
                              ],
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(result['name'] ?? result["date"],
                                          style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500
                                          )),
                                      const SizedBox(height: 4),
                                      if (result['latin_name'] != null)
                                        Text(result['latin_name'],
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                            ),
                                            softWrap: true,  // Ensure wrapping is enabled
                                            maxLines: 2,     // Optional: Limit to 2 lines
                                            overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on, color: Colors.blue, size: 30),
                                              const SizedBox(width: 4),
                                              Text("Stasiun ${result['station']}",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500
                                                  )),
                                            ],
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFF4FBFF),
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                            ),
                                            child: IconButton(
                                                onPressed: () {
                                                  _showDeleteDialog(context, result, ref);
                                                },
                                                icon: const Icon(Icons.delete_outline, color: Colors.red,)
                                            ),
                                          )
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
    );
  }

}