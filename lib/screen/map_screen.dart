import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function(String) onLocationSelected;
  const MapScreen({super.key, required this.onLocationSelected});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController; //Controller for the Google map
  LatLng? _lastMapPosition;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); //Request permission on init
  }

  //Fetch the current location
  Future<void> _getCurrentLocation() async {
    //Check if location services are enabled
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _lastMapPosition = LatLng(position.latitude, position.longitude);
    });
    mapController.animateCamera(CameraUpdate.newLatLng(_lastMapPosition!));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_lastMapPosition != null) {
      setState(() {
        mapController.animateCamera(CameraUpdate.newLatLng(_lastMapPosition!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        buildingsEnabled: true,
        trafficEnabled: true,
        zoomControlsEnabled: true,
        rotateGesturesEnabled: true,
        mapToolbarEnabled: true,

        //on below line setting compas enabled.
        compassEnabled: true,
        onMapCreated: _onMapCreated,
        //mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _lastMapPosition ?? const LatLng(0.0, 0.0),
          zoom: 20.0,
        ),
        markers: {
          if (_lastMapPosition != null)
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: _lastMapPosition!,
            )
        },
        onTap: (position) {
          setState(() {
            _lastMapPosition = position;
          });
        },
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if (_lastMapPosition != null) {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  _lastMapPosition!.latitude,
                  _lastMapPosition!.longitude,
                );
                if (placemarks.isNotEmpty) {
                  Placemark place = placemarks[0];
                  String fullAddress =
                      "${place.name}, ${place.subLocality},${place.locality},${place.postalCode}, ${place.country}";
                  widget.onLocationSelected(fullAddress);
                } else {
                  widget.onLocationSelected("No address found");
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
