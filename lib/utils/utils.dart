import 'package:flutter/material.dart';

class Utils {
  static showUpdateDialog(
      {required BuildContext context,
      required String title,
      required String description}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).accentColor,
        title: Container(
          width: 500,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        content: Container(
          width: 550,
          child: Text(
            "$description",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          MaterialButton(
            elevation: 0,
            height: 40,
            color: Theme.of(context).backgroundColor,
            padding: EdgeInsets.all(10),
            onPressed: () async {},
            child: Text(
              'Update',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
