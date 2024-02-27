part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class PostsInitialEvent extends PostsEvent {}

class PostAddEvent extends PostsEvent {
  final String title;
  final String body;

  PostAddEvent({
    required this.title,
    required this.body,
  });
}

class PostShowBottomSheetEvent extends PostsEvent {}
