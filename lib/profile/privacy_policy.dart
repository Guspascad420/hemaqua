import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_back_button.dart';

import '../components/bullet_list_item.dart'; // Import google_fonts

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  Widget _buildPrivacyPolicySection(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 10.h),
        Text(
          subtitle,
          style: GoogleFonts.poppins( // Menggunakan GoogleFonts.poppins
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        leading: const ReusableBackButton(),
        title: Text(
            'Kebijakan Privasi',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text
              (
              'Kebijakan Privasi HEMAQUA ( Hematology & Hemocytes for Water Quality Analyzer )',
              style: GoogleFonts.poppins( // Menggunakan GoogleFonts.poppins
                  fontSize: 20.sp, // Menggunakan .sp untuk ukuran font
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
              ),
            ),
            SizedBox(height: 10.h), // Menggunakan .h untuk tinggi SizedBox
            Text(
              'Kami di HEMAQUA sangat menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, mengungkapkan, dan melindungi informasi Anda ketika Anda menggunakan aplikasi HEMAQUA (Hematology & Hemocytes for Water Quality Analyzer). Dengan menggunakan aplikasi kami, Anda setuju dengan kebijakan privasi ini.',
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins( // Menggunakan GoogleFonts.poppins
                fontSize: 14.sp, // Menggunakan .sp untuk ukuran font
              ),
            ),
            SizedBox(height: 20.h),
            _buildPrivacyPolicySection('1. Informasi yang Kami Kumpulkan',
                'Kami mengumpulkan dua jenis informasi: informasi pribadi dan informasi non-pribadi.'),
            const BulletListItem(
              title: 'Informasi Pribadi',
              text: 'Kami tidak mengumpulkan informasi pribadi yang dapat mengidentifikasi Anda secara langsung, seperti nama, alamat email, atau nomor telepon, kecuali jika Anda secara sukarela memberikan informasi tersebut kepada kami (misalnya, melalui formulir umpan balik atau pendaftaran untuk fitur tertentu).',
            ),
            const SizedBox(height: 16), // Kasih jarak antar item
            const BulletListItem(
              title: 'Informasi Non-Pribadi',
              text: 'Kami mengumpulkan informasi teknis yang berkaitan dengan penggunaan aplikasi Anda, seperti jenis perangkat, sistem operasi, alamat IP, lokasi umum (dengan izin Anda), dan data penggunaan aplikasi. Informasi ini digunakan untuk meningkatkan pengalaman pengguna dan memantau performa aplikasi.',
            ),
            const SizedBox(height: 16),
            _buildPrivacyPolicySection('2. Penggunaan Informasi',
                'Informasi yang kami kumpulkan digunakan untuk tujuan berikut:'),
            const BulletListItem(
              title: 'Meningkatkan Kinerja Aplikasi',
              text: 'Untuk menganalisis dan meningkatkan kualitas aplikasi, fitur, dan fungsionalitasnya.',
            ),
            const SizedBox(height: 16), // Jarak antar item

            const BulletListItem(
              title: 'Personalisasi Pengalaman Pengguna',
              text: 'Untuk memberikan saran dan rekomendasi yang relevan berdasarkan data penggunaan.',
            ),
            const SizedBox(height: 16),

            const BulletListItem(
              title: 'Analisis & Laporan',
              text: 'Untuk menyediakan data analitis yang diperlukan untuk pemantauan dan perbaikan aplikasi.',
            ),
            const SizedBox(height: 16),

            const BulletListItem(
              title: 'Notifikasi',
              text: 'Untuk mengirimkan pemberitahuan tentang pembaruan aplikasi, peringatan penyimpanan data, dan fitur baru jika Anda memilih untuk menerima notifikasi.',
            ),
            SizedBox(height: 20.h),
            _buildPrivacyPolicySection('3. Penggunaan Data Geolokasi', "Aplikasi HEMAQUA dapat meminta izin "
                "untuk mengakses lokasi perangkat Anda untuk menyediakan analisis kualitas air "
                "berbasis lokasi sampel. Kami hanya mengumpulkan data lokasi dalam konteks penggunaan "
                "aplikasi dan hanya setelah mendapatkan izin eksplisit dari Anda. "
                "Anda dapat menonaktifkan izin lokasi kapan saja melalui pengaturan perangkat Anda."),
            _buildPrivacyPolicySection(
              '4. Penyimpanan Data',
              'Kami menyimpan data yang dikumpulkan dari penggunaan aplikasi di server yang aman untuk memungkinkan analisis jangka panjang dan pelaporan. Data ini disimpan dengan cara yang tidak dapat mengidentifikasi Anda secara langsung, kecuali Anda memberikan informasi pribadi melalui formulir atau pendaftaran. Data disimpan selama periode yang diperlukan untuk tujuan pengumpulan data atau hingga Anda menghapus data Anda dari aplikasi.',
            ),

            _buildPrivacyPolicySection(
              '5. Perlindungan Data',
              'Kami berkomitmen untuk melindungi data Anda. Kami menggunakan langkah-langkah keamanan teknis dan organisatoris yang wajar untuk melindungi informasi yang dikumpulkan melalui aplikasi HEMAQUA. Meskipun kami berupaya untuk menjaga keamanan data, tidak ada metode transmisi data melalui internet yang sepenuhnya aman. Oleh karena itu, kami tidak dapat menjamin keamanan mutlak.',
            ),

            _buildPrivacyPolicySection(
              '6. Pengungkapan kepada Pihak Ketiga',
              'Kami tidak menjual, menyewakan, atau mengungkapkan informasi pribadi Anda kepada pihak ketiga tanpa izin Anda, kecuali jika diperlukan oleh hukum atau untuk melindungi hak atau properti kami. Kami dapat berbagi informasi non-pribadi (seperti data penggunaan aplikasi atau statistik) dengan mitra atau penyedia layanan yang membantu kami mengelola aplikasi, tetapi informasi ini tidak akan mengidentifikasi Anda secara pribadi.',
            ),

            _buildPrivacyPolicySection(
              '7. Penggunaan Cookie',
              'Aplikasi HEMAQUA mungkin menggunakan teknologi cookie untuk meningkatkan pengalaman pengguna dan menyediakan layanan yang lebih baik. Cookie adalah file teks kecil yang disimpan di perangkat Anda untuk mengumpulkan informasi mengenai preferensi penggunaan aplikasi. Anda dapat mengontrol pengaturan cookie melalui pengaturan perangkat Anda.',
            ),
            _buildPrivacyPolicySection('8. Hak Pengguna',
                'Anda memiliki hak untuk:'),
            const BulletListItem(
              title: 'Akses dan Perbaikan',
              text: 'Anda dapat mengakses, memperbaiki, atau menghapus data pribadi yang Anda berikan kepada kami melalui aplikasi, jika ada.',
            ),

            const SizedBox(height: 16), // Jarak antar item

            const BulletListItem(
              title: 'Penarikan Persetujuan',
              text: 'Anda dapat menarik izin Anda untuk mengumpulkan data kapan saja melalui pengaturan aplikasi atau perangkat Anda.',
            ),

            const SizedBox(height: 16), // Jarak antar item

            const BulletListItem(
              title: 'Menonaktifkan Notifikasi',
              text: 'Anda dapat memilih untuk tidak menerima notifikasi atau pemberitahuan dari aplikasi kapan saja.',
            ),

            const SizedBox(height: 20),

            _buildPrivacyPolicySection(
              '9. Perubahan pada Kebijakan Privasi',
              'Kami dapat memperbarui kebijakan privasi ini dari waktu ke waktu untuk mencerminkan perubahan dalam praktik pengumpulan data atau perubahan regulasi. Setiap perubahan akan diberitahukan melalui aplikasi, dan kebijakan privasi yang diperbarui akan di posting di halaman ini dengan tanggal pembaruan yang baru.',
            ),
            _buildPrivacyPolicySection(
              '10. Kontak Kami',
              'Jika Anda memiliki pertanyaan mengenai kebijakan privasi ini atau cara kami menangani data pribadi Anda, silakan hubungi kami melalui email di asusmaizar89@gmail.com',
            ),
          ],
        ),
      ),
    );
  }
}