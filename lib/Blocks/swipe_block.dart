import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paw_pals/models/post_model.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBlock extends Bloc<SwipeEvent, SwipeState>{
  SwipeBlock() : super(SwipeLoading()){
    on<LoadPosts>(_onLoadPosts);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);
  }

  void _onLoadPosts(
      LoadPosts event,
      Emitter<SwipeState> emit,
      ) {
    emit(SwipeLoaded(posts: event.posts));
  }

  void _onSwipeLeft(
      SwipeLeft event,
      Emitter<SwipeState> emit,
      ) {
    if (state is SwipeLoaded){
      final state = this.state as SwipeLoaded;
        emit(SwipeLoaded(posts: List.from(state.posts)..remove(event.post),
        ),
        );
    }
  }

  void _onSwipeRight(
      SwipeRight event,
      Emitter<SwipeState> emit,
      ) {
    if (state is SwipeLoaded){
      final state = this.state as SwipeLoaded;

        emit(SwipeLoaded(posts: List.from(state.posts)..remove(event.post),
        ),
        );

    }
  }

}

