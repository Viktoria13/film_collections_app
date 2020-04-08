import 'package:film_collections_app/context.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/screen/detail/detail.dart';
import 'package:film_collections_app/service/api_service.dart';
import 'package:flutter/material.dart';

class SearchPageWidget extends StatefulWidget {

  @override
  SearchPageWidgetState createState() => SearchPageWidgetState();
}

class SearchPageWidgetState extends State<SearchPageWidget> {

  MovieApiService _api = Context.movieApiService;
  TextEditingController searchFieldController = TextEditingController();
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    searchFieldController.addListener(_searchMovies);
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  _searchMovies() {
    if (searchFieldController.text.length > 0) {
      String title = searchFieldController.text;
      _api.fetchMovies(title)
          .then((movies) => _updateMovieList(movies));
    }
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
                onChanged: (value) {},
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => DetailsPageWidget(movie: movie)));
            }
        ),
      ),
    );
  }

  /*Widget _movieWidget(Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
              movie.getTitleWithYear()
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DetailsPageWidget()));
              }
          ),
        )
      ],
    );
  }
  }*/

  /*Widget filmsWidget() {
    return FutureBuilder(
        future: this._searchFilms(),
        builder: (context, snapshot) {
          if (ConnectionState.none == ConnectionState.none &&
              snapshot.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Center(
              child: Text("Empty"),
            );
          }

          return ListView.builder(
            //shrinkWrap: true,
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              itemBuilder: (context, index) {
                Film film = snapshot.data[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          film.getFilmTitleForSearchList()
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () => Navigator.pushNamed(context, '/detail'),
                      ),
                    )
                  ],
                );
              }
          );
        }
    );
  }*/
}
