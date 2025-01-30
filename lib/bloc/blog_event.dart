import 'package:equatable/equatable.dart';

abstract class BlogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}
class MarkAsFavorite extends BlogEvent {
  final int blogId;

  MarkAsFavorite(this.blogId);

  @override
  List<Object> get props => [blogId];
}
