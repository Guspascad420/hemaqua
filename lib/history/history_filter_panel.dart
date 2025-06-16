import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/history_providers.dart';

class HistoryFilterPanel extends ConsumerWidget {
  const HistoryFilterPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationList = ref.watch(stationListProvider);

    final selectedType = ref.watch(filterTypeProvider);
    final selectedStation = ref.watch(filterStationProvider);

    final List<String> dataTypes = ['Semua', 'Ikan', 'Moluska', 'Kualitas Air'];

    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tampilkan",
                  style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 35.h,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    isDense: true,
                    value: selectedType,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                        filled: true,
                        fillColor: Colors.white
                    ),
                    items: dataTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: GoogleFonts.poppins(fontSize: 12.sp)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Update state filter tipe saat user memilih
                      ref.read(filterTypeProvider.notifier).state = newValue!;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // --- Filter Stasiun ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stasiun",
                  style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 35.h,
                  child: DropdownButtonFormField<String>(
                    value: selectedStation,
                    isExpanded: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        filled: true,
                        fillColor: Colors.white
                    ),
                    items: stationList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: GoogleFonts.poppins(fontSize: 12.sp), overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Update state filter stasiun saat user memilih
                      ref.read(filterStationProvider.notifier).state = newValue!;
                    },
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}