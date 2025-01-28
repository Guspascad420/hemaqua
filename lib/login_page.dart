import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/home/home_page.dart';
import 'package:hematologi/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool _isLoading = false;
  bool _isButtonActive = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // Add listeners to text controllers
    _emailTextController.addListener(_updateButtonState);
    _passwordTextController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonActive = _emailTextController.text.isNotEmpty &&
          _passwordTextController.text.isNotEmpty;
    });
  }

  void _checkAuthentication() async {
    auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFEFF6FF),
        body: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/blue_gradient.png'),
                        fit: BoxFit.cover)),
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 90),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Column(
                        children: [
                          Image.asset('images/logo_blue.png', scale: 2.5),
                          const SizedBox(height: 15),
                          Text('Mulai Sekarang',
                              style: GoogleFonts.poppins(
                                  color: Colors.blue[400],
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 15),
                          Text(
                              'Buat akun atau login untuk menjelajahi aplikasi kami',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 13,
                              )),
                        ],
                      )),
                      Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFEFF0F6)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/google.png',
                                scale: 2,
                              ),
                              const SizedBox(width: 10),
                              Text('Login dengan Google',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(right: 20),
                              width: 130,
                              child: const Divider(color: Color(0xFFEDF1F3))),
                          const SizedBox(
                            width: 15,
                          ),
                          Text('Atau',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 15,
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 20),
                              width: 130,
                              child: const Divider(color: Color(0xFFEDF1F3))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text('Email',
                            style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _emailTextController,
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFEDF1F3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFEDF1F3)),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                            ),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text('Kata sandi',
                            style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _passwordTextController,
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            obscureText: true,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFEDF1F3)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFFEDF1F3)),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                            ),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text('Lupa kata sandi?',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)))),
                      const SizedBox(height: 15),
                      Center(
                          child: Container(
                              width: double.infinity,
                              height: 60,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                  onPressed: _isButtonActive
                                      ? () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      await auth
                                          .signInWithEmailAndPassword(
                                          email: _emailTextController
                                              .text,
                                          password:
                                          _passwordTextController
                                              .text);
                                      _checkAuthentication();
                                    } on FirebaseAuthException {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  } : null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text('Login',
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))))),
                      const SizedBox(height: 15),
                      Center(
                          child: RichText(
                        text: TextSpan(
                          text: 'Belum punya akun? ',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign up',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()),
                                    );
                                  }),
                          ],
                        ),
                      )),
                      const SizedBox(height: 30),
                    ],
                  ),
                ))));
  }
}
