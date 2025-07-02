import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../hematologi/hematologi_results.dart';
import '../hemosit/hemosit_results.dart';
import '../models/species.dart';
import '../provider/providers.dart';
import '../water quality/wq_calculation.dart';
import '../water quality/wq_outputs.dart';

class AnalysisResultCard extends ConsumerWidget {
  final Map<String, dynamic> result;

  const AnalysisResultCard({super.key, required this.result});

  void _showDeleteDialog(BuildContext context, Map<String, dynamic> speciesData, WidgetRef ref) async {
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
    Widget content;
    String type = result['type'];

    if (type == 'fish' || type == 'molluscs') {
      content = _SpeciesResultView(result: result, onDeletePressed: () { _showDeleteDialog(context, result, ref); });
    } else { // 'water_quality'
      content = _WaterQualityView(result: result, onDeletePressed: () { _showDeleteDialog(context, result, ref); });
    }

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
          child: content,
        )
    );
  }

}

class _SpeciesResultView extends StatelessWidget {
  final Map<String, dynamic> result;
  final VoidCallback onDeletePressed;

  const _SpeciesResultView({super.key, required this.result, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFF4FBFF),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              margin: const EdgeInsets.only(right: 15),
              child: Image.network(result['image_url'],
                  width: MediaQuery.of(context).size.width * 0.3),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result['name'],
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500
                      )),
                  Text(result['latin_name'],
                      style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                      )),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 25.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue, size: 30.r),
                const SizedBox(width: 4),
                Text("Stasiun ${result['station']}",
                    style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                    )),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4FBFF),
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(Icons.delete_outline, color: Colors.red,)
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _WaterQualityView extends StatelessWidget {
  final Map<String, dynamic> result;
  final VoidCallback onDeletePressed;
  const _WaterQualityView({super.key, required this.result, required this.onDeletePressed});

  Widget _buildStatusBadge() {
    String statusText;
    Color backgroundColor;
    Color textColor;

    if (result['pollution_index'] < 26) {
      statusText = 'Excellent';
      backgroundColor = Colors.blue.shade100;
      textColor = Colors.blue.shade800;     
    } else if (result['pollution_index'] < 51) {
      statusText = 'Bagus';
      backgroundColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
    } else if (result['pollution_index'] < 76) {
      statusText = 'Cukup';
      backgroundColor = Colors.yellow.shade200;
      textColor = Colors.yellow.shade900;// Kuning muda
    } else if (result['pollution_index'] < 101) {
      statusText = 'Buruk';
      backgroundColor = Colors.orange.shade200;
      textColor = Colors.orange.shade900;
    } else if (result['pollution_index'] < 151) {
      statusText = 'Sangat Buruk';
      backgroundColor = Colors.red.shade200;
      textColor = Colors.red.shade900;
    } else {
      statusText = 'Tidak Layak';
      backgroundColor = Colors.red.shade400;
      textColor = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.poppins(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp, // Ukuran font dibuat pas untuk sebuah badge
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double wqi = result['pollution_index'];
    String wqiFormatted = wqi.toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kualitas Air',
            style: GoogleFonts.poppins(
                color: Colors.blue,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600
            ),
            softWrap: true,  // Ensure wrapping is enabled
            maxLines: 2,     // Optional: Limit to 2 lines
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Text('Indeks Polusi (IP) : $wqiFormatted',
            style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
            ),
            softWrap: true,  // Ensure wrapping is enabled
            maxLines: 2,     // Optional: Limit to 2 lines
            overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        Row(
          children: [
            Text('Status : ',
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                )),
            _buildStatusBadge()
          ],
        ),
        const SizedBox(height: 4),
        Text("(${result["date"]})",
            style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
            )),
        SizedBox(height: 25.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue, size: 30.r),
                const SizedBox(width: 4),
                Text("Stasiun ${result['station']}",
                    style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                    )),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4FBFF),
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
              ),
              child: IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(Icons.delete_outline, color: Colors.red,)
              ),
            )
          ],
        ),
      ],
    );
  }
}