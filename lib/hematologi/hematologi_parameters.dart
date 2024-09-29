import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/cards/fish_card3.dart';
import 'package:hematologi/data_saved.dart';
import 'package:hematologi/parameter_box.dart';

class HematologiParameters extends StatefulWidget {
  const HematologiParameters({super.key});

  @override
  State<HematologiParameters> createState() => _HematologiParametersState();
}

class _HematologiParametersState extends State<HematologiParameters> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  double turns = 0.0;
  bool isEritrositChecked = true;
  bool isLeukositChecked = false;
  bool isHematokritChecked = false;
  bool isHemoglobinChecked = false;
  bool isMikronukleiChecked = false;
  bool isNeutrofilChecked = false;
  bool isEusinofilChecked = false;
  bool isBasofilChecked = false;
  bool isLimfositChecked = false;
  bool isMonositChecked = false;
  bool isGranulositChecked = false;
  bool isNonGranulositChecked = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DataSaved())
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
          child: ExpandableNotifier(
              child: Column(
                children: [
                  parameterBox('Eritrosit', isEritrositChecked, (bool? value) {
                    setState(() {
                      isEritrositChecked = value!;
                      debugPrint('$isEritrositChecked');
                    });
                  }),
                  parameterBox('Leukosit', isLeukositChecked, (bool? value) {
                    setState(() {
                      isLeukositChecked = value!;
                    });
                  }),
                  parameterBox('Hematokrit', isHematokritChecked, (bool? value) {
                    setState(() {
                      isHematokritChecked = value!;
                    });
                  }),
                  parameterBox('Hemoglobin', isHemoglobinChecked, (bool? value) {
                    setState(() {
                      isHemoglobinChecked = value!;
                    });
                  }),
                  parameterBox('Mikronuklei', isMikronukleiChecked, (bool? value) {
                    setState(() {
                      isMikronukleiChecked = value!;
                    });
                  }),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                    padding: const EdgeInsets.only(left: 15, right: 10, top: 7, bottom: 7),
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
                          child: Text('Diferensial Leukosit',
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
                                  isNonGranulositChecked = !isNonGranulositChecked;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Non Granulosit',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Checkbox(value: isNonGranulositChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isNonGranulositChecked = value!;
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
                                    isGranulositChecked = !isGranulositChecked;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Granulosit',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: Checkbox(value: isGranulositChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isGranulositChecked = value!;
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
                  // Column(
                  //   children: [
                  //     if (!isExpanded)...[
                  //       parameterBox('Non Granulosit', false, (bool? value) {
                  //
                  //       }),
                  //     ]
                  //   ],
                  // ),
                  parameterBox('Neutrofil', isNeutrofilChecked, (bool? value) {
                    setState(() {
                      isNeutrofilChecked = value!;
                    });
                  }),
                  parameterBox('Eusinofil', isEusinofilChecked, (bool? value) {
                    setState(() {
                      isEusinofilChecked = value!;
                    });
                  }),
                  parameterBox('Basofil', isBasofilChecked, (bool? value) {
                    setState(() {
                      isBasofilChecked = value!;
                    });
                  }),
                  parameterBox('Limfosit', isLimfositChecked, (bool? value) {
                    setState(() {
                      isLimfositChecked = value!;
                    });
                  }),
                  parameterBox('Monosit', isMonositChecked, (bool? value) {
                    setState(() {
                      isMonositChecked = value!;
                    });
                  }),
                  const SizedBox(height: 30)
                ],
              ),
          )
        )
    );
  }

}