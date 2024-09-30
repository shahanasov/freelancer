import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:freelance/presentation/pages/notification_page/notification_page.dart';

class NotificationFunctions {
  // create an instance of firebase messaging
  final firebaseMessage = FirebaseMessaging.instance;
  // function to initialize notifications
  Future<void> initNotifications() async {
    // request permission from user(will prompt user)
    await firebaseMessage.requestPermission();
    // fetch the FCM token for this device
    final fcmToken = await firebaseMessage.getToken();
    // print the token
    print('Token : $fcmToken');
    initPushNotifications();
  }
  // function to handle recieved messages
  void handleMessage(RemoteMessage? message){
    // if the message is null, fo nothing
    if(message == null){
      return ;
    }
    // navigation
    const NotificationsPage();
  }
  // function to initialize foreground and background ssettings
  Future initPushNotifications()async{
    // handle notification if the was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    //  attach event listeners for when a notification open the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
