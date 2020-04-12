
import 'package:film_collections_app/database/database_helper.dart';
import 'package:film_collections_app/service/movie_service.dart';

class Context {
  static final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  static final MovieService movieService = new MovieService(databaseHelper);
}