// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/features/posts/model/posts_mode.dart';
import 'package:bloc_api/features/posts/repo/posts_repo.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialEvent>(postsInitialEvent);
    on<PostShowBottomSheetEvent>(postShowBottomSheetEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialEvent(
      PostsInitialEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());

    List<PostsDataModel> posts = await PostsRepo.fetchPosts();
    emit(PostsSuccessState(postsList: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    final postAddedOrNot = await PostsRepo.addPost(event.title, event.body);
    if (postAddedOrNot) {
      emit(PostAddedActionState());
    } else {
      emit(PostNotAddedActionState());
    }
  }

  FutureOr<void> postShowBottomSheetEvent(
      PostShowBottomSheetEvent event, Emitter<PostsState> emit) {
    emit(PostAddActionState());
  }
}
