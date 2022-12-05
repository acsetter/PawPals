import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:paw_pals/widgets/wrappers/field_wrapper.dart';
import 'package:paw_pals/constants/app_icons.dart';
import 'package:paw_pals/controllers/file_controller.dart';
import 'package:paw_pals/services/storage_service.dart';
import 'package:paw_pals/widgets/app_button.dart';

Future<T?> showImageDialog<T>({
  required BuildContext context,
  required FileController controller,
  String? title,
}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? "Upload Image"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FieldWrapper(
                child: AppButton(
                  appButtonType: AppButtonType.contained,
                  label: "Camera",
                  onPressed: () => StorageService
                    .pickImageFrom(ImageSource.camera)
                    .then((file) {
                      // update controller with file from device
                      controller.value = file;
                      Navigator.of(context).pop(); // close dialog
                  }),
                  icon: AppIcons.camera,
                ),
              ),
              FieldWrapper(
                child: AppButton(
                  appButtonType: AppButtonType.contained,
                  label: "Gallery",
                  onPressed: () => StorageService
                    .pickImageFrom(ImageSource.gallery)
                    .then((file) {
                      // update controller with file from device
                      controller.value = file;
                      Navigator.of(context).pop(); // close dialog
                  }),
                  icon: AppIcons.gallery,
                ),
              ),
            ],
          ),
          actions: [
            AppButton(
              label: "Cancel",
              onPressed: () => Navigator.of(context).pop(),
              appButtonType: AppButtonType.text
            ),
          ],
        );
      });
}