class TvShow {
  final String name;
  final String overview;
  final String posterPath;

  TvShow({required this.name, required this.overview, required this.posterPath});

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}