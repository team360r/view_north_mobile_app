import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:view_north_app/models/car_park.dart';
import 'package:realm/realm.dart';

class CarParkMapScreen extends StatefulWidget {
  final Realm realm;

  CarParkMapScreen({required this.realm});

  @override
  _CarParkMapScreenState createState() => _CarParkMapScreenState();
}

class _CarParkMapScreenState extends State<CarParkMapScreen> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    final staticCarParks = widget.realm.all<StaticCarPark>();

    setState(() {
      _markers.addAll(staticCarParks.map((carPark) => Marker(
            markerId: MarkerId(carPark.id),
            position: LatLng(carPark.latitude ?? 0, carPark.longitude ?? 0),
            infoWindow: InfoWindow(
              title: carPark.name,
              snippet: 'Available Spaces: ${carPark.availableSpaces}',
            ),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(54.978252, -1.617439), // Centered on Newcastle upon Tyne
        zoom: 14,
      ),
      markers: _markers,
    );
  }
}
