import 'cast_model.dart';
import 'episode_model.dart';
import 'genres_model.dart';

class MovieModel {
  int? movieId;
  String? name;
  String? url;
  String? language;
  String? runtime;
  String? releaseDate;
  String? year;
  String? rating;
  String? thumbImage;
  String? director;
  String? plot;
  int? isMovie;
  int? seriesID;
  int? noOfSeasons;
  List<CastModel>? cast;
  List<EpisodeModel>? episodes;
  List<GenresModel>? genres;
  int? visited;
  int? watched;
  bool isFavourite = false;

  MovieModel(
      {this.movieId,
      this.name,
      this.url,
      this.language,
      this.runtime,
      this.releaseDate,
      this.year,
      this.rating,
      this.thumbImage,
      this.director,
      this.plot,
      this.isMovie,
      this.seriesID,
      this.noOfSeasons,
      this.cast,
      this.episodes,
      this.genres,
      this.visited,
      this.watched,
      this.isFavourite = false});

  MovieModel.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    name = json['name'];
    url = json['url'];
    language = json['language'];
    runtime = json['runtime'];
    releaseDate = json['releaseDate'];
    year = json['year'];
    rating = json['rating'];
    thumbImage = json['thumbImage'];
    director = json['director'];
    plot = json['plot'];
    isMovie = json['isMovie'];
    seriesID = json['seriesID'];
    noOfSeasons = json['noOfSeasons'];
    cast = json.containsKey('cast')
        ? (json['cast'])
                .map<CastModel>((e) => CastModel.fromJson(e))
                .toList() ??
            []
        : [];
    episodes = json.containsKey('Episodes')
        ? (json['Episodes'])
                .map<EpisodeModel>((e) => EpisodeModel.fromJson(e))
                .toList() ??
            []
        : [];
    genres = json.containsKey('genres')
        ? (json['genres'])
                .map<GenresModel>((e) => GenresModel.fromJson(e))
                .toList() ??
            []
        : [];
    visited = json['visited'];
    watched = json['watched'];
  }
}
