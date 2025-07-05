import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/add_data.dart';
import 'package:hematologi/library/library_page.dart';
import 'package:hematologi/profile/profile_page.dart';

import 'home/home_page.dart';

class BottomNavBar extends StatelessWidget {
  final BuildContext context;
  final int currentIndex;

  const BottomNavBar({super.key, required this.context, required this.currentIndex});

  void onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const HomePage()
          )
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const AddData()
          )
      );
    } else if (index == 2 && currentIndex != 2) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const LibraryPage()
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      items: [
       const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: Image.asset('images/add_btn.png', scale: 2.5),
            activeIcon: Image.asset('images/active_add_btn.png', scale: 2.5),
            label: 'Tambah'
        ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Pustaka'
        ),
      ],
      selectedItemColor: Colors.blue,
      currentIndex: currentIndex,
      onTap: onItemTapped,
    );
  }
}