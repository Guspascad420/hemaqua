import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/blue_gradient.png'),
                  fit: BoxFit.cover
              )
          ),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 90),
            decoration: const BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(20)),
               color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blue
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text('Sign Up',
                          style: GoogleFonts.poppins(
                              color: Colors.blue[400],
                              fontSize: 30,
                              fontWeight: FontWeight.w500
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text('Username',
                      style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _usernameTextController,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        fillColor: Colors.white,
                      ),
                    )
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text('Email',
                      style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _emailTextController,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        fillColor: Colors.white,
                      ),
                    ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text('Password',
                      style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      )),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordTextController,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(width: 1, color: Color(0xFFEDF1F3)),
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        fillColor: Colors.white,
                      ),
                    )
                ),
                const SizedBox(height: 30),
                Center(
                    child: Container(
                        width: double.infinity,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                )
                            ),
                            child: Text('Register',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ))
                        )
                    )
                ),
                const SizedBox(height: 15),
                Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style:  GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 18,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Login',
                              style: const TextStyle(fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                  );
                                }
                          ),
                        ],
                      ),
                    )
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

}