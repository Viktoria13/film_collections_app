
import 'package:film_collections_app/database/database_helper.dart';
import 'package:film_collections_app/service/api_service.dart';
import 'package:film_collections_app/service/movie_service.dart';

class Context {
  static final MovieApiService movieApiService = new MovieApiService();
  static final DatabaseHelper database = DatabaseHelper.instance;
  static final MovieService movieService = new MovieService();
}