import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/bottom_nav_bar.dart';
import 'package:hematologi/login_page.dart';
import 'package:hematologi/profile/about_us.dart';
import 'package:hematologi/profile/change_password.dart';
import 'package:hematologi/profile/edit_profile.dart';
import 'package:hematologi/profile/help_center.dart';
import 'package:hematologi/profile/privacy_policy.dart';

import '../provider/providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserDoc = ref.watch(userDocStreamProvider);

    return Scaffold(
        backgroundColor: const Color(0xFFEFF6FF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEFF6FF),
          leading: const SizedBox(),
          centerTitle: true,
          title: Text('Profil',
              style: GoogleFonts.poppins(
                  fontSize: 21,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600
              )),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                asyncUserDoc.when(
                    error: (err, stack) => Text('Gagal memuat',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        )),
                    loading: () => Text('',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        )),
                    data: (userDoc) {
                      final data = userDoc.data() as Map<String, dynamic>?;
                      final photoUrl = data?['photo_url'];
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundImage: photoUrl != null ? NetworkImage(photoUrl)
                                : const AssetImage('images/user.png') as ImageProvider,
                            backgroundColor: Colors.white,
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const EditProfile()),
                                    );
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                      ),
                                      child: Image.asset('images/brush.png', scale: 1.5)
                                  )
                              )
                          )
                        ],
                      );
                    }
                ),
                const SizedBox(height: 10),
                asyncUserDoc.when(
                    error: (err, stack) => Text('Gagal memuat',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        )),
                    loading: () => Text('',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                        )),
                    data: (userDoc) {
                      final data = userDoc.data() as Map<String, dynamic>?;
                      final username = data?['username'] ?? '';
                      final email = data?['email'] ?? '';
                      return Column(
                        children: [
                          Text(username,
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600
                              )),
                          Text(email,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              ))
                        ],
                      );
                    }

                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Akun',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500
                          )),
                      const SizedBox(height: 15),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const ChangePasswordPage())
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('images/unlock.png', scale: 2.5),
                                const SizedBox(width: 15),
                                Text('Ubah Password',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ))
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Info Tambahan',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500
                          )),
                      const SizedBox(height: 15),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const HelpCenter()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('images/help_center.png', scale: 2.5),
                                  const SizedBox(width: 15),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Text('Help Center',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500
                                        )),
                                  )
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios)
                            ],
                          )
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('images/privacy_policy.png', scale: 2.5),
                                const SizedBox(width: 15),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text('Kebijakan Privasi',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      )),
                                )
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tim Kami',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500
                          )),
                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AboutUs()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('images/logo_blue.png', scale: 3.5),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Tentang Kami',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500
                                          )),
                                      Text('Kenali visi, misi, dan tim kami',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w600
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios)
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                Center(
                    child: Container(
                        width: double.infinity,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                        child: ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                      (route) => false
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                )
                            ),
                            child: Text('Sign out',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ))
                        )
                    )
                ),
              ],
            )
        )
    );
  }

}