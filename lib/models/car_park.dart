// models/car_park.realm.dart

import 'package:realm/realm.dart';

part 'car_park.realm.dart'; // The generated file

@RealmModel()
@MapTo('staticCarPark')
class _StaticCarPark {
  @PrimaryKey()
  @MapTo('_id')
  late String id;

  String? address;

  double? availableSpaces;

  double? capacity;

  String? lastUpdated;

  double? latitude;

  double? longitude;

  String? name;

  double? occupancyPercentage;

  String? status;
}
