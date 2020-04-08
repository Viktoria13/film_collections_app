import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/screen/search/search.dart';
import 'package:flutter/material.dart';

import 'movie_list_widget.dart';

class HomePageWidget extends StatefulWidget {
  @override
  HomePageWidgetState createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget> {

  List<Movie> watched = [
    new Movie(
      id: 123123,
      title: "test1",
      year: "2030",
      rating: 5.0,
      overview: "jkjnkjn",
      posterPath: "kjnkjn",
      watchList: false,
      seen:false
    ),
    new Movie(
        id: 123123,
        title: "test2",
        year: "2034",
        rating: 3.0,
        overview: "jkjnkjn",
        posterPath: "kjnkjn",
        watchList: false,
        seen:false
    )
  ];

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
                  //onTap: () { Navigator.pushNamed(context, '/search'); },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            )],
          bottom: TabBar(tabs: [Tab(text: "Watchlist"), Tab(text: "Seen")]),
        ),
        body: TabBarView(children: [
          MovieListWidget(movies: watched),
          Text("hello2")
        ]),
      ),
    );
  }
}