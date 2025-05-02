import '../models/movie_model.dart';

class MovieFactory {
  static MovieModel fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['movie'],
      year: json['year'],
      releaseDate: json['release_date'],
      director: json['director'],
      character: json['character'],
      movieDuration: getMinutes(json['movie_duration']),
      timestamp: json['timestamp'],
      fullLine: json['full_line'],
      currentWhoaInMovie: json['current_whoa_in_movie'],
      totalWhoasInMovie: json['total_whoas_in_movie'],
      whoaGrouping: json['whoa_grouping'] != null
          ? WhoaGrouping(
              movieWhoaGroupIndex: json['whoa_grouping']['movie_whoa_group_index'],
              currentWhoaInGroup: json['whoa_grouping']['current_whoa_in_group'],
              totalWhoasInGroup: json['whoa_grouping']['total_whoas_in_group'],
            )
          : null,
      poster: json['poster'],
      audio: json['audio'],
      video: Map<String, String>.from(json['video']),
    );
  }

  static List<MovieModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }
}

String getMinutes(String duration) {
  final parts = duration.split(':');
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);
  return '${(hours * 60 + minutes)} Minutes';
}
