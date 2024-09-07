import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/theme/color.dart';

import '../buildprofile/buildprofile.dart';
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
                                MaterialStateProperty.all(const Size(192, 50)),
                            backgroundColor: MaterialStateProperty.all(white),
                            foregroundColor: MaterialStatePropertyAll(black)),
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
                                MaterialStateProperty.all(const Size(192, 50)),
                            backgroundColor: MaterialStateProperty.all(white),
                            foregroundColor: MaterialStatePropertyAll(black)),
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
          return const CircularProgressIndicator();
        } else if (state is UploadedResume) {
          // final url = state.resumeModel!.resumepath!;
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
                      '${state.resumeModel!.resumename}',
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 30),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(white),
                        foregroundColor: MaterialStatePropertyAll(black),
                        minimumSize:
                            MaterialStateProperty.all(const Size(192, 50)),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BuildProfile()));
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
                          MaterialStateProperty.all(const Size(192, 50)),
                      backgroundColor: MaterialStateProperty.all(white),
                      foregroundColor: MaterialStatePropertyAll(black)),
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
                          MaterialStateProperty.all(const Size(192, 50)),
                      backgroundColor: MaterialStateProperty.all(white),
                      foregroundColor: MaterialStatePropertyAll(black)),
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
