import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demon_hacks/blocs/blocs.dart';
import 'package:demon_hacks/models/models.dart';

class FeedWidget extends StatefulWidget {
  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<PickLocationBloc>(context),
      builder: (BuildContext context, PickLocationState state) {
        if (state is LocationFetching) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return BlocBuilder(
            bloc: BlocProvider.of<FeedsBloc>(context),
            builder: (BuildContext context, FeedsState feedsState) {
              if (feedsState is FetchingFeeds) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (feedsState is FeedsFetched) {
                List<FeedItem> feedItems = feedsState.feedItems;
                return Center(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: feedItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                title: Text(feedItems[index].message, style: Theme.of(context).textTheme.title,),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(feedItems[index].name),
                                    Text(
                                        "${feedItems[index].favoriteCount} likes"),
                                    Text(feedItems[index].date),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      TextField()
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        }
      },
    );
  }
}
