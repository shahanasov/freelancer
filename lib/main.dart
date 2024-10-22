import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/services/firebase_auth.dart';
import 'package:freelance/db/services/firebase_database_usersaving_functions.dart';
import 'package:freelance/presentation/bottom_navigation_main/bloc/bloc/bottomnavigation_bloc.dart';
import 'package:freelance/presentation/bottom_navigation_main/bottom_nav.dart';
import 'package:freelance/presentation/build_profile_page/upload/bloc/upload_resume_bloc.dart';
import 'package:freelance/presentation/build_profile_page/upload/uploadcv.dart';
import 'package:freelance/presentation/pages/Home/bloc/home_page_bloc.dart';
import 'package:freelance/presentation/pages/add_post_page/bloc/add_post_bloc.dart';
import 'package:freelance/presentation/pages/message_page/bloc/chatlist_bloc.dart';
import 'package:freelance/presentation/pages/notification_page/bloc/notification_bloc.dart';
import 'package:freelance/presentation/pages/other_users_profile_page/business_logic/bloc/post_related_bloc.dart';
import 'package:freelance/presentation/pages/resume_page/bloc/resume_pdf_bloc.dart';
import 'package:freelance/presentation/pages/search_page/business_logic/bloc/search_bloc.dart';
import 'package:freelance/presentation/widgets/suggestions_widget/bloc/suggestions_widget_bloc.dart';

import 'firebase_options.dart';
import 'presentation/login_page/login_page.dart';
import 'presentation/login_page/widgets/bloc/toggle_bloc.dart';
import 'presentation/pages/profile_page/businesslogin/bloc/profile_page_bloc.dart';

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
          create: (context) => UploadResumeBloc(),
        ),
        BlocProvider(
          create: (context) => ChatListBloc(),
        ),
        BlocProvider(
          create: (context) => AddPostBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => HomePageBloc(),
        ),
        BlocProvider(
          create: (context) => PostRelatedBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (context) => SuggestionsWidgetBloc(),
        ),
        BlocProvider(
          create: (context) => ResumePdfBloc(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        title: 'Freelance',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // all events call
              context.read<ProfilePageBloc>().add(ProfileLoadEvent());
              context.read<HomePageBloc>().add(UsersPostFetchEvent());
              context.read<NotificationBloc>().add(NotificationFetch());

              // context.read<PostRelatedBloc>().add(AllPostsFetchEvent(userId: FirebaseAuth.instance.currentUser!.uid));

              // all events call

              // log((snapshot.data?.email).toString());
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
