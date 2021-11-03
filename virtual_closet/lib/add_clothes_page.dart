import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

class AddClothesPage extends StatefulWidget {
  @override
  _AddClothesPageState createState() => _AddClothesPageState();
}

class _AddClothesPageState extends State<AddClothesPage> {
  bool isImageSelected = false;
  bool isClothingTypeSelected = false;
  String? base64Image;
  String? clothingType;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    List<int> imageBytes = await image!.readAsBytes();
    base64Image = base64Encode(imageBytes);
    setState(() {
      isImageSelected = true;
    });

    //Box shirtsBox = Hive.box('shirts');
    //shirtsBox.put('myNewShirt', base64Image); //todo: generate a random image name
    //setState(() {
    //  isClothingTypeSelected = true;
    //});
    //
  }

  @override
  void initState() {
    super.initState();
    pickImage();
  }

  @override
  Widget build(BuildContext context) {
    if (isImageSelected == false) {
      return Scaffold(body: Center(child: Text('Loading...')));
    }

    if (isClothingTypeSelected == false) {
      // todo: ask the user if they want to save a shirt, bottom, or shoe
      return Scaffold(body: Center(child: Text('Select what type of clothing...')));
    }

    // todo: show the user their image and a nice message
    return Scaffold(body: Center(child: Text('Thank you, you added x... ')));
  }
}
