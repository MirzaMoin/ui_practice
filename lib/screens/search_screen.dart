import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_practice/models/movie_model.dart';
import 'package:ui_practice/models/response_data.dart';
import 'package:ui_practice/models/response_model.dart';
import 'package:ui_practice/providers/movie_list_provider.dart';
import 'package:ui_practice/services/http_service.dart';

import 'movie_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 45,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xff2c3254), width: 1)),
                child: TextField(
                  cursorColor: Color(0xff2c3254),
                  maxLines: 1,
                  style: TextStyle(color: Color(0xff2c3254)),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (val) async {
                    Provider.of<MovieListProvider>(context, listen: false)
                        .searchMovieList
                        .clear();
                    setState(() {
                      isSearching = true;
                    });
                    HttpService httpService = new HttpService();

                    ResponseModel? responseData = await httpService.get(
                        path: "searchMovieList.php?keyword=$val");

                    if (responseData!.statusCode == 1) {
                      setState(() {
                        isSearching = false;
                      });
                      ResponseData res =
                          ResponseData.fromJson(responseData.responseData!);
                      print("Length of search ${res.movieList!.length}");
                      Provider.of<MovieListProvider>(context, listen: false)
                          .setSearchData(res);
                    } else {
                      setState(() {
                        isSearching = false;

                        Provider.of<MovieListProvider>(context, listen: false)
                            .searchMovieList
                            .clear();
                      });
                      print("Something went wrong");
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    prefixIcon: Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.only(right: 9),
                      child: Image.asset(
                        "assets/icons/ic_search.png",
                        color: Color(0xff2c3254),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                        maxHeight: 30,
                        maxWidth: 30,
                        minHeight: 20,
                        minWidth: 20),
                    hintStyle: TextStyle(
                      color: Color(0xff2c3254),
                    ),
                  ),
                ),
              ),
              Expanded(child:
                  Consumer<MovieListProvider>(builder: (context, provider, _) {
                List<MovieModel> movie = provider.searchMovieList;
                return isSearching
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Theme.of(context).accentColor,
                          highlightColor:
                              Theme.of(context).accentColor.withOpacity(0.4),
                          enabled: isSearching,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 12,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                    ),
                                  ),
                                ],
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              mainAxisExtent: isSearching ? 180 : 200,
                              crossAxisSpacing: 10,
                            ),
                          ),
                        ),
                      )
                    : movie.length > 0
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                            ),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: BouncingScrollPhysics(),
                              itemCount: movie.length,
                              itemBuilder: (context, index) {
                                MovieModel mov = movie.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                MovieDetailsScreen(mov)));
                                  },
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          "${mov.thumbImage}",
                                          fit: BoxFit.fill,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${mov.name}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .fontFamily),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                mainAxisExtent: 200,
                                crossAxisSpacing: 10,
                              ),
                            ),
                          )
                        : Center(
                            child: isSearching
                                ? CircularProgressIndicator(
                                    color: Theme.of(context).accentColor,
                                  )
                                : Text(
                                    "No search item found",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 18),
                                  ));
              }))
            ],
          ),
        ));
  }
}
