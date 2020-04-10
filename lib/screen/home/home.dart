import 'package:film_collections_app/context.dart';
import 'package:film_collections_app/screen/search/search.dart';
import 'package:film_collections_app/service/movie_service.dart';
import 'package:flutter/material.dart';

import 'movie_list_widget.dart';

class HomePageWidget extends StatefulWidget {
  @override
  HomePageWidgetState createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget> {

  MovieService movieService = Context.movieService;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatToWatch'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => SearchPageWidget()));
                  },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            )],
          bottom: TabBar(tabs: [Tab(text: "Watchlist"), Tab(text: "Seen")]),
        ),
        body: TabBarView(children: [
          MovieListWidget(movies: movieService.getWatchList()),
          MovieListWidget(movies: movieService.getSeenList())
        ]),
      ),
    );
  }
}