import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/functions/firebaseauth.dart';
import 'package:freelance/db/functions/firebasedatabase.dart';
import 'package:freelance/presentation/Buildprofilepage/upload/bloc/upload_resume_bloc.dart';
import 'package:freelance/presentation/Buildprofilepage/upload/uploadcv.dart';
import 'package:freelance/presentation/bottomnavigation/bottomnav.dart';
import 'package:freelance/presentation/login/login.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/businesslogin/bloc/profile_page_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/tabs/bloc/tabs_bloc.dart';
import 'package:freelance/presentation/welcome/businesslogic/bloc/bloc/splash_bloc.dart';
import 'package:freelance/presentation/welcome/splashscreen.dart';

import 'db/functions/firebase_options.dart';
import 'presentation/bottomnavigation/bloc/bloc/bottomnavigation_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Authentication auth = Authentication();
    UserDatabaseFunctions storage = UserDatabaseFunctions();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToggleBloc(auth: auth),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => ProfilePageBloc(auth: auth, storage: storage),
        ),
        BlocProvider(
          create: (context) => SplashBloc(),
          child: const SplashScreen(),
        ),
        BlocProvider(
          create: (context) => TabsBloc(),
          child: Container(),
        ),
        BlocProvider(create: (context)=> UploadResumeBloc(),
        )
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: 'Freelnce',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              log((snapshot.data?.email).toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Or a splash screen
              } else if (snapshot.hasData) {
                return FutureBuilder<bool>(
                  future: isProfileComplete(snapshot.data!.uid),
                  builder: (context, profileSnapshot) {
                    if (profileSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(); // Loading indicator while checking profile
                    } else if (profileSnapshot.data == true) {
                      return const BottomNav(); // Profile exists, navigate to home
                    } else {
                      return const UploadCv(); // Profile doesn't exist, navigate to build profile page
                    }
                  },
                );
              } else {
                return const LoginPage();
              }
            }),
      ),
    );
  }

  Future<bool> isProfileComplete(String userId) async {
    final userProfile = await FirebaseFirestore.instance
        .collection('UsersDetails')
        .doc(userId)
        .get();
    return userProfile.exists;
  }
}
