import 'package:ui_practice/models/movie_model.dart';

import 'genres_model.dart';
import 'movie_model.dart';

class ResponseData {
  List<MovieModel>? topMovies;
  List<GenresModel>? genres;
  List<MovieModel>? movieList;
  List<MovieModel>? movieListLatest;
  List<GenresModel>? totalCategory;
  List<MovieModel>? favoriteMovieList;
  List<MovieModel>? searchMovieList;
  List<MovieModel>? categoryMovieList;

  ResponseData(
      {this.topMovies,
      this.genres,
      this.movieList,
      this.movieListLatest,
      this.totalCategory});

  ResponseData.fromJson(Map<String, dynamic> json) {
    topMovies = json.containsKey('top_movies')
        ? (json['top_movies'])
                .map<MovieModel>((e) => MovieModel.fromJson(e))
                .toList() ??
            []
        : [];
    genres = json.containsKey('genres')
        ? (json['genres'])
                .map<GenresModel>((e) => GenresModel.fromJson(e))
                .toList() ??
            []
        : [];
    movieList = json.containsKey('movie_list')
        ? (json['movie_list'])
                .map<MovieModel>((e) => MovieModel.fromJson(e))
                .toList() ??
            []
        : [];
    movieListLatest = json.containsKey('movie_list_latest')
        ? (json['movie_list_latest'])
                .map<MovieModel>((e) => MovieModel.fromJson(e))
                .toList() ??
            []
        : [];
    totalCategory = json.containsKey('all_categories')
        ? (json['all_categories'])
                .map<GenresModel>((e) => GenresModel.fromJson(e))
                .toList() ??
            []
        : [];
    favoriteMovieList = json.containsKey('favorite_movie_list')
        ? (json['favorite_movie_list'])
                .map<MovieModel>((e) => MovieModel.fromJson(e))
                .toList() ??
            []
        : [];
    searchMovieList = json.containsKey('search_result')
        ? (json['search_result'])
                .map<MovieModel>((e) => MovieModel.fromJson(e))
                .toList() ??
            []
        : [];
    categoryMovieList = json.containsKey('movies_by_cat')
        ? (json['movies_by_cat'])
                .map<MovieModel>((e) => MovieModel.fromJson(e))
                .toList() ??
            []
        : [];
  }
}
