import 'package:flutter/material.dart';

// UI for Notification Page
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return BlocProvider(
    //   create: (context) => NotificationBloc(),
    //   child: SafeArea(
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title:  Text(
    //           'Notifications',
    //           style: TextStyle(
    //             color: white,
    //             // fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //         centerTitle: false,
    //       ),
    //       body: BlocConsumer<NotificationBloc, NotificationState>(
    //         listener: (context, state) {
    //           if (state is NotificationPermissionGranted) {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(content: Text('Notification permission granted')));
    //           } else if (state is NotificationPermissionDenied) {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(content: Text('Notification permission denied')));
    //           } else if (state is NotificationSentSuccess) {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(content: Text('Notification sent successfully')));
    //           } else if (state is NotificationSentFailure) {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(content: Text('Failed to send notification')));
    //           }
    //         },
    //         builder: (context, state) {
    //           // Example static data for notifications, you should fetch from Firestore instead
    //           final notifications = [
    //             {
    //               'profileImageUrl': 'https://via.placeholder.com/150',
    //               'title': 'JohnDoe started following you',
    //               'timestamp': '2 min ago',
    //             },
    //             {
    //               'profileImageUrl': 'https://via.placeholder.com/150',
    //               'title': 'JaneDoe sent you a message',
    //               'timestamp': '10 min ago',
    //             },
    //             {
    //               'profileImageUrl': 'https://via.placeholder.com/150',
    //               'title': 'MarkSmith started following you',
    //               'timestamp': '1 hour ago',
    //             },
    //           ];
        
    //           return Padding(
    //             padding: const EdgeInsets.all(10.0),
    //             child: ListView.separated(separatorBuilder: (context, index) {
    //             return  const Divider(thickness: 1,);
    //             },
    //               itemCount: notifications.length,
    //               itemBuilder: (context, index) {
    //                 final notification = notifications[index];
    //                 return NotificationItem(
    //                   profileImageUrl: notification['profileImageUrl']!,
    //                   title: notification['title']!,
    //                   timestamp: notification['timestamp']!,
    //                 );
    //               },
    //             ),
    //           );
    //         },
    // //       ),
    //     ),
    //   ),
    // );
  }
}

// UI component for individual notification item
class NotificationItem extends StatelessWidget {
  final String profileImageUrl;
  final String title;
  final String timestamp;

  const NotificationItem({
    required this.profileImageUrl,
    required this.title,
    required this.timestamp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profileImageUrl),
            radius: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timestamp,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options, like mute notifications, etc.
            },
          ),
        ],
      ),
    );
  }
}
