import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:virtual_closet/img_utils.dart';
import 'package:image_cropper_example/widget/floating_button.dart';
import 'img_list_widget.dart';

class AddClothesPage extends StatefulWidget {
  final bool isGallery;

  const AddClothesPage({
    Key key,
    @required this.isGallery,
  }) : super(key: key);

  @override 
  _AddClothesPageState createState => _AddClothesPageState();
}

class _AddClothesPageState extends State<AddClothesPage> {
  List<File> imageFiles = [];

  @override 
  Widget build(BuildContext context) => Scaffold(
    body: ImageListWidget(imageFiles: imageFiles),
    floatingActionButton:  FloatingButtonWidget(OnClicked: onClickedButton()),
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
  Future<File> cropSquareImage(File imageFile) async =>
    await ImageCropper.cropImage(
      sourcePath: ImageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      );
}