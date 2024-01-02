import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maptask/common/app_colors/app_colors.dart';

import '../../../routes/app_pages.dart';

class LocationView extends StatefulWidget {
  Position? position;
  Address? address;
   LocationView({super.key, required this.position});

  @override
  State<LocationView> createState() => _LocationViewState();
}
class _LocationViewState extends State<LocationView> {

  @override
  void initState() {
    getLocationData();
    super.initState();
  }
  getLocationData()async{
    final coordinates =  Coordinates(widget.position!.latitude, widget.position!.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    first = addresses.first;
    setState(() {
      widget.address =  first;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.address != null? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(widget.address!.addressLine.toString(), style: const TextStyle(color: Colors.black,fontSize: 25),),
        )
      ): const Center(
        child: CircularProgressIndicator(color: AppColors.mainColor,),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed(Routes.HOME);
          },
        backgroundColor: AppColors.mainColor,
              child: const Icon(Icons.refresh),
      ),
    );
  }
}
