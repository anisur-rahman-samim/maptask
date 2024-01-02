import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maptask/app/modules/location/views/location_view.dart';
import 'package:maptask/common/app_colors/app_colors.dart';


class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Position? position;
  final List<Marker> _markers = [];

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        position = currentPosition;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: position != null
          ? GoogleMap(
              markers: Set<Marker>.of(_markers),
              initialCameraPosition: CameraPosition(
                  target: LatLng(position!.latitude, position!.longitude),
                  zoom: 14),
            )
          : const Center(
              child: CircularProgressIndicator(color: AppColors.mainColor,),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          onPressed: () {
            _markers.add(
              Marker(
                  markerId: const MarkerId('SomeId'),
                  position: LatLng(position!.latitude, position!.longitude),
                  infoWindow: const InfoWindow(title: 'This is your location')),
            );

            setState(() {});
          },
          child: const Icon(Icons.location_on_rounded)),
      bottomNavigationBar: InkWell(
        onTap: () => Get.to(LocationView(position: position)),
        child: Container(
          height: 40,
          width: double.infinity,
          color: AppColors.mainColor,
          child: const Center(
            child: Text(
              "View Your Address",
              style: TextStyle(fontSize: 20, color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
