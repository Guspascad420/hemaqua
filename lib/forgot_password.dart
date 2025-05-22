import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hematologi/utils/reusableTextField.dart'; // Import FirebaseAuth

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Get an instance of FirebaseAuth
  final TextEditingController _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.sendPasswordResetEmail(email: _emailTextController.text.trim());
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email pengaturan ulang kata sandi terkirim! Periksa kotak masuk Anda'),
            backgroundColor: Colors.green,
          ),
        );
        // Optionally navigate back to login or another screen
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'Tidak ditemukan pengguna untuk email tersebut';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Alamat email tidak valid';
        } else {
          errorMessage = 'Error: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
                  fit: BoxFit.cover)
          ),
          child: Container(
            width: double.infinity,
            margin:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 90),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white
            ),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Column(
                          children: [
                            Image.asset('images/logo_blue.png', scale: 2.5),
                            const SizedBox(height: 15),
                            Text('Lupa kata sandi?',
                                style: GoogleFonts.poppins(
                                    color: Colors.blue[400],
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 15),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  'Masukkan email Anda untuk mendapatkan tautan reset kata sandi.',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  )),
                            )
                          ],
                        )
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
                        child: TextFormField(
                          controller: _emailTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tolong masukkan email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Tolong masukkan alamat email yang valid';
                            }
                            return null;
                          },
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
                    Center(
                        child: Container(
                            width: double.infinity,
                            height: 60,
                            margin:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                            child: ElevatedButton(
                                onPressed: _resetPassword,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : Text('Reset kata sandi',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))))),
                  ]
              ),
            )
          ),
        ),
      )
    );
  }
}