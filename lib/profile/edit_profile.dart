import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/components/reusable_profle_input.dart';
import 'package:intl/intl.dart';
import '../provider/providers.dart';

class EditProfile extends ConsumerWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserDoc = ref.watch(userDocStreamProvider);
    final uid = ref.watch(authStateProvider).asData?.value?.uid;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        centerTitle: true,
        title: Text('Edit Profil',
            style: GoogleFonts.poppins(
                fontSize: 21.sp,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      body: asyncUserDoc.when(
        error: (err, stack) => Text('Gagal memuat',
            style: GoogleFonts.poppins(
              fontSize: 15,
            )),
        loading: () => const CircularProgressIndicator(),
        data: (userDoc) {
          final data = userDoc.data() as Map<String, dynamic>;
          DateFormat format = DateFormat("dd/MM/yyyy");
          return ReusableProfileInput(
            initialPhotoUrl: data['photo_url'] ?? '',
            initialUsername: data['username'] ?? '',
            initialInsitution: data['institution'] ?? '',
            initialGender: data['gender'],
            initialDate: data['date_of_birth'] == null ? null : format.parse(data['date_of_birth']),
            onSave: (username, institution, [dateOfBirth, selectedGender, imageFile]) async {
              String finalPhotoUrl = '';
              if (imageFile != null) {
                finalPhotoUrl = await ref.read(databaseServiceProvider).uploadProfilePicture(
                    file: imageFile,
                    uid: uid!
                );
              } else {
                finalPhotoUrl = data['photo_url'] ?? '';
              }

              Map<String, dynamic> userDataMap = {
                'username': username,
                'institution': institution,
                'gender': selectedGender ?? '',
                'photo_url': finalPhotoUrl,
                'date_of_birth': dateOfBirth
              };
              await ref
                  .read(databaseServiceProvider)
                  .updateUserProfile(uid!, userDataMap);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil berhasil diperbarui!'),
                    backgroundColor: Colors.blue),
              );
              Navigator.of(context).pop();
            },
          );
        },
      )
    );
  }

}