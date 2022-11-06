import 'dart:async';

import 'package:flutter/material.dart';

import '../models/post_model.dart';

class FeedStream extends ChangeNotifier {
  static final _instance = FeedStream._();
  static FeedStream get instance => _instance;

  final StreamController<List<PostModel>?> _feedController = StreamController<List<PostModel>?>.broadcast();
  List<PostModel>? _postModels;
  StreamSubscription<List<PostModel>>? _querySub;

  FeedStream._() {
    addListener(_updateStream);
  }



  void _updateStream() {
    //
  }

  @override
  void dispose() {
    removeListener(_updateStream);
    super.dispose();
  }
}