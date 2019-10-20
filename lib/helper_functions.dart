import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'models/models.dart';
import 'package:meta/meta.dart';

Future<Set<Marker>> convertHeatMapItemsToMarkers({
  @required List<HeatMapItem> heatMapItems,
  @required BuildContext context,
}) async {
  Set<Marker> markers = Set();
  BitmapDescriptor icon = await generateIcon();
  for (HeatMapItem heatMapItem in heatMapItems) {
    markers.add(
      Marker(
        markerId: MarkerId(heatMapItem.id),
        position: LatLng(heatMapItem.coordinates.lat, heatMapItem.coordinates.long),
        icon: icon,
        onTap: (){
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: new Text(heatMapItem.details),
            )
          );
        }
      ),
    );
  }
  return markers;
}

Future<BitmapDescriptor> generateIcon() async {
  final ImageConfiguration imageConfiguration = ImageConfiguration(
    devicePixelRatio: window.devicePixelRatio,
  );
  BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
    imageConfiguration,
    'assets/heat_map_icon.png',
  );
  return bitmapDescriptor;
}
