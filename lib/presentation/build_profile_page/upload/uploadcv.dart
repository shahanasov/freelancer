import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/db/services/firebase_database.dart';
import 'package:freelance/theme/color.dart';
import '../makingres.dart';
import 'bloc/upload_resume_bloc.dart';

class UploadCv extends StatelessWidget {
  const UploadCv({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadResumeBloc, UploadResumeState>(
      builder: (context, state) {
        if (state is UploadResumeInitial) {
          return Scaffold(
            backgroundColor: black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    Text(
                        "Please upload your resume. We will use to find the right opportunities for you.",
                        style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    Image.asset('assets/images/download.png'),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                const WidgetStatePropertyAll(Size(192, 50)),
                            backgroundColor: WidgetStatePropertyAll(white),
                            foregroundColor: WidgetStatePropertyAll(black)),
                        onPressed: () {
                          context
                              .read<UploadResumeBloc>()
                              .add(UploadingEvent());
                        },
                        child: const Text('Upload Your Resume')),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'or',
                      style: TextStyle(color: white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize:
                                const WidgetStatePropertyAll(Size(192, 50)),
                            backgroundColor: WidgetStatePropertyAll(white),
                            foregroundColor: WidgetStatePropertyAll(black)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const ResposiveBuildProfile()));
                        },
                        child: const Text('Build a Resume')),
                  ],
                ),
              ),
            ),
          );
        } else if (state is UploadingResumeState) {
          return Center(child:  CircularProgressIndicator(
            color: white,
          ));
        } else if (state is UploadedResume) {
          return Scaffold(
            backgroundColor: black,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Resume Uploaded Successfully!',
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${state.resumeModel!.resumeName}',
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 30),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(white),
                        foregroundColor: WidgetStatePropertyAll(black),
                        minimumSize:
                            const WidgetStatePropertyAll(Size(192, 50)),
                      ),
                      onPressed: () {
                        UserDatabaseFunctions().uploadResumetoDb(resumeModel: state.resumeModel!);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ResposiveBuildProfile()));
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Column(
            children: [
              // Text(
              //     "Please upload your resume. We will use to find the right opportunities for you.",
              //     style: TextStyle(
              //         color: white,
              //         fontSize: 18,
              //         fontWeight: FontWeight.w300)),
              Image.asset('assets/images/download.png'),
              TextButton(
                  style: ButtonStyle(
                      minimumSize:
                         const WidgetStatePropertyAll(Size(192, 50)),
                      backgroundColor: WidgetStatePropertyAll(white),
                      foregroundColor: WidgetStatePropertyAll(black)),
                  onPressed: () {
                    context.read<UploadResumeBloc>().add(UploadingEvent());
                  },
                  child: const Text('Try again')),
              const SizedBox(
                height: 20,
              ),
              Text(
                'or',
                style: TextStyle(color: white),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: ButtonStyle(
                      minimumSize:
                          const WidgetStatePropertyAll(Size(192, 50)),
                      backgroundColor: WidgetStatePropertyAll(white),
                      foregroundColor: WidgetStatePropertyAll(black)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ResposiveBuildProfile()));
                  },
                  child: const Text('Build a Resume')),
            ],
          );
        }
      },
    );
  }
}
