import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nfc/package/service/permission_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class MapsService {

  Set<Marker> markers = {};

  void setMarker(Position pos) {
    markers.add(
      Marker(
        markerId: const MarkerId("current"),
        position: LatLng(pos.latitude, pos.longitude),
      ),
    );
  }
}
