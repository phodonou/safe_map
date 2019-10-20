import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demon_hacks/blocs/blocs.dart';
import 'package:demon_hacks/models/models.dart';

class LocationSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextField(
          decoration:
              new InputDecoration.collapsed(hintText: 'Search Location'),
          onSubmitted: (String criteria) {
            BlocProvider.of<SearchLocationBloc>(context)
                .add(LocationInputed(location: criteria));
          },
        ),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<SearchLocationBloc>(context),
        builder: (BuildContext context, SearchLocationState state) {
          if (state is LocationSearching) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LocationSearchResults) {
            List<LocationSearchResult> locationSearchResults =
                state.locationSearchResults;
            return ListView.builder(
              itemCount: locationSearchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(locationSearchResults[index].locationName),
                  subtitle: Text(
                    locationSearchResults[index].address,
                  ),
                  onTap: () {
                    BlocProvider.of<PickLocationBloc>(context).add(
                      LocationPicked(
                        locationSearchResult: locationSearchResults[index],
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
