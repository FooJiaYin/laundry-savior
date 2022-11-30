import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/global_state.dart';
import '../theme/theme.dart';
import '../views/route.dart';

class NotificationService {
  NotificationService();

  static final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  static Future<void> init(context) async {
    void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload == "current_machine" && GlobalState.instance.currentMachine != null) {
        await Navigator.pushNamed(context, '/current_machine');
      }
    }

    void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
      print('id $id');
    }

    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         requestSoundPermission: true,
    //         requestBadgePermission: true,
    //         requestAlertPermission: true,
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static const defaultAndroidNotificationDetails = AndroidNotificationDetails(
    'your channel id',
    'Laundry Done',
    // channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    color: ThemeColors.royalBlue,
    ongoing: true,
    colorized: true,
  );

  static const machineAvailableNotificationDetails = AndroidNotificationDetails(
    'your channel id',
    'Machine Available',
    // channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    color: ThemeColors.green,
    largeIcon: DrawableResourceAndroidBitmap('notification_available'),
    styleInformation: BigPictureStyleInformation(
      FilePathAndroidBitmap('notification_available'),
    ),
    // colorized: true,
  );

  static const laundryDoneNotificationDetails = AndroidNotificationDetails(
    'your channel id',
    'Laundry Done',
    // channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    color: ThemeColors.coral,
    largeIcon: DrawableResourceAndroidBitmap('notification_overdue'),
    styleInformation: BigPictureStyleInformation(
      FilePathAndroidBitmap('notification_overdue'),
    ),
    // colorized: true,
  );

  static void sampleNotification() async {
    const notificationDetails = NotificationDetails(android: defaultAndroidNotificationDetails);
    await localNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      notificationDetails,
      payload: 'item x',
    );
  }

  static void showNotification({String? title, String? body, String? payload, required AndroidNotificationDetails details}) async {
    var notificationDetails = NotificationDetails(android: details);
    await localNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // void selectNotification(String? payload) {
  //   if (payload != null && payload.isNotEmpty) {
  //     behaviorSubject.add(payload);
  //   }
  // }
}
