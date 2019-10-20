import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demon_hacks/blocs/blocs.dart';
import 'package:bloc/bloc.dart';

class FeedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<PickLocationBloc>(context),
      builder: (BuildContext context, PickLocationState state){
        if(state is LocationFetching) {
          return Center(child: CircularProgressIndicator(),);
        }
        else {
          return Container();
        }
      },
    );
  }
}
