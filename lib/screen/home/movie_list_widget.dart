import 'package:cached_network_image/cached_network_image.dart';
import 'package:film_collections_app/context.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/screen/detail/detail.dart';
import 'package:film_collections_app/service/movie_service.dart';
import 'package:flutter/material.dart';

class MovieListWidget extends StatefulWidget {
  MovieListWidget({Key key, this.movies});

  Future<List<Movie>> movies;

  MovieListWidgetState createState() => MovieListWidgetState();
}

class MovieListWidgetState extends State<MovieListWidget> {

  MovieService _movieService = Context.movieService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.movies,
      builder: (context, snapshot) {
        if (ConnectionState.none == ConnectionState.none &&
            snapshot.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Center(
            child: Text("Empty"),
          );
        }
        List<Movie> result = snapshot.data as List<Movie>;
        if (result == null){result = List();}
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: result.map((movie) =>
            GestureDetector(
                onTap: (){ Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DetailsPageWidget(movie: movie/*, movieService: Context.movieService*/)));
                },
                child: Center(
                  child: _buildMovieCard(movie),
                )
            )
          ).toList(),
        );
      }
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            elevation: 4,
            child: Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: CachedNetworkImage(
                          imageUrl: _movieService.getPosterUrl(movie),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      )
                  ),
                  /*ListTile(
                    title: Text(movie.title, style: TextStyle(fontSize: 15)),
                    trailing: Text(movie.rating.toString(), style: TextStyle(fontSize: 15)),
                  )*/
                  Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(movie.title, textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                            Text(movie.rating.toString(), textAlign: TextAlign.right, style: TextStyle(fontSize: 15))
                          ],
                        ),
                      )
                  )
                ]
            ),
            )
        )
    );
  }
}

