import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_back_button.dart';
import 'package:hematologi/history/history_page.dart';
import 'package:hematologi/static_grid.dart';

import '../provider/providers.dart';

class HistoryCategory extends ConsumerWidget {

  const HistoryCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResults = ref.watch(calculationResultsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FBFF),
        centerTitle: true,
        leading: const ReusableBackButton(),
        title: Text('Pilih Kategori',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: asyncResults.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => const Center(child: Text('Gagal memuat data')),
        data: (allResults) {
          return SingleChildScrollView(
              child: StaticGrid(
                  padding: EdgeInsets.all(20.w),
                  gap: 35,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HistoryPage())
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20.r))
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.asset('images/fish3.png', scale: 2.3),
                            const SizedBox(height: 10,),
                            Text('Hematologi',
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600
                                )),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HistoryPage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20.r))
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(

                            children: [
                              Image.asset('images/shell.png', scale: 2.3),
                              SizedBox(height: 10.h),
                              Text('Hemosit',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600
                                  )),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        )
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HistoryPage())
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20.r))
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.asset('images/testing_wq2.png', scale: 1.7),
                              SizedBox(height: 10.h),
                              Text('Kualitas air',
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600
                                  )),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        )
                    )
                  ]
              )
          );
        }
      )
    );
  }

}