import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hematologi/models/location.dart';

class StationMap extends StatefulWidget {
  const StationMap({super.key});
  @override
  State<StationMap> createState() => _StationMapState();
}

class _StationMapState extends State<StationMap> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  List<Location> stationLocations = Location.getLocations();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Set<Marker> markers = {};
  var userCurrentLocation;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      stationLocations.map((location) =>
          markers.add(
              Marker(
                markerId: MarkerId(location.name),
                position: LatLng(location.latitude, location.longitude),
                infoWindow: InfoWindow(
                  title: location.name,
                  snippet: location.address,
                ), // InfoWindow
              )
          )
      );
    });
    getCurrentLocation().then((value) => goToCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [

        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToCurrentLocation,
        backgroundColor: const Color(0xFF314797),
        foregroundColor: Colors.white,
        child: const Icon(Icons.gps_fixed),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.27,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: Theme.of(context).colorScheme.onPrimary,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ]
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR $error");
    });
    var location = await Geolocator.getCurrentPosition();
    setState(() {
      userCurrentLocation = location;
    });
  }

  Future<void> goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target:
      LatLng(userCurrentLocation.latitude, userCurrentLocation.longitude),
      zoom: 14.4746,
    )));
  }

  Future<void> goToStationLocation(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 18,
            )
        )
    );
  }

}