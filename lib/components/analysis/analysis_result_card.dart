import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../hematologi/hematologi_results.dart';
import '../../hemosit/hemosit_results.dart';
import '../../models/species.dart';
import '../../provider/providers.dart';
import '../../water quality/wq_calculation.dart';
import '../../water quality/wq_outputs.dart';

enum ResultCardStyle {
  full,
  compact,
}

class AnalysisResultCard extends ConsumerWidget {
  final Map<String, dynamic> result;
  final ResultCardStyle style;

  const AnalysisResultCard({super.key, required this.result, this.style = ResultCardStyle.full});

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
                ref.read(databaseServiceProvider).removeCalculationResult(speciesData['id']);
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
  void _navigateToResultDetail(WidgetRef ref, BuildContext context, Map<String, dynamic> result) {
    Map<String, dynamic> calculationParams = {};

    final String type = result['type'];

    if (type == 'fish_hematology' || type == 'mollusc_hemocyte') {
      if (type == 'fish_hematology') {
        calculationParams = {
          'eritrosit': (result['eritrosit'] as num).toDouble(),
          'leukosit': (result['leukosit'] as num).toDouble(),
          "hematokrit": (result['hematokrit'] as num).toDouble(),
          "hemoglobin": (result['hemoglobin'] as num).toDouble(),
          "mikronuklei": (result['mikronuklei'] as num).toDouble(),
          "limfosit": (result['limfosit'] as num).toDouble(),
          "monosit": (result['monosit'] as num).toDouble(),
          "neutrofil": (result['neutrofil'] as num).toDouble()
        };
      } else { // type == 'molluscs'
        calculationParams = {
          'thc': (result['thc'] as num).toDouble(),
          'hyalin': (result['hyalin'] as num).toDouble(),
          'granular': (result['granular'] as num).toDouble(),
          'semi_granular': (result['semi_granular'] as num).toDouble(),
        };
      }
    } else {
      calculationParams = {
        'pollution_index': (result['pollution_index'] as num).toDouble(),
        'station': result['station_id']
      };
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        final speciesAsync = ref.watch(speciesDetailsProvider(result['species_id']));
        if (type == 'fish_hematology') {
          return HematologiResults(
            calculationResults: calculationParams,
            species: speciesAsync.value!,
            showBottomNav: false,
          );
        } else if (type == 'mollusc_hemocyte') {
          return HemositResults(
            calculationResults: calculationParams,
            species: speciesAsync.value!,
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

    if (type == 'fish_hematology' || type == 'mollusc_hemocyte') {
      content = _SpeciesResultView(result: result, onDeletePressed: () { _showDeleteDialog(context, result, ref); }, style: style);
    } else { // 'water_quality'
      content = _WaterQualityView(result: result, onDeletePressed: () { _showDeleteDialog(context, result, ref); });
    }

    return GestureDetector(
        onTap: () {
          _navigateToResultDetail(ref, context, result);
        },
        child: Container(
          margin: EdgeInsets.only(left: style == ResultCardStyle.compact ? 0 : 20, right: 20, top: 15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: style == ResultCardStyle.compact ? Border.all(width: 1.5, color: Colors.blue) : null,
            color: Colors.white,
          ),
          child: content,
        )
    );
  }

}

class _SpeciesResultView extends ConsumerWidget {
  final Map<String, dynamic> result;
  final VoidCallback onDeletePressed;
  final ResultCardStyle style;

  const _SpeciesResultView({super.key, required this.result, required this.onDeletePressed, required this.style});

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');

    String formattedDate = formatter.format(dateTime);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String speciesId = result['species_id'];
    final imageUrlAsync = ref.watch(imageUrlProvider(result['image_url'] ?? ''));
    final speciesAsync = ref.watch(speciesDetailsProvider(speciesId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (style == ResultCardStyle.full)
          speciesAsync.when(
              loading: () => const Text("Memuat nama...", style: TextStyle(fontWeight: FontWeight.bold)),
              error: (e, s) => const Text("Spesies tidak ditemukan", style: TextStyle(color: Colors.red)),
              data: (species) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(species.name,
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500
                      )),
                  Text(species.latin_name,
                      style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500
                      )),
                ],
              )
          ),
        SizedBox(height: 5.h),
        if (style == ResultCardStyle.compact)
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue, size: 30.r),
              const SizedBox(width: 4),
              Text(result['station_id'],
                  style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500
                  )),
            ],
          ),
        SizedBox(height: 5.h),
        Text(formatTimestamp(result['created_at']),
            style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
            )),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                Text(result['station_id'],
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