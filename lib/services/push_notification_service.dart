import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/ui/core/views/feed/pages/step0.dart';
import 'package:spraat/ui/core/views/feed/request_preview/request.dart';
import 'package:stacked_services/stacked_services.dart';

final NavigationService nav = locator<NavigationService>();

class PushNotificationService{
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future initialize() async{
    if(Platform.isIOS){
      // request permision from ios user
      _fcm.requestPermission();
    }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);


    //onMessage
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("This is running in onMessageForeground Function");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android?.smallIcon,
              ),
            ));
      }

      serializeAndNavigate(message);
    });

    //onResume
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("This is running in onMessageOpenedApp Function");
      serializeAndNavigate(message);
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }

  void serializeAndNavigate(RemoteMessage message){
    var notificationData = message.data;
    var view = notificationData['view'];
    var requestId = notificationData['request_id'];
    print(requestId);

    if(view != null){

      if(view == 'preview_request')
      {
        nav.navigateToView(RequestPreview(selectedRequestID: requestId));
      }
    }

  }
}

