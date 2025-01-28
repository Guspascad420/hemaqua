import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/bottom_nav_bar.dart';
import 'package:hematologi/profile/about_us.dart';
import 'package:hematologi/profile/edit_profile.dart';
import 'package:hematologi/profile/help_center.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        leading: const SizedBox(),
        centerTitle: true,
        title: Text('Profile',
            style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.blue,
                fontWeight: FontWeight.w600
            )),
      ),
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 2, user: {},),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('images/user.png', scale: 2),
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
            ),
            const SizedBox(height: 10),
            Text(user["username"],
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600
                )),
            Text(user["email"],
                style: GoogleFonts.poppins(
                  fontSize: 15,
                )),
            const SizedBox(height: 10),
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
                  Text('Detail',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500
                      )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Institution', style: GoogleFonts.poppins(fontSize: 15)),
                      Text('Brawijaya University',
                          style: GoogleFonts.poppins(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gender', style: GoogleFonts.poppins(fontSize: 15)),
                      Text('Male',
                          style: GoogleFonts.poppins(fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date of Birth', style: GoogleFonts.poppins(fontSize: 15)),
                      Text('2023-1-29',
                          style: GoogleFonts.poppins(fontSize: 15)),
                    ],
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
                  Text('Account',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500
                      )),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('images/unlock.png', scale: 2.5),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Change Password',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  )),
                              Text('Lorem ipsum dolor sit amet',
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
                  Text('Additional Info',
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Help Center',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    )),
                                Text('Lorem ipsum dolor sit amet',
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('images/privacy_policy.png', scale: 2.5),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Privacy Policy',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  )),
                              Text('Lorem ipsum dolor sit amet',
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
                  Text('Our Team',
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
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.blue
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                Text('About Us',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    )),
                                Text('Lorem ipsum dolor sit amet',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600
                                    )),
                              ],
                            )
                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Icon(Icons.arrow_forward_ios)
                        )
                      ],
                    )
                  ),
                  const SizedBox(height: 20),
                  Text('Or find us at',
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset('images/facebook.png', scale: 2.5),
                      const SizedBox(width: 10),
                      Image.asset('images/linkedin.png', scale: 2.5)
                    ],
                  )
                ],
              ),
            ),
            Center(
                child: Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                    child: ElevatedButton(
                        onPressed: (){
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) => const HomePage()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
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