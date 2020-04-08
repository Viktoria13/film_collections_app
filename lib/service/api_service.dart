import 'package:film_collections_app/model/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MovieApiService {

  static final String _apiKey = "21d0b60bb605bdf3e0e5ddddc159a83c";

  static String _defaultSearchMovieUrl = "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=";

  static final String _postersBaseUrl = "https://image.tmdb.org/t/p/";

  static final String _smallImagesBaseUrl = "${_postersBaseUrl}w45";

  static final String _largePosterBaseUrl = "${_postersBaseUrl}w154";

  String getSmallImageUrl(String posterPath) => "$_smallImagesBaseUrl$posterPath";

  String getLargeImageUrl(String posterPath) => "$_largePosterBaseUrl$posterPath";

  String searchMovieByTitleUrl(String title) => "$_defaultSearchMovieUrl$title";

  String getMovieByIdUrl(int id) => "https://api.themoviedb.org/3/movie/$id?api_key=$_apiKey";

  Future<List<Movie>> fetchMovies(String query) async {
    print("fetchMovies: query = $query");

    final response = await http.get("$_defaultSearchMovieUrl$query");

    if (response.statusCode == 200) {
      print("response 200 OK");
      var list = json.decode(response.body)['results']
          .map<Movie>((json) => Movie.fromJson(json))
          .toList();
      print("list: $list");
      return list;
    } else {
      //return List();
      throw Exception('Failed to load movies');
    }
  }
}

