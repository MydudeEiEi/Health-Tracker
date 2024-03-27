import 'package:health_tracker/models/water_notification.dart';
import 'package:health_tracker/repository/water_notification_repository.dart';
import 'package:health_tracker/utils/notification_service.dart';

class WaterNotificationController {
  final WaterNotificationRepository waterNotificationRepository =
      WaterNotificationRepository();

  Future<void> addNewWaterNotification(int hour, int minute) async {
    final String key = '$hour:$minute';
    const String value = 'on';
    await waterNotificationRepository.saveWaterNotification(key, value);

    DateTime now = DateTime.now();
    if (now.hour > hour || (now.hour == hour && now.minute > minute)) {
      now = now.add(const Duration(days: 1));
    }

    NotificationService().scheduleNotification(
        id: hour * 100 + minute,
        title: 'Stay hydrated!',
        body: '💧 It is time to drink some water!',
        scheduledNotificationDateTime:
            DateTime(now.year, now.month, now.day, hour, minute));
  }

  Future<void> cancelNotification(int hour, int minute) async {
    await NotificationService().cancelNotification(hour * 100 + minute);
  }

  Future<List<WaterNotification>> getWaterNotifications() async {
    final allNotification =
        await waterNotificationRepository.getWaterNotifications();
    allNotification.sort((a, b) {
      if (a.hour == b.hour) {
        return int.parse(a.minute).compareTo(int.parse(b.minute));
      } else {
        return int.parse(a.hour).compareTo(int.parse(b.hour));
      }
    });
    return allNotification;
  }

  Future<void> chageWaterNotificationState(
      int hour, int minute, bool isOn) async {
    final String key = '$hour:$minute';
    String value = isOn ? 'on' : 'off';
    await waterNotificationRepository.saveWaterNotification(key, value);
    if (isOn) {
      DateTime now = DateTime.now();
      NotificationService().scheduleNotification(
          id: hour * 100 + minute,
          title: 'Stay hydrated!',
          body: '💧 It is time to drink some water!',
          scheduledNotificationDateTime:
              DateTime(now.year, now.month, now.day + 1, hour, minute));
    } else {
      await NotificationService().cancelNotification(hour * 100 + minute);
    }
  }

  Future<void> deleteWaterNotification(int hour, int minute) async {
    final String key = '$hour:$minute';
    await waterNotificationRepository.deleteWaterNotification(key);
    await NotificationService().cancelNotification(hour * 100 + minute);
  }
}
