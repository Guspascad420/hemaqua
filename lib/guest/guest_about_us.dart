import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_about_us.dart';

import '../login_page.dart';

class GuestAboutUs extends StatelessWidget {
  const GuestAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            reusableAboutUs(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  Text('Apa yang dapat Anda Akses di Aplikasi kami',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 23.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600
                      )),
                  SizedBox(height: 10.h),
                  Text('Berikut adalah daftar fitur-fitur yang dapat anda akses dalam aplikasi kami:',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600
                      )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFECF3FF),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    margin: EdgeInsets.only(top: 15.h),
                    child: Row(
                      children: [
                        Image.asset('images/fish3.png', scale: 3),
                        SizedBox(width: 15.w),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Menambah Data Hematologi',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600
                                    )),
                                SizedBox(height: 5.h),
                                Text('Profile Hemosit gastropoda',
                                    style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600
                                    )),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFECF3FF),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    margin: EdgeInsets.only(top: 15.h),
                    child: Row(
                      children: [
                        Image.asset('images/shell.png', scale: 3),
                        SizedBox(width: 15.w),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Menambah Data Hemosit',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600
                                    )),
                                SizedBox(height: 5.h),
                                Text('Profile Hemosit gastropoda',
                                    style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600
                                    )),
                              ],
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFECF3FF),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    margin: EdgeInsets.only(top: 15.h),
                    child: Row(
                      children: [
                        Image.asset('images/testing_wq2.png', scale: 2),
                        SizedBox(width: 15.w),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mengukur Kualitas Air',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600
                                    )),
                                SizedBox(height: 5.h),
                                Text('Parameter Fisikokimia Air ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w600
                                    )),
                              ],
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: double.infinity,
                height: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 70.w, vertical: 20.h),
                child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                              (route) => false
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        )
                    ),
                    child: Text('Sign out',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ))
                )
            )
          ],
        ),
      )
    );
  }
}