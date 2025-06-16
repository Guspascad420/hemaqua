import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BulletListItem extends StatelessWidget {
  final String title;
  final String text;

  const BulletListItem({
    super.key,
    required this.title, // Teks yang akan di-bold
    required this.text,  // Sisa teksnya
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // 1. Gunakan CrossAxisAlignment.start agar bullet sejajar dengan baris pertama teks
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 2. Ini untuk si bullet point-nya
        const Text(
          "● ",
          style: TextStyle(
            fontSize: 16, // Sesuaikan ukuran
            height: 1.5,   // Sesuaikan jarak vertikal jika perlu
          ),
        ),
        // 3. Expanded agar teks mengisi sisa ruang dan bisa wrap dengan rapi
        Expanded(
          // 4. RichText untuk menggabungkan teks bold dan teks biasa
          child: RichText(
            text: TextSpan(
              // Style default untuk semua teks di dalam RichText ini
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black87,
                height: 1.5, // Spasi antar baris
              ),
              children: [
                // Ini untuk teks yang di-bold (misal: "Informasi Pribadi: ")
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: text,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}