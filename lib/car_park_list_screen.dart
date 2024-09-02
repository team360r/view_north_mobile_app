import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:view_north_app/models/car_park.dart';
import 'animated_car_park_tile.dart';
// import 'static_car_park_model.dart';

class CarParkListScreen extends StatelessWidget {
  final Realm realm;

  CarParkListScreen({required this.realm});

  @override
  Widget build(BuildContext context) {
    final staticCarParks = realm.all<StaticCarPark>();

    return StreamBuilder<RealmResultsChanges<StaticCarPark>>(
      stream: staticCarParks.changes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final sortedStaticCarParks = snapshot.data!.results.toList()
            ..sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));

          return ListView.builder(
            itemCount: sortedStaticCarParks.length,
            itemBuilder: (context, index) {
              final staticCarPark = sortedStaticCarParks[index];
              return AnimatedCarParkTile(carPark: staticCarPark);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
