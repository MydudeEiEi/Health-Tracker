class WaterNotification {
  final String hour;
  final String minute;
  final String state;

  const WaterNotification({
    required this.hour,
    required this.minute,
    required this.state,
  });

  factory WaterNotification.fromJson(Map<String, dynamic> doc) {
    return WaterNotification(
      hour: doc['hour'],
      minute: doc['minute'],
      state: doc['state'],
    );
  }
}
