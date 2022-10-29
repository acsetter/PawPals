part of 'swipe_block.dart';

abstract class SwipeEvent extends Equatable{
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends SwipeEvent{
  final List<PostModel> posts;

  const LoadPosts({required this.posts});

  @override
  List<Object> get props => [posts];
}

class SwipeLeft extends SwipeEvent{
  final PostModel post;

  const SwipeLeft({
    required this.post,
});
  @override
  List<Object> get props => [];
}
class SwipeRight extends SwipeEvent{
  final PostModel post;

  const SwipeRight({
    required this.post,
  });
  @override
  List<Object> get props => [];
}


