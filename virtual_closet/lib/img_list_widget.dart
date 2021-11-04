import 'dart:io';
import 'package:flutter/cupertino.dart';

class ImageListWidget extends StatelessWidget {
  final List<File> imageFiles;

  const ImageListWidget({
    required Key? key,
    required this.imageFiles,
  }) : super(key: key);

  File? get imageFile => null;

  @override
  Widget build(BuildContext context) => GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: imageFiles
            .map((imageFiles) => ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(imageFile!),
                ))
            .toList(),
      );
}
