import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/analysis/analysis_result_card.dart';
import 'package:hematologi/hematologi/hematologi_results.dart';
import 'package:hematologi/hemosit/hemosit_results.dart';
import 'package:hematologi/history/history_filter_panel.dart';
import 'package:hematologi/models/species.dart';
import 'package:hematologi/water%20quality/wq_outputs.dart';

import '../provider/providers.dart';
import '../water quality/wq_calculation.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFilteredResults = ref.watch(calculationResultsProvider);
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
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: GoogleFonts.poppins(fontSize: 15),
            decoration: InputDecoration(
              hintText: "Cari...",
              hintStyle: GoogleFonts.poppins(
                fontSize: 15.sp,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const HistoryFilterPanel(),
          Expanded(
            child: asyncFilteredResults.when(
                loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
                data: (filteredResults) {
                  return filteredResults.isEmpty
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
                            return AnalysisResultCard(result: result);
                          },
                        );
                }
            )
          )
        ],
      )
    );
  }

}