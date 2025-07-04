import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeciesAnalysisResultPage extends StatelessWidget {
  final String title;
  final List<Widget> resultCards;
  final VoidCallback onSave;
  final bool showSaveButton;

  const SpeciesAnalysisResultPage({
    super.key,
    required this.title,
    required this.resultCards,
    required this.onSave,
    required this.showSaveButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: !showSaveButton ? null : GestureDetector(
        onTap: onSave, // Memanggil callback saat ditekan
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 22),
          color: Colors.blue,
          child: Text(
            'Simpan Data',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          ),
        ),
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
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.only(left: 20),
          child: IconButton(
            padding: const EdgeInsets.only(left: 7),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 21,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ...resultCards
          ],
        ),
      ),
    );
  }
}