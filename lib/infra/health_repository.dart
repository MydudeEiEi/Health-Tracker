import 'package:health/health.dart';
import 'package:health_tracker/models/blood_glucose.dart';

class HealthRepository {
  final health = HealthFactory();

  Future<List<BloodGlucose>> getBloodGlucose() async {
    bool requested =
        await health.requestAuthorization([HealthDataType.BLOOD_GLUCOSE]);
    
    if (requested) {
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(const Duration(days: 7)),
          DateTime.now(),
          [HealthDataType.BLOOD_GLUCOSE]);

          print("Health data: $healthData");

      return healthData.map((e) {
        var b = e;
        print(b.value.toJson()['numericValue']);
        return BloodGlucose(
          double.parse(b.value.toJson()['numericValue']),
          b.unitString,
          b.dateFrom,
          b.dateTo,
        );
      }).toList();
    }
    return [];
  }
}
  /*
    Future<void> getData() async {
     // create a HealthFactory for use in the app, choose if HealthConnect should be used or not
    final HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

    // define the types to get
    var types = [
      HealthDataType.STEPS,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.DISTANCE_DELTA,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.MOVE_MINUTES,
    ];

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();

    // fetch health data from the last 24 hours
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      now.subtract(Duration(days: 1)), now, types);

    // request permissions to write steps and blood glucose
    var permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();

    await health.requestAuthorization(types, permissions: permissions);

    // write steps and blood glucose
    bool success = 
        await health.writeHealthData(10, HealthDataType.STEPS, now, now);
    success = await health.writeHealthData(
      3.1, HealthDataType.BLOOD_GLUCOSE, now, now);

    // get the number of steps for today
    var midnight = DateTime(now.year, now.month, now.day);
    int? steps = await health.getTotalStepsInInterval(midnight, now);
    print(health);
  }
  */

