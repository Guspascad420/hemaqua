import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hematologi/guest/guest_main_page.dart';
import 'package:hematologi/home/home_page.dart';
import 'package:hematologi/onboarding/onboarding_page.dart';
import 'create_profile_page.dart';
import 'firebase_options.dart';

enum AuthStatus {
  loggedIn,       // User lama, data ada
  loggedInNew,    // User baru, data belum ada
  loggedOut,      // Belum login sama sekali
  guest           // Login sebagai anonim
}

Future<(AuthStatus, User?)> _checkAuthStatus() async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return (AuthStatus.loggedOut, null);
  }

  if (user.isAnonymous) {
    return (AuthStatus.guest, user);
  }

  try {
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    if (doc.exists) {
      return (AuthStatus.loggedIn, user);
    }
    else {
      return (AuthStatus.loggedInNew, user);
    }
  } catch (e) {
    print('Error checking user data: $e');
    return (AuthStatus.loggedOut, user);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  final (AuthStatus status, User? user) authResult  = await _checkAuthStatus();
  runApp(ProviderScope(child: MyApp(initialStatus: authResult.$1, user: authResult.$2)));
}

class MyApp extends StatelessWidget {
  final AuthStatus initialStatus;
  final User? user;

  const MyApp({super.key, required this.initialStatus, this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget home;
    switch (initialStatus) {
      case AuthStatus.loggedIn:
        home = const HomePage();
        break;
      case AuthStatus.loggedInNew:
        home = CreateProfilePage(user: user!);
        break;
      case AuthStatus.guest:
        home = const GuestMainPage();
        break;
      case AuthStatus.loggedOut:
        home = const OnboardingPage();
        break;
    }

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: true,
            ),
            home: child
        );
      },
      child: home
    );
  }
}
