import 'package:flutter/material.dart';
import 'package:freelance/presentation/bottom_navigation_main/bottom_nav.dart';
import 'package:freelance/presentation/login_page/login_page.dart';
import 'package:freelance/theme/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashScreenProcess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Image.asset(
          "assets/images/splashLogo.png",
          height: 200,
          width: 200,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  Future<void> _startSplashScreenProcess() async {
    // try {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNav(),
      ),
    );
    // }
  }

  // Future<bool> isProfileComplete(String userId) async {
  //   final userProfile = await FirebaseFirestore.instance
  //       .collection('UsersDetails')
  //       .doc(userId)
  //       .get();
  //   return userProfile.exists;
  // }
}

// Create a wrapper for the main screen that handles auth state
// class MainScreenWrapper extends StatelessWidget {
//   const MainScreenWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }

//         if (!snapshot.hasData) {
//           return const LoginPage();
//         }

//         return const BottomNav();
//       },
//     );
//   }
// }
