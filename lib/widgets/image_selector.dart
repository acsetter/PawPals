import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:paw_pals/constants/app_data.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/controllers/file_controller.dart';
import 'package:paw_pals/widgets/app_dialogs.dart';
import 'package:paw_pals/utils/app_log.dart';

typedef Func = void Function();

class ImageSelector extends StatefulWidget {
  final FileController controller;
  final String? initialUrl;

  const ImageSelector({super.key, required this.controller, this.initialUrl});

  @override
  State<ImageSelector> createState() => ImageSelectorState();
}

class ImageSelectorState extends State<ImageSelector> {
  FileController get _controller => super.widget.controller;
  String? get _initialUrl => super.widget.initialUrl;
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
    if (_controller.value != null) {
      Logger.log(_controller.value!.path);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
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
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: _controller.value != null
                              ? Image.file(_controller.value!, fit: BoxFit.cover)
                              : _initialUrl != null
                              ? CachedNetworkImage(
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                imageUrl: _initialUrl!,
                                fit: BoxFit.cover)
                              : Image(image: AppData.defaultProfile, fit: BoxFit.cover,)
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                          ),
                          child: Icon(
                            AppIcons.addPhoto.icon,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              )
            ),
          ]
        ),
      ],
    );
  }

  @override
  void dispose() {
    listeners.forEach((listener) => _controller.removeListener(listener));
    _controller.dispose();
    super.dispose();
  }
}