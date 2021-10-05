import 'package:flutter/material.dart';
import 'package:ui_practice/models/fake_response.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
              Expanded(
                  child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: ResponseData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            ResponseData.elementAt(index).imageUrl,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 0.35,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisExtent: 200,
                  crossAxisSpacing: 10,
                ),
              ))
            ],
          ),
        ));
  }
}
