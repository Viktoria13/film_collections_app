
import 'package:film_collections_app/database/constant.dart';

class Movie {

  int id;
  String title;
  String year;
  num rating;
  String overview;
  String posterPath;
  bool watchList;
  bool seen;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Movie &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              title == other.title &&
              year == other.year &&
              rating == other.rating &&
              overview == other.overview &&
              posterPath == other.posterPath &&
              watchList == other.watchList &&
              seen == other.seen;

  Movie({
    this.id,
    this.title,
    this.year,
    this.rating,
    this.overview,
    this.posterPath,
    this.watchList = false,
    this.seen = false
  });

  String getTitleWithYear() {
    return year.isEmpty ? title : "$title($year)";
  }

  String getDetailRating() {
    return rating != null ? "$rating/10" : "";
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    //print("Constructor input json: $json" );
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      year: _getYear(json),
      rating: json['vote_average'] as num,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String
    );
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map[Constant.columnId],
      title: map[Constant.columnTitle],
      year: map[Constant.columnYear].toString(),
      rating: map[Constant.columnRating],
      overview: map[Constant.columnOverview],
      posterPath: map[Constant.columnPosterPath],
      watchList: convertIntToBool(map[Constant.columnWatchList]),
      seen: convertIntToBool(map[Constant.columnSeen])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Constant.columnId: id,
      Constant.columnTitle: title,
      Constant.columnYear: year,
      Constant.columnRating: rating,
      Constant.columnOverview: overview,
      Constant.columnPosterPath: posterPath,
      Constant.columnWatchList: convertBoolToInt(watchList),
      Constant.columnSeen: convertBoolToInt(seen)
    };
  }

  static String _getYear(Map<String, dynamic> json) {
    if (json.containsKey("release_date")) {
      String dateStr = json["release_date"] as String;
      if (dateStr.isNotEmpty) {
        DateTime date = DateTime.parse(dateStr);
        return date.year.toString();
      }
      return "";
    }
    return "";
  }

  static bool convertIntToBool(int value) {
    return value == 1;
  }

  static int convertBoolToInt(bool value) {
    return value ? 1 : 0;
  }

  @override
  toString() {
    return "$id, $title, $year, $rating, $posterPath, $watchList, $seen";
  }

}