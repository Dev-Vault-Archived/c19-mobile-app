import 'package:covid19/constant.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';

class InCollaborationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FLAppBarTitle(
          title: 'Tentang',
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kolaborasi antara",
                        style: TextStyle(color: ColorPallete.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/logo_pangandaran_hebat.png',
                        width: 200,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        'assets/images/kominfo.jpg',
                        width: 200,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        'assets/images/kkn.png',
                        width: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
