import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 230, 247),
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 5.0,
                    color: Color.fromARGB(255, 191, 128, 255),
                  ),
                  fixedSize: const Size(340, 70),
                  primary: Color.fromARGB(255, 255, 230, 247),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              child: const Text('Casual',
                  style: TextStyle(color: Color.fromARGB(225, 51, 0, 102))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 5.0,
                    color: Color.fromARGB(255, 191, 128, 255),
                  ),
                  fixedSize: const Size(340, 70),
                  primary: Color.fromARGB(255, 255, 230, 247),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              child: const Text('Fancy',
                  style: TextStyle(color: Color.fromARGB(225, 51, 0, 102))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 5.0,
                    color: Color.fromARGB(255, 191, 128, 255),
                  ),
                  fixedSize: const Size(340, 70),
                  primary: Color.fromARGB(255, 255, 230, 247),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              child: const Text('Warm',
                  style: TextStyle(color: Color.fromARGB(225, 51, 0, 102))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 5.0,
                    color: Color.fromARGB(255, 191, 128, 255),
                  ),
                  fixedSize: const Size(340, 70),
                  primary: Color.fromARGB(255, 255, 230, 247),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              child: const Text('Cold',
                  style: TextStyle(color: Color.fromARGB(225, 51, 0, 102))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 5.0,
                    color: Color.fromARGB(255, 191, 128, 255),
                  ),
                  fixedSize: const Size(340, 70),
                  primary: Color.fromARGB(255, 255, 230, 247),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              child: const Text('Sports',
                  style: TextStyle(color: Color.fromARGB(225, 51, 0, 102))),
            ),
            const SizedBox(height: 90),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.perm_media_outlined,
              ),
              backgroundColor: Colors.pink[300],
            ),
          ],
        ),
      ),
    );
  }
}
