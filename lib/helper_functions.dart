import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'models/models.dart';
import 'package:meta/meta.dart';

Future<Set<Marker>> convertHeatMapItemsToMarkers({
  @required List<HeatMapItem> heatMapItems,
}) async {
  Set<Marker> markers = Set();
  BitmapDescriptor icon = await generateIcon();
  for (HeatMapItem heatMapItem in heatMapItems) {
    markers.add(
      Marker(
        markerId: MarkerId(heatMapItem.id),
        icon: icon,
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
    'heat_map_item.png',
  );
  return bitmapDescriptor;
}
