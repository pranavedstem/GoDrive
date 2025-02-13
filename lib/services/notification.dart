import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title : ${message.notification?.title}');
    print('Body : ${message.notification?.body}');
    print('payload : ${message.data}');
}


class FirebaseNotification {
  final _firebaseMessaging =FirebaseMessaging.instance;
   
   Future<void> initNotifications() async {
      await _firebaseMessaging.requestPermission();
      final fcmToken = await _firebaseMessaging.getToken();
      print('Token : $fcmToken');
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

}
}