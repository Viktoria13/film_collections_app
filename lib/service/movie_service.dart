
import 'package:film_collections_app/database/database_helper.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/service/api_service.dart';
import 'dart:async';

class MovieService {

  static final MovieApiService _api = new MovieApiService();
  static final DatabaseHelper _database = DatabaseHelper.instance;

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

  Future<int> saveMovie(Movie movie) {
    return _database.insert(movie.toMap());
  }

  Future<int> deleteMovie(Movie movie) {
    return _database.delete(movie.id);
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