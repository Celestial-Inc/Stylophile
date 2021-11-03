import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'add_images_page.dart';

class AddClothesPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AddClothesPage> with SingleTickerProviderStateMixin {
  late TabController controller;
  bool isGallery = true;
  int index = 2;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                controller: controller,
                indicatorWeight: 3,
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(text: 'Images'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  IndexedStack(
                    index: index,
                    children: [
                      AddClothesPage(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
