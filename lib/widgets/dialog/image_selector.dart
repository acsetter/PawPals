import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paw_pals/controllers/file_controller.dart';
import 'package:paw_pals/widgets/app_dialogs.dart';

typedef Func = void Function();

class ImageSelector extends StatefulWidget {
  final FileController controller;
  final String? title;

  const ImageSelector({super.key, required this.controller, this.title});

  @override
  State<ImageSelector> createState() => ImageSelectorState();
}

class ImageSelectorState extends State<ImageSelector> {
  final ImagePicker _picker = ImagePicker();
  String get _title => super.widget.title ?? "Upload Image";
  FileController get _controller => super.widget.controller;
  File? image;
  List<Func> listeners = [];

  @override
  void initState() {
    listeners.add(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listeners.forEach((listener) => _controller.addListener(listener));
    return Center(
      child: GestureDetector(
          onTap: () {
            showImageDialog(context: context, controller: _controller);
            // getImageFromGallery();
          },
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: _controller.value == null
                ? const Icon(Icons.camera, size: 30,)
                : ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Image.file(
                  _controller.value!,
                  fit: BoxFit.cover
              ),
            ),
          )
      ),
    );
  }


  @override
  void dispose() {
    listeners.forEach((listener) => _controller.removeListener(listener));
    _controller.dispose();
    super.dispose();
  }
}