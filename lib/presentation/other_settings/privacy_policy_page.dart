import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: privacyText,
        ),
      ),
    );
  }
}

List<Widget> privacyText = const [
  Text(
    'Privacy Policy for SkillVerse',
    style: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  SizedBox(height: 16.0),
  Text(
    'Effective Date: 25 october 2024',
    style: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  SizedBox(height: 16.0),
  Text(
    'SkillVerse we committed to protecting your privacy. This Privacy Policy outlines how we collect, use, disclose, and safeguard your information when you use our job portal application "SkillVerse". By using the App, you consent to the data practices described in this policy.',
    style: TextStyle(fontSize: 16.0),
  ),
  SizedBox(height: 16.0),
  Text(
    '1. Information We Collect',
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  SizedBox(height: 8.0),
  Text(
    "Personal Information: \nWhen you register for an account, create a profile, or apply for jobs, we may collect personal information, including but not limited to: \n- Name \n- Email address \n- Phone number \n- Resume/CV \n- Profile picture \n- Location (if you enable this feature) \n- Job preferences (e.g., desired position, salary expectations)",
    style: TextStyle(fontSize: 16.0),
  ),
  SizedBox(height: 16.0),
  Text(
    'Non-Personal Information: \nWe may also collect non-personal information automatically when you interact with the App, such as: \n- Device information (e.g., device type, operating system) \n- IP address \n- Usage data (e.g., time spent on the App, pages visited)',
    style: TextStyle(fontSize: 16.0),
  ),
  SizedBox(height: 16.0),
  Text(
    '2. How We Use Your Information',
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  SizedBox(height: 8.0),
  Text(
    'We may use the information we collect for various purposes, including: \n- To create and manage your account and profile \n- To facilitate job searches and applications \n- To match users with relevant job opportunities \n- To communicate with you about job postings, applications, and other updates \n- To analyze user behavior and improve our App \n- To detect, prevent, and address technical issues and fraud',
    style: TextStyle(fontSize: 16.0),
  ),
  // Add more sections as needed...
  SizedBox(height: 16.0),
  // Section 3: Sharing Your Information
            Text(
              '3. Sharing Your Information',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We do not sell, trade, or otherwise transfer your personal information to outside parties except in the following circumstances:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Employers and Recruiters: We may share your profile and application information with potential employers and recruiters who use our platform to find candidates.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Service Providers: We may share your information with third-party service providers who assist us in operating our App, conducting our business, or servicing you.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Legal Compliance: We may disclose your information when required to do so by law or in response to valid requests by public authorities (e.g., a court or government agency).',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Business Transfers: In the event of a merger, acquisition, or asset sale, your personal information may be transferred.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Section 4: Data Security
            Text(
              '4. Data Security',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We implement reasonable security measures to protect your information from unauthorized access, use, or disclosure. However, please note that no method of transmission over the Internet or method of electronic storage is completely secure, and we cannot guarantee its absolute security.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Section 5: Your Rights
            Text(
              '5. Your Rights',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Depending on your location, you may have the following rights regarding your personal information:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '- The right to access your personal information',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- The right to rectify inaccurate or incomplete personal information',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- The right to request the deletion of your personal information',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- The right to restrict or object to the processing of your personal information',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'To exercise these rights, please contact us at [Insert Contact Email].',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Section 6: Children's Privacy
            Text(
              '6. Children\'s Privacy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Our App is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete such information.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Section 7: Changes to This Privacy Policy
            Text(
              '7. Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are encouraged to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
              style: TextStyle(fontSize: 16.0),
            ),
             SizedBox(height: 16.0),
  Text(
    '8. Contact Us',
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  SizedBox(height: 8.0),
  Text(
    'If you have any questions about this Privacy Policy or our data practices, please contact us at: \n- Email: shahanasov@gmail.com ',
    style: TextStyle(fontSize: 16.0),
  ),
];
