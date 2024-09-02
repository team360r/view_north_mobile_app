// main.dart

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:view_north_app/animated_car_park_tile.dart';
import 'package:view_north_app/models/car_park.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appConfig = AppConfiguration(
      'application-0-xmxcohd'); // Replace with your Realm App ID
  final app = App(appConfig);

  // Authenticate anonymously
  await app.logIn(Credentials.anonymous());

  final user = app.currentUser;
  if (user != null) {
    final config = Configuration.flexibleSync(
      user,
      [StaticCarPark.schema],
    );

    final realm = Realm(config);

    // Subscribe to all CarParks or with specific filters
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<StaticCarPark>(),
          name: 'all_carparks');
    });

    // Optionally wait until subscriptions are in a "Complete" state
    await realm.subscriptions.waitForSynchronization();

    runApp(MyApp(realm: realm));
  } else {
    runApp(MyApp(realm: null)); // Handle the case where login fails
  }
}

class MyApp extends StatelessWidget {
  final Realm? realm;

  MyApp({required this.realm});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Car Parks')),
        body: realm != null
            ? StaticCarParkList(realm: realm!)
            : Center(child: Text('Failed to load data')),
      ),
    );
  }
}

class StaticCarParkList extends StatelessWidget {
  final Realm realm;

  StaticCarParkList({required this.realm});

  @override
  Widget build(BuildContext context) {
    final staticCarParks = realm.all<StaticCarPark>();

    return StreamBuilder<RealmResultsChanges<StaticCarPark>>(
      stream: staticCarParks.changes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // final sortedStaticCarParks = snapshot.data!.results.toList()
          //   ..sort((a, b) => a.name.compareTo(b.name));
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

// class StaticCarParkList extends StatelessWidget {
//   final Realm realm;

//   StaticCarParkList({required this.realm});

//   @override
//   Widget build(BuildContext context) {
//     final staticCarParks = realm.all<StaticCarPark>();

//     return StreamBuilder<RealmResultsChanges<StaticCarPark>>(
//       stream: staticCarParks.changes,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           // Convert to list and sort alphabetically by name
//           final sortedStaticCarParks = snapshot.data!.results.toList()
//             ..sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));

//           return ListView.builder(
//             itemCount: sortedStaticCarParks.length,
//             itemBuilder: (context, index) {
//               final staticCarPark = sortedStaticCarParks[index];
//               return ListTile(
//                 title: Text(staticCarPark.name ?? ''),
//                 subtitle: Text(
//                     '${staticCarPark.address}\nStatus: ${staticCarPark.status}'),
//                 trailing: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text('Capacity: ${staticCarPark.capacity}'),
//                     Text('Available: ${staticCarPark.availableSpaces}'),
//                   ],
//                 ),
//               );
//             },
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
