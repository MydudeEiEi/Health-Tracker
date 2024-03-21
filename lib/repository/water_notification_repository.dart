import 'package:health_tracker/models/water_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterNotificationRepository {
  waterPrefs() => SharedPreferences.getInstance();

  Future<void> saveWaterNotification(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    const prefix = 'water-notification:';
    prefs.setString(prefix + key, value);
  }

  Future<List<WaterNotification>> getWaterNotifications() async {
    final prefs = await waterPrefs();
    final List<WaterNotification> notifications = [];
    final keys = prefs
        .getKeys()
        .where((String element) => element.startsWith('water-notification:'));
    for (final String? key in keys) {
      final dynamic value = prefs.getString(key);
      if (value != null) {
        List<String> time = key!.split(":");
        notifications.add(WaterNotification.fromJson(
            {'hour': time[1], 'minute': time[2], 'state': value}));
      }
    }
    return notifications;
  }

  Future<void> deleteWaterNotification(String key) async {
    final prefs = await waterPrefs();
    const prefix = 'water-notification:';
    prefs.remove(prefix + key);
  }
}
