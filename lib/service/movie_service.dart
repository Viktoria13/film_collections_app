
import 'package:film_collections_app/database/database_helper.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/service/api_service.dart';
import 'dart:async';

class MovieService {

  MovieService(DatabaseHelper databaseHelper) {
    this._database  = databaseHelper;
  }

  static final MovieApiService _api = new MovieApiService();
  DatabaseHelper _database;
  //DatabaseHelper _database = DatabaseHelper.instance;

  /*DatabaseHelper _database = Context.database;
  MovieApiService _api = Context.movieApiService;*/

  Future<List<Movie>> searchMovies(String text) {
    return _api.fetchMovies(text);
  }

  Future<Movie> getActualMovie(Movie movie) {
    print("movie for search, id = ${movie.id}");
    return _getMovieById(movie.id).then((movieFromDb) {
       return movieFromDb != null ? movieFromDb : movie;
    });
  }

  Future<Movie> _getMovieById(int id) {
    return _database.get(id).then((movie) {
      return movie != null ? Movie.fromMap(movie) : null;
    });
  }

  String getPosterUrl(Movie movie) {
    return _api.getImageUrl(movie.posterPath);
  }

  Future<Movie> saveToWatchList(Movie movie) {
    var previousWatchList = movie.watchList;
    var previousSeenList = movie.seen;
    movie.watchList = true;
    movie.seen = false;
    return _saveMovie(movie).then((id) {
      if (id != movie.id) {
        print("error add to watch list");
        movie.watchList = previousWatchList;
        movie.seen = previousSeenList;
      }
      return movie;
    });
  }

  Future<Movie> saveToSeenList(Movie movie) {
    var previousWatchList = movie.watchList;
    var previousSeenList = movie.seen;
    movie.watchList = false;
    movie.seen = true;
    return _saveMovie(movie).then((id) {
      if (id != movie.id) {
        print("error add to seen list");
        movie.watchList = previousWatchList;
        movie.seen = previousSeenList;
      }
      return movie;
    });
  }

  Future<int> _saveMovie(Movie movie) {
    return _database.insert(movie.toMap());
  }

  Future<Movie> deleteMovieFromCategory(Movie movie) {
    return _database.delete(movie.id).then((affectedRows) {
      if (affectedRows == 1) {
        movie.watchList = false;
        movie.seen = false;
      } else {
        print("error delete from category");
      }
      return movie;
    });
  }
  
  Future<List<Movie>> getWatchList() {
    return _database.getWatchList().then((mapList) {
      return mapList.map((movie) => Movie.fromMap(movie)).toList();
    });
  }
  
  Future<List<Movie>> getSeenList() {
    return _database.getSeenList().then((mapList) {
      return mapList.map((movie) => Movie.fromMap(movie)).toList();
    });
  }

  void deleteAll() {
    _database.deleteAll();
  }

}