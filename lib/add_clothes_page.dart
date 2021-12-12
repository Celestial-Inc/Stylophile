import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:crop/crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_simple_image_utils/flutter_simple_image_utils.dart';
import 'package:Stylophile/weather_utils.dart';

class AddClothesPage extends StatefulWidget {
  @override
  _AddClothesPageState createState() => _AddClothesPageState();
}

class _AddClothesPageState extends State<AddClothesPage> {
  final controller = CropController(aspectRatio: 3 / 4);
  String? uncroppedImage;
  String? clothingType;
  String? croppedImage;

  @override
  void initState() {
    super.initState();
    _pickImage();
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String result = await convertImageFileToString(image!);
    setState(() {
      uncroppedImage = result;
    });
  }

  void _pickClothing(String? value) async {
    setState(() {
      clothingType = value;
    });
  }

  void _cropImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    ui.Image cropped = await controller.crop(pixelRatio: pixelRatio);

    String? newCroppedImage = await convertUiImageToString(cropped);
    if (newCroppedImage != null) {
      Random random = Random();
      int randomNumber = random.nextInt(1000000);
      Box hiveBox = Hive.box(clothingType!);
      hiveBox.put('myNewClothing' + randomNumber.toString(), newCroppedImage);

      setState(() {
        croppedImage = newCroppedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (uncroppedImage == null) {
      return new Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
          child: Center(
            child: SpinKitRipple(
              color: Colors.white,
              size: 150.0,
              duration: Duration(milliseconds: 1200),
            ),
          ),
        ),
      ); //return Scaffold(body: SafeArea(child: Center(child: Text('Loading...'))));
    }

    if (clothingType == null) {
      return SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: const Text('Top'),
            leading: Radio<String>(
                value: 'shirts',
                groupValue: clothingType,
                onChanged: _pickClothing),
          ),
          ListTile(
            title: const Text('Bottom'),
            leading: Radio<String>(
                value: 'bottoms',
                groupValue: clothingType,
                onChanged: _pickClothing),
          ),
          ListTile(
            title: const Text('Shoe'),
            leading: Radio<String>(
                value: 'shoes',
                groupValue: clothingType,
                onChanged: _pickClothing),
          ),
        ],
      ));
    }

    if (croppedImage == null) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: ui.Color.fromARGB(255, 230, 100, 210),
          title: const Text('Image Cropping'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: _cropImage,
              tooltip: 'Crop',
              icon: const Icon(Icons.crop),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(8),
                child: Crop(
                  controller: controller,
                  shape: BoxShape.rectangle,
                  child: Image.memory(
                    base64Decode(uncroppedImage!),
                    fit: BoxFit.cover,
                  ),
                  /* It's very important to set `fit: BoxFit.cover`.
                   Do NOT remove this line.
                   There are a lot of issues on github repo by people who remove this line and their image is not shown correctly.
                */
                  helper: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    }

    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Text('Thank you, you added this picture:',
                style: GoogleFonts.notoSans(fontSize: 40))),
        Container(
          width: 400,
          height: 400,
          child: Image.memory(
            base64Decode(croppedImage!),
            fit: BoxFit.contain,
          ),
        ),
      ],
    ));
  }
}
