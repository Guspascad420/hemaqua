import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/analysis/status_chip.dart';
import 'package:hematologi/utils/format_number.dart';

class ResultParameterCard extends StatelessWidget {
  final String parameterName;
  final double resultValue;
  final String status;
  final String standardQuality;

  const ResultParameterCard({
    super.key,
    required this.parameterName,
    required this.resultValue,
    required this.status,
    required this.standardQuality,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      shadowColor: Colors.black.withOpacity(0.08),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  parameterName,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                StatusChip(status: status), // Menggunakan widget reusable
              ],
            ),
            const Divider(color: Colors.grey, height: 20),
            Text(
              'Hasil ukur: ${formatNumber(resultValue)}',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              standardQuality,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}