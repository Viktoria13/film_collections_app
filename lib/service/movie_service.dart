import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class MovieService {

  String _defaultUrl = "https://api.themoviedb.org/3/search/movie?api_key=21d0b60bb605bdf3e0e5ddddc159a83c&query=";

  /*Future<List<Film>> fetchFilm(String filmName) async {
    final response = await http.get("$_defaultUrl$filmName");

    if (response.statusCode == 200) {
      var films = json.decode(response.body)['results'].map<Film>((s) => Film.fromJson(s)).toList();
      //print(films);
      return films;
    } else {
      throw Exception('Failed to load films');
    }
  }*/
}