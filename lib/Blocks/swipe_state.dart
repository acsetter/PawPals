part of 'swipe_block.dart';

abstract class SwipeState extends Equatable{
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeLoading extends SwipeState{}

class SwipeLoaded extends SwipeState{
  final List<PostModel> posts;

  const SwipeLoaded({
    required this.posts,
});
  @override
  List<Object> get props => [posts];
}

class SwipeError extends SwipeState{}