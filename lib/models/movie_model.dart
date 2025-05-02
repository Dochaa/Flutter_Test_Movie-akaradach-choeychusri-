class MovieModel {
  final String title;
  final int year;
  final String releaseDate;
  final String director;
  final String character;
  final String movieDuration;
  final String timestamp;
  final String fullLine;
  final int currentWhoaInMovie;
  final int totalWhoasInMovie;
  final WhoaGrouping? whoaGrouping;
  final String poster;
  final String audio;
  final Map<String, String> video;

  MovieModel({
    required this.title,
    required this.year,
    required this.releaseDate,
    required this.director,
    required this.character,
    required this.movieDuration,
    required this.timestamp,
    required this.fullLine,
    required this.currentWhoaInMovie,
    required this.totalWhoasInMovie,
    required this.whoaGrouping,
    required this.poster,
    required this.audio,
    required this.video,
  });
}

class WhoaGrouping {
  final int movieWhoaGroupIndex;
  final int currentWhoaInGroup;
  final int totalWhoasInGroup;

  WhoaGrouping({
    required this.movieWhoaGroupIndex,
    required this.currentWhoaInGroup,
    required this.totalWhoasInGroup,
  });
}