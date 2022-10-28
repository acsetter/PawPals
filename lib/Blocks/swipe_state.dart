part of 'swipe_block.dart';

abstract class SwipeState{
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeLoading extends SwipeState{}

class SwipeLoaded extends SwipeState{}

class SwipeError extends SwipeState{}