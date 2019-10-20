import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:demon_hacks/models/models.dart';
import 'package:demon_hacks/blocs/blocs.dart';

import 'package:demon_hacks/helper_functions.dart';

class MapWidget extends StatelessWidget {
  final defaultLat = 37.42796133580664;
  final defaultLon = -122.085749655962;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<PickLocationBloc>(context),
      builder: (BuildContext context, PickLocationState state) {
        if (state is LocationFetching) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LocationFetched) {
          return FutureBuilder(
            future: convertHeatMapItemsToMarkers(
              heatMapItems: state.heatMapItems,
            ),
            builder:
                (BuildContext context, AsyncSnapshot<Set<Marker>> markers) {
              if (!markers.hasData) return Container();
              final LocationSearchResult searchResult = state.centeredLocation;
              double lat;
              double lon;
              if (searchResult == null) {
                lat = defaultLat;
                lon = defaultLon;
              } else {
                lat = searchResult.coordinates.lat;
                lon = searchResult.coordinates.long;
              }
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lon),
                  zoom: 15,
                ),
                markers: markers.data,
                myLocationButtonEnabled: false,
              );
            },
          );
        } else {
          return Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
