
class Blog {
  final String id;
  final String title;
  final String image;
  final String content;

  Blog({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled',
      image: json['image_url'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': image,
      'content': content,
    };
  }
}
