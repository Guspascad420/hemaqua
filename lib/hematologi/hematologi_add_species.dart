import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/hematologi/hematologi_species_list.dart';
import 'package:hematologi/reusableTextField.dart';

class HematologiAddSpecies extends StatefulWidget {
  const HematologiAddSpecies({super.key});

  @override
  State<HematologiAddSpecies> createState() => _HematologiAddSpeciesState();
}

class _HematologiAddSpeciesState extends State<HematologiAddSpecies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('images/marine_mollusca.png', scale: 2.5),
          Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(left: 20),
                      child: IconButton(
                        padding: const EdgeInsets.only(left: 7),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
                      )
                  ),
                  Text('Tambah Spesies',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(width: 40,)
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 70,
                            height: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Text('Station 1',
                              style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600
                              )),
                        ),
                        const SizedBox(height: 30),
                        reusableTextField('Nama'),
                        reusableTextField('Spesies'),
                        reusableTextField('Lokasi'),
                        Container(
                          margin: const EdgeInsets.only(left: 5, bottom: 3),
                          child: Text('Deskripsi',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              )),
                        ),
                        TextField(
                          // controller: _passwordTextController,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 1, color: Color(0xFFADD5F8)),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            fillColor: const Color(0xFFEFF6FF),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const HematologiSpeciesList())
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    )
                                ),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                                    child: Text('Tambah',
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500
                                        ))
                                )
                            )
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                )
              )
            ],
          )
        ],
      )
    );
  }

}