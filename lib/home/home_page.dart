import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/add_data.dart';
import 'package:hematologi/bottom_nav_bar.dart';
import 'package:hematologi/cards/empty_fish_card.dart';
import 'package:hematologi/favorite/favorite_page.dart';
import 'package:hematologi/history/history_page.dart';

import '../cards/species_card.dart';
import '../provider/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserDoc = ref.watch(userDocStreamProvider);
    final asyncFavorites = ref.watch(favoriteSpeciesStreamProvider);

    final Map<String, dynamic> userDataMap = asyncUserDoc.when(
      data: (doc) => doc.data() as Map<String, dynamic>,
      loading: () => {},
      error: (e, s) => {},
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 0, user: userDataMap),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      asyncUserDoc.when(
                        loading: () => Text('Halo, ...', // Tampilan saat loading
                            style: GoogleFonts.poppins(
                                fontSize: 21.sp,
                                color: const Color(0xFF3B82F6),
                                fontWeight: FontWeight.bold)),
                        error: (err, stack) => Text('Gagal memuat!', // Tampilan saat error
                            style: GoogleFonts.poppins(
                                fontSize: 21.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                        data: (userDoc) {
                          final data = userDoc.data() as Map<String, dynamic>?;
                          final username = data?['username'] ?? '';
                          return Text('Halo, $username!',
                              style: GoogleFonts.poppins(
                                  fontSize: 21.sp,
                                  color: const Color(0xFF3B82F6),
                                  fontWeight: FontWeight.bold));
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                height: 200.h,
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
                                width: 200.w,
                                padding: EdgeInsets.only(left: 25.w, top: 30.h),
                                child: Text('Mulai Tambahkan Data Hematologi dan Hemosit Anda, dan juga ukur kualitas air!',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500
                                    ))
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25.w, top: 10.h),
                              child: FilledButton(
                                  onPressed: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => const AddData())
                                    );
                                  },
                                  style: FilledButton.styleFrom(
                                      backgroundColor: const Color(0xFF89B4F9),
                                      shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                          side: const BorderSide(
                                              color: Color(0xFF97BDFA),
                                              width: 2,
                                              style: BorderStyle.solid
                                          )
                                      )
                                  ),
                                  child: Text('Tambah Data',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ))
                              ),
                            )
                          ],
                        ),
                        Image.asset('images/sun_rise.png', width: 120.w)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text('Favorit',
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: const Color(0xFF3B82F6),
                              fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const FavoritePage()
                              ));
                            },
                            child: Text('Lihat semua',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF3B82F6),
                                ))
                        )
                    )
                  ],
                ),
                asyncFavorites.when(
                  loading: () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(width: 50.w, child: const CircularProgressIndicator())],
                  ),
                  error: (err, stack) => const Text('Gagal memuat favorit'),
                  data: (favoriteList) {
                    if (favoriteList.isEmpty) {
                      // Tampilan jika daftar favorit kosong
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [emptyFishCard(), SizedBox(width: 15.w), emptyFishCard()],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        speciesCard(context, favoriteList[0], true),
                        SizedBox(width: 15.w),
                        favoriteList.length > 1
                            ? speciesCard(context, favoriteList[1], true)
                            : const SizedBox(),
                      ],
                    );
                  },
                )
              ],
            ),
              const SizedBox(height: 15),
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
                          Text('Riwayat',
                              style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF3B82F6),
                                  fontWeight: FontWeight.bold
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HistoryPage())
                                );
                              },
                              child: Text('Lihat semua',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
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
                              Image.asset('images/image_30.png', scale: 2.7),
                              Text('Ikan',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500
                                  )),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Image.asset('images/image_25.png', scale: 2.7),
                              Text('Moluska',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500
                                  )),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              Image.asset('images/testing_wq2.png', scale: 2.7),
                              Text('Air',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
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
              const SizedBox(height: 15),
            ],
          ),
        )
      )
    );
  }
}