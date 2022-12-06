import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paw_pals/controllers/file_controller.dart';
import 'package:paw_pals/widgets/app_dialogs.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/utils/app_log.dart';

typedef Func = void Function();

/// A widget for displaying images from the web via a URL.
/// To make the image editable, specify a [FileController] controller that
/// will update its value with a file upon user selection.
class AppImage extends StatefulWidget {
  /// The target image that is displayed.
  final String? imageUrl;
  /// The controller that holds the value of the [File] of the newly picked image.
  /// If controller is not null, the image will assumed to be editable and
  /// and photo editing features will be accessible.
  final FileController? controller;
  /// A default [AssetImage] to display if URL is null or on loading error.
  final AssetImage? defaultImage;
  /// The width of the image area.
  final double width;
  /// The height of the image area.
  final double height;
  /// The shape of the image area.
  final BoxShape shape;

  const AppImage({
    super.key,
    this.imageUrl,
    this.controller,
    this.defaultImage,
    this.width = 180,
    this.height = 180,
    this.shape = BoxShape.circle,
  });

  @override
  State<AppImage> createState() => AppImageState();

}

class AppImageState extends State<AppImage> {
  bool isEditable = false;
  String? get _url => super.widget.imageUrl;
  FileController? get _controller => super.widget.controller;
  AssetImage? get _default => super.widget.defaultImage;
  double get _width => super.widget.width;
  double get _height => super.widget.height;
  BoxShape get _shape => super.widget.shape;

  File? image;
  List<Func> listeners = [];

  Widget _gestureWrapper(BuildContext context, {required Widget child}) {
    return isEditable
        ? GestureDetector(
            onTap: () => showImageDialog(context: context, controller: _controller!),
            child: child)
        : child;
  }

  Widget _editIcon(BuildContext context) {
    // maintain intended ratios
    double containerSize = (50 * (_width/180)).roundToDouble();
    double padSize = (5 * (_width/180)).roundToDouble();
    double iconSize = (30 * (_width/180)).roundToDouble();

    return Opacity(
      opacity: 0.5,
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, padSize, padSize),
          alignment: Alignment.bottomRight,
          child: Container(
            height: containerSize,
            width: containerSize,
            decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
            ),
            child: Icon(
              AppIcons.addPhoto.icon,
              size: iconSize,
              color: Colors.white,
            ),
          )
      ),
    );
  }

  @override
  void initState() {
    isEditable = _controller != null && !kIsWeb;
    _controller?.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var listener in listeners) {
      _controller?.addListener(listener);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _gestureWrapper(context,
                child: Container(
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: _shape,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: _shape == BoxShape.circle ? BorderRadius.circular(300) : BorderRadius.zero,
                        child: _controller?.value != null
                          ? Image.file(_controller!.value!, fit: BoxFit.cover)
                          : _url != null
                            ? CachedNetworkImage(
                              imageUrl: _url!,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, e, d) {
                                Logger.log(e.toString());
                                return AppIcons.image;
                              },
                              fit: BoxFit.cover)
                            : _default != null
                            ? Image(image: _default!, fit: BoxFit.cover)
                            : Opacity(opacity: 0.5, child: AppIcons.image),
                      ),
                      // display edit icon if controller is not null
                      if (_controller != null) _editIcon(context)
                    ],
                  ),
                )
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    for (var listener in listeners) {
      _controller?.removeListener(listener);
    }
    _controller?.dispose();
    super.dispose();
  }

}