
class Movie {

  int id;
  String title;
  String year;
  num rating;
  String overview;
  String posterPath;
  bool watchList;
  bool seen;

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

  @override
  toString() {
    return "$id, $title, $year, $rating, $posterPath";
    return "${this.title}\noverview: ${this.overview}";
  }

}