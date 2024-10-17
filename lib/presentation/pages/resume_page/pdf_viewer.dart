import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

class PDFViewerPage extends StatelessWidget {
  final File pdfFile;
  final String name;

  const PDFViewerPage({super.key, required this.pdfFile, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: _buildPDFView(),
    );
  }

  Widget _buildPDFView() {
    return FutureBuilder<bool>(
      future: pdfFile.exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            try {
              return SfPdfViewer.file(
                pdfFile,
                // onError: (details) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Error loading PDF: ${details.description}')),
                //   );
                // },
              );
            } catch (e) {
              return Center(
                child: Text('Error opening PDF: $e'),
              );
            }
          } else {
            return const Center(
              child: Text('PDF file not found'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}