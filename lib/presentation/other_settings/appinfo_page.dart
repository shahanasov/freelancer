import 'package:flutter/material.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About SkillVerse'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Name
            Text(
              'SkillVerse',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),

            // App Description
            Text(
              'SkillVerse is a dynamic freelancing platform designed to connect businesses and individuals with top-notch independent contractors and agencies. It offers a seamless marketplace where employers can efficiently find talent for various projects. Whether you’re a client looking for skilled freelancers or a freelancer seeking projects, SkillVerse provides a platform to make collaboration easy and secure.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Features
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Talent Marketplace: Explore a wide range of freelancers and agencies across different industries.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Communication & Collaboration Tools: Built-in tools to facilitate smooth communication and collaboration between clients and freelancers.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Secure Payment System: Manage project payments securely through the platform.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Profile Customization: Users can create and customize their profiles to showcase their skills and past projects.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Job Posting & Application: Employers can post jobs, and freelancers can apply, ensuring a streamlined project matching process.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            // Technology Stack
            Text(
              'Technology Stack:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Frontend: Flutter, providing a fast and responsive cross-platform user experience.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- State Management: BLoC (Business Logic Component) for efficient UI and state handling.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Backend: Firebase for reliable and scalable cloud infrastructure.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Database: Firestore, used for storing and managing data related to users, job postings, and more.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Authentication: Firebase Authentication ensures secure login, with role-based access control for different users (employers, freelancers, and admins).',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
