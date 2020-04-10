import 'dart:async';

import 'package:film_collections_app/context.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/screen/detail/detail.dart';
import 'package:film_collections_app/service/movie_service.dart';
import 'package:flutter/material.dart';

class SearchPageWidget extends StatefulWidget {

  @override
  SearchPageWidgetState createState() => SearchPageWidgetState();
}

class SearchPageWidgetState extends State<SearchPageWidget> {

  MovieService _movieService = Context.movieService;

  TextEditingController searchFieldController = TextEditingController();
  List<Movie> _movies = [];


  // todo bad work
  Timer _timer;
  int _start = 0;

  void _startTimer() {
    _start = 0;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
              //_start = _start + 1;
              if (_start > 2) {
                print("timer: $_start");
                _start = 0;
                _searchMovies();
                timer.cancel();
              } else {
                _start = _start + 1;
              }
        },
      ),
    );
  }

  void _resetTimer() {
    _timer.cancel();
    _start = 0;
  }

  @override
  void initState() {
    super.initState();
    //searchFieldController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    _timer.cancel();
    super.dispose();
  }

  _searchMovies() {
    //if (_start > 2) {
      if (searchFieldController.text.length > 0) {
        String title = searchFieldController.text;
        _movieService.searchMovies(title)
            .then((movies) => _updateMovieList(movies));
      }
    //}
  }

  _updateMovieList(List<Movie> movies) {
    setState(() {
      if (movies != null) {
        _movies = movies;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search Movies"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  //_resetTimer();
                  _startTimer();
                },
                controller: searchFieldController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  //padding: const EdgeInsets.all(16.0),
                //shrinkWrap: true,
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    //if (index.isOdd) return Divider();
                    //final idx = index ~/ 2;
                    return _buildMovieRow(_movies[index]);
                    //return MovieSearchItemWidget(movie: _movies[idx]);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieRow(Movie movie) {
    return Card(
      child: ListTile(
        title: Text(movie.getTitleWithYear()),
        trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              movie.watchList = false;
              movie.seen = false;
              _movieService.getActualMovie(movie).then((m) => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => DetailsPageWidget(movie: m))));
            }
        ),
      ),
    );
  }
}
