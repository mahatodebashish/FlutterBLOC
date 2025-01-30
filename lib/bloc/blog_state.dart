import "package:equatable/equatable.dart";

class BlogState extends Equatable {
  final List<dynamic> blogs;
  final List<int> favoriteBlogIds;
  final bool isLoading;
  final String? errorMessage;

  const BlogState({
    this.blogs = const [],
    this.favoriteBlogIds = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  BlogState copyWith({
    List<dynamic>? blogs,
    List<int>? favoriteBlogIds,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BlogState(
      blogs: blogs ?? this.blogs,
      favoriteBlogIds: favoriteBlogIds ?? this.favoriteBlogIds,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [blogs, favoriteBlogIds, isLoading, errorMessage];
}

