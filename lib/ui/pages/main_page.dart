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

  final startingCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
            return GoogleMap(
              initialCameraPosition: startingCameraPosition,
              markers: convertHeatMapItemsToMarkers(state.heatMapItems),
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
