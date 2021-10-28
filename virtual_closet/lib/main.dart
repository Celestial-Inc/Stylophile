import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[100],
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Image.asset(
                  'assets/tshirt.jpg',
                  height: 150,
                ),
              ),
              Card(
                child: Image.asset(
                  'assets/pants.jpg',
                  height: 150,
                ),
              ),
              Card(
                child: Image.asset(
                  'assets/shoes.jpg',
                  height: 150,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
