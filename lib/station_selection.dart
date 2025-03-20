import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StationSelection extends StatefulWidget {
  const StationSelection({super.key, required this.nextWidget});

  final Widget Function(int) nextWidget;

  @override
  State<StationSelection> createState() => _StationSelectionState();
}

class _StationSelectionState extends State<StationSelection> {

  double _currentSliderValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FBFF),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Stasiun',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
              child: Image.asset('images/location_vector.png', scale: 2.5)
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Slider(
              activeColor: Colors.blue,
              inactiveColor: const Color(0xFFD8E6FD),
              value: _currentSliderValue,
              min: 1,
              max: 10,
              divisions: 9,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => widget.nextWidget(_currentSliderValue.toInt()))
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
                  child: Text('Tampilkan',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ))
              )
          )
        ],
      ),
    );
  }
}