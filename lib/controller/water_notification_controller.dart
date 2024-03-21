import 'package:health_tracker/models/water_notification.dart';
import 'package:health_tracker/repository/water_notification_repository.dart';

class WaterNotificationController {
  final WaterNotificationRepository waterNotificationRepository =
      WaterNotificationRepository();

  Future<void> addNewWaterNotification(int hour, int minute) async {
    final String key = '$hour:$minute';
    const String value = 'on';
    await waterNotificationRepository.saveWaterNotification(key, value);
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
  }

  Future<void> deleteWaterNotification(int hour, int minute) async {
    final String key = '$hour:$minute';
    await waterNotificationRepository.deleteWaterNotification(key);
  }
}
