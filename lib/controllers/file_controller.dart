import 'dart:io';
import 'package:flutter/material.dart';

class FileController extends ValueNotifier<File?> {
    FileController({File? file}) : super(file);
}