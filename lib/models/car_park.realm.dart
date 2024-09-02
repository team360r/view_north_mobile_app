// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_park.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class StaticCarPark extends _StaticCarPark
    with RealmEntity, RealmObjectBase, RealmObject {
  StaticCarPark(
    String id, {
    String? address,
    double? availableSpaces,
    double? capacity,
    String? lastUpdated,
    double? latitude,
    double? longitude,
    String? name,
    double? occupancyPercentage,
    String? status,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'availableSpaces', availableSpaces);
    RealmObjectBase.set(this, 'capacity', capacity);
    RealmObjectBase.set(this, 'lastUpdated', lastUpdated);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'occupancyPercentage', occupancyPercentage);
    RealmObjectBase.set(this, 'status', status);
  }

  StaticCarPark._();

  @override
  String get id => RealmObjectBase.get<String>(this, '_id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get address =>
      RealmObjectBase.get<String>(this, 'address') as String?;
  @override
  set address(String? value) => RealmObjectBase.set(this, 'address', value);

  @override
  double? get availableSpaces =>
      RealmObjectBase.get<double>(this, 'availableSpaces') as double?;
  @override
  set availableSpaces(double? value) =>
      RealmObjectBase.set(this, 'availableSpaces', value);

  @override
  double? get capacity =>
      RealmObjectBase.get<double>(this, 'capacity') as double?;
  @override
  set capacity(double? value) => RealmObjectBase.set(this, 'capacity', value);

  @override
  String? get lastUpdated =>
      RealmObjectBase.get<String>(this, 'lastUpdated') as String?;
  @override
  set lastUpdated(String? value) =>
      RealmObjectBase.set(this, 'lastUpdated', value);

  @override
  double? get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double?;
  @override
  set latitude(double? value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double? get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double?;
  @override
  set longitude(double? value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  double? get occupancyPercentage =>
      RealmObjectBase.get<double>(this, 'occupancyPercentage') as double?;
  @override
  set occupancyPercentage(double? value) =>
      RealmObjectBase.set(this, 'occupancyPercentage', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  Stream<RealmObjectChanges<StaticCarPark>> get changes =>
      RealmObjectBase.getChanges<StaticCarPark>(this);

  @override
  Stream<RealmObjectChanges<StaticCarPark>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<StaticCarPark>(this, keyPaths);

  @override
  StaticCarPark freeze() => RealmObjectBase.freezeObject<StaticCarPark>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      '_id': id.toEJson(),
      'address': address.toEJson(),
      'availableSpaces': availableSpaces.toEJson(),
      'capacity': capacity.toEJson(),
      'lastUpdated': lastUpdated.toEJson(),
      'latitude': latitude.toEJson(),
      'longitude': longitude.toEJson(),
      'name': name.toEJson(),
      'occupancyPercentage': occupancyPercentage.toEJson(),
      'status': status.toEJson(),
    };
  }

  static EJsonValue _toEJson(StaticCarPark value) => value.toEJson();
  static StaticCarPark _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        '_id': EJsonValue id,
      } =>
        StaticCarPark(
          fromEJson(id),
          address: fromEJson(ejson['address']),
          availableSpaces: fromEJson(ejson['availableSpaces']),
          capacity: fromEJson(ejson['capacity']),
          lastUpdated: fromEJson(ejson['lastUpdated']),
          latitude: fromEJson(ejson['latitude']),
          longitude: fromEJson(ejson['longitude']),
          name: fromEJson(ejson['name']),
          occupancyPercentage: fromEJson(ejson['occupancyPercentage']),
          status: fromEJson(ejson['status']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(StaticCarPark._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, StaticCarPark, 'staticCarPark', [
      SchemaProperty('id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('address', RealmPropertyType.string, optional: true),
      SchemaProperty('availableSpaces', RealmPropertyType.double,
          optional: true),
      SchemaProperty('capacity', RealmPropertyType.double, optional: true),
      SchemaProperty('lastUpdated', RealmPropertyType.string, optional: true),
      SchemaProperty('latitude', RealmPropertyType.double, optional: true),
      SchemaProperty('longitude', RealmPropertyType.double, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('occupancyPercentage', RealmPropertyType.double,
          optional: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
