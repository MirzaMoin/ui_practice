import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_practice/models/fake_response.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:ui_practice/providers/movie_list_provider.dart';
import 'package:ui_practice/screens/download_video_screen.dart';
import 'package:ui_practice/screens/player_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Response response;
  const MovieDetailsScreen(this.response, {Key? key}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.transparent,
                      child: Hero(
                        tag: "movie${widget.response.name}",
                        child: Image.network(
                          widget.response.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: false,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.16,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context).backgroundColor,
                                    blurRadius: 100.0,
                                    spreadRadius: 20),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0.001),
                                  Theme.of(context).backgroundColor
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PlayerScreen()));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).buttonColor),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${widget.response.name}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .fontFamily,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "2021 | Action, Crime, Drama",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .fontFamily,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    itemSize: 25,
                                    unratedColor: Theme.of(context).accentColor,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Theme.of(context).buttonColor,
                                            blurRadius: 10,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                        color: Theme.of(context).buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: MaterialButton(
                                      elevation: 0,
                                      onPressed: () async {
                                        /* await canLaunch(
                                                "https://mega.nz/file/GwxAEIjY#wUAgU75NK55zC5ueW3MsMJflj6dom4nN5Hs29sv6Z8k")
                                            ? await launch(
                                                "https://mega.nz/file/GwxAEIjY#wUAgU75NK55zC5ueW3MsMJflj6dom4nN5Hs29sv6Z8k")
                                            : throw 'Could not launch https://mega.nz/file/GwxAEIjY#wUAgU75NK55zC5ueW3MsMJflj6dom4nN5Hs29sv6Z8k';
                                      */
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    DownloadVideoScreen()));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            "assets/icons/ic_download.png",
                                            width: 20,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Download",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),

                      //back button
                    ],
                  ),
                ),
                Container(
                    color: Theme.of(context).backgroundColor,
                    child: getEpisodes()),
                getPlot(),
                Container(
                    color: Theme.of(context).backgroundColor, child: getCast()),
                Container(
                    color: Theme.of(context).backgroundColor,
                    child: getYouMayLike())
              ],
            ),
            getHeaderBack()
          ],
        ));
  }

  Widget getHeaderBack() {
    return Positioned(
      top: 40,
      left: 20,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Consumer<MovieListProvider>(
        builder: (context, provider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      print("Back Called");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .backgroundColor
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(12),
                      child: Image.asset(
                        "assets/icons/ic_back_arrow.png",
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                      child: GestureDetector(
                        onTap: () async {
                          await provider.updateFavorite(
                              widget.response.id,
                              !provider.responseList
                                  .elementAt(widget.response.id)
                                  .isFavourite);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .backgroundColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            provider.responseList
                                    .elementAt(widget.response.id)
                                    .isFavourite
                                ? "assets/icons/ic_heart_fill.png"
                                : "assets/icons/ic_heart.png",
                            width: 25,
                            height: 25,
                            color: provider.responseList
                                    .elementAt(widget.response.id)
                                    .isFavourite
                                ? Theme.of(context).buttonColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/icons/ic_share.png",
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getPlot() {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Plot",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          ExpandableText(
            "Rakesh Kadam is an honest police officer who ends up committing suicide due to the false accusations of corruption levelled against him by Jaikant Shikre, a crime boss and politician in Goa running various rackets like kidnapping, extortion and smuggling. Kadam's wife Megha vows revenge against Jaikant in front of him, exclaiming that God will dispense justice to him for this act.",
            expandText: 'show more',
            collapseText: 'show less',
            maxLines: 3,
            style:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
            linkColor: Colors.white,
            animation: true,
            animationDuration: Duration(seconds: 1),
            collapseOnTextTap: true,
            expandOnTextTap: true,
          )
        ],
      ),
    );
  }

  Widget getEpisodes() {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Episodes",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
                shrinkWrap: false,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                scrollDirection: Axis.horizontal,
                itemCount: ResponseData.length,
                itemBuilder: (context, index) {
                  Response res = ResponseData.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            res.imageUrl,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).backgroundColor,
                                      blurRadius: 100.0,
                                      spreadRadius: 30),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.001),
                                    Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.4),
                                    Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.6),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                          ),
                        ),
                        Positioned(
                            width: MediaQuery.of(context).size.width * 0.25,
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Episode - 1",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                Text("Rice of sun ",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 13)),
                              ],
                            ))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget getCast() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Cast",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: ListView.builder(
                shrinkWrap: false,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                scrollDirection: Axis.horizontal,
                itemCount: ResponseData.length,
                itemBuilder: (context, index) {
                  Response res = ResponseData.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            res.imageUrl,
                            height: MediaQuery.of(context).size.height * 0.20,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).backgroundColor,
                                      blurRadius: 100.0,
                                      spreadRadius: 5),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.001),
                                    Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.3),
                                    Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.5),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                          ),
                        ),
                        Positioned(
                            width: MediaQuery.of(context).size.width * 0.25,
                            bottom: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Episode - 1",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget getYouMayLike() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "You may also like",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily),
                ),
                Text(
                  "See more",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontFamily:
                          Theme.of(context).textTheme.headline1!.fontFamily),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: ResponseData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsScreen(index)));*/
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: SingleChildScrollView(
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      ResponseData.elementAt(index).imageUrl,
                                      width: MediaQuery.of(context).size.width *
                                          0.28,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${ResponseData.elementAt(index).name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .fontFamily),
                                      ),
                                      Text(
                                        "2020",
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
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
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
