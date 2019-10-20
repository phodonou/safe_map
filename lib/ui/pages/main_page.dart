import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:demon_hacks/ui/components/component.dart';
import 'package:demon_hacks/blocs/blocs.dart';
import 'package:demon_hacks/helper_functions.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PickLocationBloc _pickLocationBloc;

  @override
  void initState() {
    super.initState();
    _pickLocationBloc = PickLocationBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _pickLocationBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder(
          bloc: _pickLocationBloc,
          builder: (BuildContext context, PickLocationState state) {
            if (state is LocationFetched) {
              if (state.heatMapItems.isEmpty)
                return Text('No Location Picked');
              else
                return Text("Near ${state.heatMapItems[0].itemName}");
            } else {
              return Container();
            }
          },
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey[300],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => BlocProvider<SearchLocationBloc>(
                        builder: (BuildContext context) => SearchLocationBloc(),
                        child: LocationSearch(),
                      )));
            },
          )
        ],
      ),
      body: BlocBuilder(
        bloc: _pickLocationBloc,
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
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.centeredLocation.coordinates.lat,
                      state.centeredLocation.coordinates.long,
                    ),
                    zoom: 14.4746,
                  ),
                  markers: markers.data,
                );
              },
            );
          } else {
            return Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
