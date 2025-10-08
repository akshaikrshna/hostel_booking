import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
final _firebaeMessaging = FirebaseMessaging.instance;

Future<void> initNotifications()async{
  await _firebaeMessaging.requestPermission();
  final fCMToken = await _firebaeMessaging.getToken();
  print('Token:$fCMToken');
}
}