import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_closet/img_utils.dart';
import 'package:virtual_closet/floating_button.dart';
import 'img_list_widget.dart';

class AddImagesPage extends StatefulWidget {
  final bool isGallery;
  late bool isImageSelected = false;
  final bool isClothingTypeSelected = false;
  late String? base64Image;
  final String? clothingType;

  AddImagesPage({Key? key, required this.isGallery, this.base64Image, this.clothingType}) : super(key: key);
  
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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void setState(Null Function() param0) {}
}
  @override
  _AddImagesPageState createState() => _AddImagesPageState();
}

class _AddImagesPageState extends State<AddImagesPage> {
  List<File> imageFiles = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ImageListWidget(
          imageFiles: imageFiles,
          key: null,
        ),
        floatingActionButton: FloatingButtonWidget(
          onClicked: onClickedButton,
          key: null,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  Future onClickedButton() async {
    final file = await Utils.pickMedia(
      isGallery: widget.isGallery,
      cropImage: cropSquareImage,
    );

    if (file == null) return;
    imageFiles.add(file);
  }

  Future<File> cropSquareImage(File imageFile) async {
    await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
    );
  }

  AndroidUiSettings androidUiSettingsLocked() => const AndroidUiSettings(
        toolbarTitle: 'Crop',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
      );
}
