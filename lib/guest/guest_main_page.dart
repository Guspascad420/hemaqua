import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/gallery/gallery_category.dart';
import 'package:hematologi/guest/guest_about_us.dart';
import 'package:hematologi/guest/guest_home_page.dart';

import '../login_page.dart';

class GuestMainPage extends StatefulWidget {
  const GuestMainPage({super.key});

  @override
  State<GuestMainPage> createState() => _GuestHomePagState();
}

class _GuestHomePagState extends State<GuestMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    const GuestHomePage(),
    const GuestAboutUs()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBFF),
      appBar: _selectedIndex == 1 ? null : AppBar(
        backgroundColor: const Color(0xFFF4FBFF),
        elevation: 0,
        centerTitle: true,
        title: Text('Selamat datang, Guest!', style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.blue,
            fontSize: 18.sp
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.blue,
            fontSize: 15
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
            color: const Color(0xFFA09CAB),
            fontWeight: FontWeight.w600,
            fontSize: 15
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profil'
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex)
    );
  }

}