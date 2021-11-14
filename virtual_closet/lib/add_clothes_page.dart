import 'dart:math';

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
  }

  void pickClothing(String? value) async {
    Random random = Random();
    int randomNumber = random.nextInt(1000000);
    Box shirtsBox = Hive.box(value!);
    shirtsBox.put('myNewShirt' + randomNumber.toString(), base64Image);
    setState(() {
      clothingType = value;
    });
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

    if (clothingType == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: const Text('Top'),
            leading: Radio<String>(
                value: 'shirts',
                groupValue: clothingType,
                onChanged: pickClothing),
          ),
          ListTile(
            title: const Text('Bottom'),
            leading: Radio<String>(
                value: 'bottoms',
                groupValue: clothingType,
                onChanged: pickClothing),
          ),
          ListTile(
            title: const Text('Shoe'),
            leading: Radio<String>(
                value: 'shoes',
                groupValue: clothingType,
                onChanged: pickClothing),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Thank you, you added this picture:',
            style: TextStyle(fontSize: 40)),
        Image.memory(base64Decode(base64Image!)),
      ],
    );
  }
}
