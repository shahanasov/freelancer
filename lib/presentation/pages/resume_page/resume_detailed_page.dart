import 'package:flutter/material.dart';
import 'package:freelance/db/model/user_details.dart';
import 'package:freelance/presentation/pages/resume_page/resume_pdf.dart';
import 'package:freelance/theme/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResumePage extends StatelessWidget {
  final String userId;
  final UserDetailsModel userDetails;
  const ResumePage(
      {super.key, required this.userDetails, required this.userId});

  @override
  Widget build(BuildContext context) {
      bool isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "${userDetails.firstName}'s Resume",
          style: const TextStyle(fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // About Section
              userDetails.description.isEmpty? SizedBox():
              _buildSectionTitle('About',isDark),
              const SizedBox(height: 8),
               userDetails.description.isEmpty? SizedBox():
              _buildCardWithContent(userDetails.description),

              const SizedBox(height: 20),
              // Personal Information Section
              _buildSectionTitle('Personal Information',isDark),
              const SizedBox(height: 8),
              _buildPersonalInfo(isDark),

              const SizedBox(height: 20),
              // Skills Section
               userDetails.skills.isEmpty? SizedBox():
              _buildSectionTitle('Skills',isDark),
              const SizedBox(height: 8),
               userDetails.skills.isEmpty? SizedBox():
              _buildCardWithContent(userDetails.skills.join(' \n ')),

              const SizedBox(height: 20),
              // Services Section
               userDetails.services.isEmpty? SizedBox():
              _buildSectionTitle('Services',isDark),
              const SizedBox(height: 8),
               userDetails.services.isEmpty? SizedBox():
              _buildCardWithContent(userDetails.services.join(' \n ')),

              const SizedBox(height: 30),
              // PDF Preview
              const PDFPreviewCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title,bool isDark) {
    return Text(
      title,
      style: TextStyle(
        color: isDark? white:black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _buildCardWithContent(String content) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18, height: 1.5),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(bool isDark) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPhone(FontAwesomeIcons.phone, userDetails.phone,isDark),
            _buildInfoRow(FontAwesomeIcons.cakeCandles, userDetails.dob,isDark),
            _buildInfoRow(FontAwesomeIcons.venusMars, userDetails.gender,isDark),
            _buildInfoRow(FontAwesomeIcons.locationDot,
                '${userDetails.city}, ${userDetails.state}, ${userDetails.country}',isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String data,bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: isDark? white:black, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              data,
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhone(IconData icon, int data,bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: isDark? white:black, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              " $data",
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
