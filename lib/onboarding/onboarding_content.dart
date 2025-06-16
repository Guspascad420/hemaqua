import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget onboardingContent(String imageRes, String title, double screenHeight, String content,
    bool isLastPage, [void Function()? onButtonPressed, void Function()? onLoginAsGuest]) {
  return Column(
    children: [
      SizedBox(height: 80.h),
      Image.asset(imageRes, width: 300.w),
      SizedBox(height: 20.h),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: Text(title, textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 26.sp, color: const Color(0xFF3B82F6), fontWeight: FontWeight.w500
            ))
      ),
      SizedBox(height: 10.h),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: Text(content, textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 14.sp, fontWeight: FontWeight.w500
            ))
      ),
      const SizedBox(height: 20),
      isLastPage
          ? Column(
              children: [
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                        onPressed: onButtonPressed,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: const EdgeInsets.symmetric(vertical: 12)),
                        child: Text('Mulai',
                            style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ))
                    )
                ),
                const SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                        onPressed: onLoginAsGuest,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                  style: BorderStyle.solid
                                )
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12)),

                        child: Text('Masuk sebagai tamu',
                            style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue
                            ))
                    )
                ),
              ],
            )
          : const SizedBox(),
    ],
  );
}