// main.dart

import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:view_north_app/animated_car_park_tile.dart';
import 'package:view_north_app/models/car_park.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'car_park_list_screen.dart';
import 'car_park_map_screen.dart';

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

    // Subscribe to all CarParks
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.add(realm.all<StaticCarPark>(),
          name: 'all_carparks');
    });

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
      home: realm != null
          ? CarParkTabGroup(realm: realm!)
          : Scaffold(body: Center(child: Text('Failed to load data'))),
    );
  }
}

class CarParkTabGroup extends StatelessWidget {
  final Realm realm;

  CarParkTabGroup({required this.realm});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Car Parks'),
          bottom: TabBar(
            tabs: [
              Tab(text: "List", icon: Icon(Icons.list)),
              Tab(text: "Map", icon: Icon(Icons.map)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CarParkListScreen(realm: realm),
            CarParkMapScreen(realm: realm),
          ],
        ),
      ),
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
