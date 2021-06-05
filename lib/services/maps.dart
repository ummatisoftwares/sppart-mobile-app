import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spraat/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class Maps extends StatefulWidget {
  const Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  List<Marker> _markers = [];
  Position location;
  bool loadingLocation = false;
  final snackbar = locator<SnackbarService>();
  Completer<GoogleMapController> _controller = Completer();


  @override
  Widget build(BuildContext context) {

    void _handleTap(LatLng latLng){
      setState(() {
        _markers = [];
        _markers.add(
            Marker(
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                markerId: MarkerId("0"),
                position: LatLng(latLng.latitude,latLng.longitude),
                draggable: true,
                onDragEnd: (dragEndPosition){
                  print(dragEndPosition);
                },
            ));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(26.0667,50.5577),
            zoom: 11,
        ),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: Set.from(_markers),
        onTap: _handleTap,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _currentLocation,
              child: Icon(Icons.my_location),
            ),
            SizedBox(
              height: 10,
            ),
            _markers.isEmpty? Container() :
            FloatingActionButton.extended(
              onPressed: (){
                LatLng latLng = LatLng(_markers[0].position.latitude, _markers[0].position.longitude);
                Navigator.pop(context, latLng);
              },
              label: Text("Add Location"),
              icon: Icon(Icons.done_all),
            ),
          ]
      )
    );
  }

  void _currentLocation() async {
    await askPosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(location.latitude, location.longitude),
        zoom: 17.0,
      ),
    ));
  }


  Future determinePosition() async {
    //loadingLocation = true;
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loadingLocation = false;
      //Geolocator.requestPermission();
      snackbar.showSnackbar(message: "Location services are disabled.");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      loadingLocation = false;
      snackbar.showSnackbar(
          message:
          "Location permissions are permantly denied, we cannot request permissions");
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        loadingLocation = false;
        snackbar.showSnackbar(
            message: "  'Location permissions are denied (actual value: $permission).");
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    location = await Geolocator.getCurrentPosition().catchError((onError) {
      loadingLocation = false;
    });
    loadingLocation = false;
    setState(() {
      print(location);
    });
  }

  askPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loadingLocation = false;
      permission = await Geolocator.requestPermission();
      if(permission != LocationPermission.whileInUse && permission != LocationPermission.always)
        {
          snackbar.showSnackbar(
              message: "Location service is not enabled");
          return Future.error(
              'Location service is not enabled');
        }
      else{
        location = await Geolocator.getCurrentPosition().catchError((onError) {
          loadingLocation = false;
        });
        loadingLocation = false;
        setState(() {
          print(location);
        });
      }
    }

  }

}
