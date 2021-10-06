import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xff2c3254), width: 1)),
                child: TextField(
                  cursorColor: Color(0xff2c3254),
                  maxLines: 1,
                  style: TextStyle(color: Color(0xff2c3254)),
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
            ],
          ),
        ));
  }
}
