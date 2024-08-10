import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/bottom/bloc/bloc/bottomnavigation_bloc.dart';
import 'package:freelance/presentation/login/login.dart';
import 'package:freelance/presentation/login/widgets/bloc/toggle_bloc.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ToggleBloc(),
        ),
        BlocProvider(
          create: (context) => BottomNavigationBloc(),
        )
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: 'Freelnce',
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
