import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/functions/firebaseauth.dart';
import 'package:freelance/presentation/Buildprofilepage/buildprofile/buildprofile.dart';
import 'package:freelance/presentation/bottomnavigation/bottomnav.dart';
import 'package:freelance/presentation/login/login.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';
import 'package:freelance/presentation/pages/profilepage/businesslogin/bloc/profile_page_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToggleBloc(auth: auth),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        ),
        BlocProvider(
          create: (context) => ProfilePageBloc(auth:auth),
        ),
        BlocProvider(
          create: (context) => SplashBloc(),
          child: const SplashScreen(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: 'Freelnce',
        debugShowCheckedModeBanner: false,
        home: 
        // BuildProfile()
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return const BottomNav();
            }else{
              return const LoginPage();
            }
           
          }
        ),
      ),
    );
  }
}
