import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/resume_page/bloc/resume_pdf_bloc.dart';
import 'package:freelance/presentation/pages/resume_page/pdf_viewer.dart';

class PDFPreviewCard extends StatelessWidget {
  const PDFPreviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResumePdfBloc, ResumePdfState>(
      builder: (context, state) {
        if (state is ResumeLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.picture_as_pdf,
                    size: 40, color: Colors.red),
                title: Text(state.resume.resumeName!),
                subtitle: const Text('pageCount pages • pdfSize • PDF'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerPage(
                        name: state.resume.resumeName!,
                        pdfFile: File(state.resume.resumeUrl!)),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
