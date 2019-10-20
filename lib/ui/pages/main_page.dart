import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'package:demon_hacks/ui/components/component.dart';
import 'package:demon_hacks/blocs/blocs.dart';
import 'package:demon_hacks/repos/repos.dart';
import 'package:demon_hacks/network/http_service.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex;
  HttpService _httpService;
  HeatMapRepo _heatMapRepo;
  FeedsRepo _feedsRepo;
  LocationSearchRepo _locationSearchRepo;
  PickLocationBloc _pickLocationBloc;
  SearchLocationBloc _searchLocationBloc;
  FeedsBloc _feedsBloc;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _httpService = HttpService();
    _heatMapRepo = HeatMapRepo(httpService: _httpService);
    _locationSearchRepo = LocationSearchRepo(httpService: _httpService);
    _feedsRepo = FeedsRepo(httpService: _httpService);
    _searchLocationBloc =
        SearchLocationBloc(locationSearchRepo: _locationSearchRepo);
    _feedsBloc = FeedsBloc(
      feedsRepo: _feedsRepo,
    );
    _pickLocationBloc = PickLocationBloc(
      heatMapRepo: _heatMapRepo,
      feedBloc: _feedsBloc,
    );
    _children = [
      MapWidget(),
      FeedWidget(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pickLocationBloc.close();
    _searchLocationBloc.close();
    _feedsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      BlocProvider<SearchLocationBloc>.value(
                        value: _searchLocationBloc,
                      ),
                      BlocProvider<PickLocationBloc>.value(
                        value: _pickLocationBloc,
                      ),
                      BlocProvider<FeedsBloc>.value(
                        value: _feedsBloc,
                      ),
                    ],
                    child: LocationSearch(),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SearchLocationBloc>.value(
            value: _searchLocationBloc,
          ),
          BlocProvider<PickLocationBloc>.value(
            value: _pickLocationBloc,
          ),
          BlocProvider<FeedsBloc>.value(
            value: _feedsBloc,
          )
        ],
        child: _children[currentIndex],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        onTap: (int pickIndex) {
          setState(() {
            currentIndex = pickIndex;
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end,
        hasNotch: true,
        hasInk: true,
        inkColor: Colors.black12,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.map,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.map,
              ),
              title: Text("Map")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.chat_bubble,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.chat_bubble_outline,
              ),
              title: Text("Feed"))
        ],
      ),
    );
  }
}
