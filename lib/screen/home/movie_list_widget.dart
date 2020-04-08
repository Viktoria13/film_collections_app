import 'package:film_collections_app/model/movie.dart';
import 'package:flutter/material.dart';

class MovieListWidget extends StatefulWidget {
  MovieListWidget({Key key, this.movies});

  List<Movie> movies;

  MovieListWidgetState createState() => MovieListWidgetState();
}

class MovieListWidgetState extends State<MovieListWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: widget.movies.map((movie) =>
            GestureDetector(
                onTap: (){/*getGridViewItems(context, data);*/},
                child: Center(
                  child: _buildMovieCard(movie),
                )
            )
        ).toList(),
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Card(
        color: Colors.white,
        child: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Image.asset('img/film.jpg')),
              //Icon(Icons.search, size:90.0, color: textStyle.color),
              ListTile(
                title: Text(movie.title),
                trailing: Text(movie.rating.toString()),
              )
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(movie.title, textAlign: TextAlign.left),
                  Text(movie.rating.toString(), textAlign: TextAlign.right)
                ],
              )*/
            ]
        ),
        )
    );
  }
}

