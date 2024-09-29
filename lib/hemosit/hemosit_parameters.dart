import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/data_saved.dart';
import 'package:hematologi/parameter_box.dart';

class HemositParameters extends StatefulWidget {
  const HemositParameters({super.key});

  @override
  State<HemositParameters> createState() => _HemositParametersState();
}

class _HemositParametersState extends State<HemositParameters> {
  bool isThcChecked = false;
  bool isHyalinChecked = false;
  bool isGranularChecked = false;
  bool isSemiGranularChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DataSaved() )
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 22),
              color: Colors.blue,
              child: Text('Selanjutnya', textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.white)),
            )
        ),
        backgroundColor: const Color(0xFFF4FBFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF4FBFF),
          centerTitle: true,
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
          title: Text('Parameter',
              style: GoogleFonts.poppins(
                  fontSize: 21,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              parameterBox('THC', isThcChecked, (bool? value) {
                setState(() {
                  isThcChecked = value!;
                });
              }),
              Container(
                  margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  padding: const EdgeInsets.only(left: 15, right: 12, top: 7, bottom: 7),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF60A5FA).withOpacity(0.3),
                        blurRadius: 3,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                          iconColor: Colors.blue,
                          iconSize: 45
                      ),
                      header: Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: Text('DHC',
                            style: GoogleFonts.poppins(
                                fontSize: 21,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500
                            )),
                      ),
                      collapsed: Column(
                          children: [
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isHyalinChecked = !isHyalinChecked;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Hyalin',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Checkbox(value: isHyalinChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isHyalinChecked = value!;
                                              });
                                            }, activeColor: Colors.blue)
                                    )
                                  ],
                                )
                            ),
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isGranularChecked = !isGranularChecked;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Granular',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Checkbox(value: isGranularChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isGranularChecked = value!;
                                              });
                                            }, activeColor: Colors.blue)
                                    )
                                  ],
                                )
                            ),
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    isSemiGranularChecked = !isSemiGranularChecked;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Semi Granular',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Checkbox(value: isSemiGranularChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isSemiGranularChecked = value!;
                                              });
                                            }, activeColor: Colors.blue)
                                    )
                                  ],
                                )
                            )
                          ]
                      ),
                      expanded: SizedBox()
                  )
              ),
              const SizedBox(height: 30)
            ],
          ),
        )
    );
  }

}