import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_profle_input.dart';
import 'package:hematologi/provider/providers.dart';

import 'home/home_page.dart';

class CreateProfilePage extends ConsumerWidget {
  final User user;
  const CreateProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        title: Text('Lengkapi Profilmu',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ReusableProfileInput(
          onSave: (username, institution, [dateOfBirth, selectedGender, imageFile]) async {
            String finalPhotoUrl = '';
            if (imageFile != null) {
              finalPhotoUrl = await ref.read(databaseServiceProvider).uploadProfilePicture(
                  file: imageFile,
                  uid: user.uid
              );
            } else {
              finalPhotoUrl = user.photoURL ?? '';
            }

            Map<String, dynamic> userDataMap = {
              'username': username,
              'email': user.email ?? '',
              'institution': institution,
              'gender': selectedGender ?? '',
              'photo_url': finalPhotoUrl,
              'date_of_birth': dateOfBirth,
              'hematologi_species_in_cart': [],
              'hemosit_species_in_cart': [],
              'favorite_species': [],
              'calculation_results': [],
            };
            ref.read(databaseServiceProvider).createNewUser(userDataMap, user.uid);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage())
            );
          },
        )
      )
    );
  }
}