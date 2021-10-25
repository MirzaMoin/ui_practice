import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:ui_practice/models/movie_model.dart';
import 'package:ui_practice/models/response_data.dart';
import 'package:ui_practice/models/response_model.dart';
import 'package:ui_practice/providers/movie_list_provider.dart';
import 'package:ui_practice/screens/login_screen.dart';
import 'package:ui_practice/screens/movie_details_screen.dart';
import 'package:ui_practice/services/http_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isLogin = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
            top: 45,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Favorite",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              isLogin
                  ? Expanded(child: Consumer<MovieListProvider>(
                      builder: (context, provider, _) {
                      List<MovieModel> movie = provider.favoriteMovieList;
                      return movie.length > 0
                          ? GridView.builder(
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
                            )
                          : Center(
                              child: Text(
                              "No favorite item found",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18),
                            ));
                    }))
                  : Expanded(
                      child: Center(
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login to see favorite list",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).buttonColor,
                                  blurRadius: 10,
                                  offset: Offset(1, 2),
                                ),
                              ],
                              color: Theme.of(context).buttonColor,
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.only(bottom: 20),
                          child: MaterialButton(
                            elevation: 0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()));
                            },
                            child: Text(
                              "Login Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )))
            ],
          ),
        ));
  }
}
