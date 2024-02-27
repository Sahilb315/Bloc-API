part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

abstract class PostActionState extends PostsState {}

final class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsSuccessState extends PostsState {
  final List<PostsDataModel> postsList;

  PostsSuccessState({required this.postsList});
}

class PostsErrorState extends PostsState {
  final String error;
  PostsErrorState({required this.error});
}

class PostAddActionState extends PostActionState {}

// For Snackbar
class PostAddedActionState extends PostActionState {}

// For Snackbar
class PostNotAddedActionState extends PostActionState {}
