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
  List<MovieModel> searchMovieList = [];
  List<MovieModel> categoryMovieList = [];
  List<String> favoriteList = [];
  int selectedCategoryID = 0;

  setFavoriteList(ResponseData responseData) {
    favoriteMovieList.addAll(responseData.favoriteMovieList!);
    notifyListeners();
  }

  setMovieListByCategory(ResponseData responseData, int? categoryId) {
    final tempList = [];

    for (MovieModel m in responseData.categoryMovieList!) {
      for (GenresModel g in m.genres!) {
        if (g.categoryId == categoryId) {
          int i = categoryMovieList
              .indexWhere((element) => element.movieId == m.movieId);

          if (i == -1) {
            categoryMovieList.add(m);
          }
          notifyListeners();
        }
      }
    }
  }

  setMovieList(ResponseData responseData) {
    topMovieList.addAll(responseData.topMovies!);
    movieListLatest.addAll(responseData.movieListLatest!);
    allMovieList.addAll(responseData.movieList!);
    generesList.addAll(responseData.genres!);
    allGenresList.addAll(responseData.totalCategory!);
    notifyListeners();
  }

  setSearchData(ResponseData responseData) {
    searchMovieList.clear();
    searchMovieList.addAll(responseData.searchMovieList!);
    notifyListeners();
  }

  updateFavorite(int movieID, bool isFavorite, {MovieModel? movie}) async {
    if (favoriteList.contains(movieID.toString())) {
      if (!isFavorite) {
        favoriteList.remove(movieID.toString());
        favoriteMovieList.removeWhere((element) => element.movieId == movieID);
      }
    } else {
      if (isFavorite) {
        favoriteList.add(movieID.toString());
        favoriteMovieList.add(movie!);
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
