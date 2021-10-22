import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:ui_practice/models/genres_model.dart';
import 'package:ui_practice/models/movie_model.dart';
import 'package:ui_practice/models/response_data.dart';

class MovieListProvider extends ChangeNotifier {
  final BuildContext context;
  MovieListProvider({required this.context});
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Response> movieList = [];
  List<MovieModel> allMovieList = [];
  List<MovieModel> topMovieList = [];
  List<MovieModel> movieListLatest = [];
  List<GenresModel> generesList = [];
  List<GenresModel> allGenresList = [];
  List<MovieModel> favoriteMovieList = [];
  List<String> favoriteList = [];

  setFavoriteList(ResponseData responseData) {
    favoriteMovieList.addAll(responseData.movieList!);
  }

  setMovieList(ResponseData responseData) {
    topMovieList.addAll(responseData.topMovies!);
    movieListLatest.addAll(responseData.movieListLatest!);
    allMovieList.addAll(responseData.movieList!);
    generesList.addAll(responseData.genres!);
    allGenresList.addAll(responseData.totalCategory!);
    notifyListeners();
  }

  updateFavorite(int movieID, bool isFavorite) async {
    if (favoriteList.contains(movieID.toString())) {
      if (!isFavorite) {
        favoriteList.remove(movieID.toString());
      }
    } else {
      if (isFavorite) {
        favoriteList.add(movieID.toString());
      }
    }
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList("favorite", favoriteList);

    print("Favorite List Length ${favoriteList.length}");

    notifyListeners();
  }

  bool isFavorite(String movieID) {
    if (favoriteList.contains(movieID.toString()))
      return true;
    else
      return false;
  }

  getFavoriteList() async {
    final SharedPreferences prefs = await _prefs;

    favoriteList.clear();
    if (prefs.containsKey("favorite"))
      favoriteList.addAll(prefs.getStringList("favorite")!.toList());
    notifyListeners();
  }

  List<Response> searchMovie(String name) {
    return movieList
        .where((element) => element.name.toLowerCase().contains(name))
        .toList();
  }
}
