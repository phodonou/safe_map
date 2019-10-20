import 'package:demon_hacks/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:demon_hacks/ui/components/component.dart';
import 'package:demon_hacks/blocs/blocs.dart';
import 'package:demon_hacks/helper_functions.dart';
import 'package:demon_hacks/repos/repos.dart';
import 'package:demon_hacks/network/http_service.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PickLocationBloc _pickLocationBloc;
  LocationSearchRepo _locationSearchRepo;
  HttpService _httpService;

  final defaultLat = 37.42796133580664;
  final defaultLon = -122.085749655962;

  @override
  void initState() {
    super.initState();
    _httpService = HttpService();
    _pickLocationBloc = PickLocationBloc();
    _locationSearchRepo = LocationSearchRepo(httpService: _httpService);
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
        elevation: 0,
        backgroundColor: Colors.blueGrey[300],
        centerTitle: true,
        title: BlocBuilder(
          bloc: _pickLocationBloc,
          builder: (BuildContext context, PickLocationState state) {
            if (state is LocationFetched) {
              if (state.centeredLocation == null)
                return Text('No Location Picked');
              else
                return Text("Near ${state.centeredLocation.locationName}");
            } else {
              return Container();
            }
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<SearchLocationBloc>(
                        builder: (BuildContext context) => SearchLocationBloc(
                          locationSearchRepo: _locationSearchRepo,
                        ),
                      ),
                      BlocProvider<PickLocationBloc>(
                        builder: (_) => _pickLocationBloc,
                      )
                    ],
                    child: LocationSearch(),
                  ),
                ),
              );
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
                final LocationSearchResult searchResult =
                    state.centeredLocation;
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
