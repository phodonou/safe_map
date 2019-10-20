import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'package:demon_hacks/ui/components/component.dart';
import 'package:demon_hacks/blocs/blocs.dart';
import 'package:demon_hacks/repos/repos.dart';
import 'package:demon_hacks/network/http_service.dart';
import 'package:demon_hacks/ui/components/component.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PickLocationBloc _pickLocationBloc;
  LocationSearchRepo _locationSearchRepo;
  HttpService _httpService;
  int currentIndex;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _httpService = HttpService();
    _pickLocationBloc = PickLocationBloc();
    _locationSearchRepo = LocationSearchRepo(httpService: _httpService);
    currentIndex = 0;
    _children = [
      MapWidget(),
      FeedWidget(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pickLocationBloc.close();
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
      body: MultiBlocProvider(
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
