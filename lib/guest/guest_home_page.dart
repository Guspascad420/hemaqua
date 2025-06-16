import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../gallery/gallery_category.dart';

class GuestHomePage extends ConsumerWidget {
  const GuestHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Container(
            height: 170.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -60,
                  top: -60,
                  child: Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -110,
                  bottom: -40,
                  child: Container(
                    width: 260.w,
                    height: 260.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 180.w,
                            padding: EdgeInsets.only(left: 25.w, top: 40.h),
                            child: Text('Telusuri Data Hematologi Ikan, Hemosit gastropoda dan keping darah!',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                )),
                        ),
                      ],
                    ),
                    Image.asset('images/sun_rise.png', width: 120.w)
                  ],
                ),
              ],
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Galeri',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF3B82F6),
                              fontWeight: FontWeight.bold
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const GalleryCategory())
                            );
                          },
                          child: Text('Lihat semua',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: const Color(0xFF3B82F6),
                              ))
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset('images/image_30.png', scale: 2.3),
                          Text('Ikan',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500
                              )),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Image.asset('images/image_25.png', scale: 2.3),
                          Text('Moluska',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500
                              )),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Image.asset('images/image_32.png', scale: 2.3),
                          Text('Darah',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              )
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }


}