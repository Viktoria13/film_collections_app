import 'dart:convert';

import 'package:film_collections_app/context.dart';
import 'package:film_collections_app/database/database_helper.dart';
import 'package:film_collections_app/model/movie.dart';
import 'package:film_collections_app/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class MovieService {

  DatabaseHelper _database = Context.database;
  MovieApiService _api = Context.movieApiService;

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

}