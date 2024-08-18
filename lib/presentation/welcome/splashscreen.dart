import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/welcome/businesslogic/bloc/bloc/splash_bloc.dart';

import '../bottomnavigation/bottomnav.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            // Navigate to the home page
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const BottomNav()));
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            if (state is SplashInitial) {
              return const Center(child: Text('Initializing...'));
            } else if (state is SplashLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SplashLoaded) {
              return const Center(child: Text('Loaded!'));
            }
            return Container(); // Fallback UI if needed
          },
        ),
      ),
    );
  }
}
