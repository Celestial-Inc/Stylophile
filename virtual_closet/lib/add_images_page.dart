import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:virtual_closet/img_utils.dart';
import 'package:virtual_closet/floating_button.dart';
import 'img_list_widget.dart';

class AddImagesPage extends StatefulWidget {
  final bool isGallery;

  const AddImagesPage({
    required Key key,
    required this.isGallery,
  }) : super(key: key);

  @override
  _AddImagesPageState createState() => _AddImagesPageState();
}

class _AddImagesPageState extends State<AddImagesPage> {
  List<File> imageFiles = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ImageListWidget(imageFiles: imageFiles),
        floatingActionButton: FloatingButtonWidget(onClicked: onClickedButton),
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

  Future<File?> cropSquareImage(File imageFile) async => await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        compressQuality: 70,
        compressFormat: ImageCompressFormat.jpg,
      );
  // ignore: prefer_const_constructors
  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
      );
}
