import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Measures'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Measures for HireArti',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'At HireArti, the security and privacy of our users’ data is our top priority. This document outlines the measures we implement to protect personal data collected on our platform, ensuring compliance with industry standards and safeguarding customer information.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 24.0),
            _buildSectionHeader('Data Storage'),
            SizedBox(height: 8.0),
            Text(
              'All user data on HireArti is securely stored with Firebase, a trusted cloud provider known for its strong security standards. Key measures include:',
              style: TextStyle(fontSize: 16.0),
            ),
            _buildListItem(
              'Industry Compliance:',
              'Firebase complies with major security standards, including SOC 2, GDPR, and ISO 27001, ensuring high-level protection for stored data.',
            ),
            _buildListItem(
              'Data Encryption:',
              'Data is encrypted both in transit and at rest using advanced encryption methods, protecting user data from unauthorized access.',
            ),
            SizedBox(height: 24.0),
            _buildSectionHeader('Data Access Control'),
            SizedBox(height: 8.0),
            Text(
              'We implement strict access controls to ensure that personal data is only accessible by authorized users:',
              style: TextStyle(fontSize: 16.0),
            ),
            _buildListItem(
              'Role-Based Access Control (RBAC):',
              'Our platform uses RBAC to restrict access to data based on user roles, allowing only authorized personnel to access sensitive data.',
            ),
            _buildListItem(
              'Authentication Requirements:',
              'Firebase Authentication is used to verify user identities, adding an additional layer of security to restrict unauthorized data access.',
            ),
            SizedBox(height: 24.0),
            _buildSectionHeader('Encryption Standards'),
            SizedBox(height: 8.0),
            Text(
              'We utilize robust encryption standards to secure data throughout its lifecycle:',
              style: TextStyle(fontSize: 16.0),
            ),
            _buildListItem(
              'HTTPS Encryption:',
              'All data transmitted between users and our servers is protected with HTTPS encryption, preventing data interception during transit.',
            ),
            _buildListItem(
              'Database Encryption:',
              'Sensitive data stored in Firebase is encrypted at rest, ensuring that data remains secure even in the unlikely event of unauthorized access to the database.',
            ),
            SizedBox(height: 24.0),
            Text(
              'Commitment to User Privacy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'We are committed to maintaining the highest level of data privacy for our users. For any questions or further details on our security measures, please contact us at shahanasov@gmail.com.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildListItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.blue, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' $description'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
