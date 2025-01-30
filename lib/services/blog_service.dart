import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

class BlogService {
  static const String _apiUrl = "https://intent-kit-16.hasura.app/api/rest/blogs";
  static const String _apiKey = "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6";
  static const String _cacheKey = "cached_blogs";

  final Connectivity _connectivity = Connectivity();

  Future<List<Blog>> fetchBlogs() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Online: Fetch from API and cache data
      try {
        final response = await http
            .get(
              Uri.parse(_apiUrl),
              headers: {'x-hasura-admin-secret': _apiKey},
            )
            .timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body) as Map<String, dynamic>;
          final blogs = _parseBlogs(json);

          // Cache the blogs
          await _cacheBlogs(blogs);

          return blogs;
        } else {
          throw Exception('Failed to load blogs. Status Code: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Error fetching blogs: $e');
      }
    } else {
      // Offline: Load from cache
      return await _loadCachedBlogs();
    }
  }

  Future<void> _cacheBlogs(List<Blog> blogs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonBlogs = blogs.map((blog) => blog.toJson()).toList();
    await prefs.setString(_cacheKey, jsonEncode(jsonBlogs));
  }

  Future<List<Blog>> _loadCachedBlogs() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cacheKey);

    if (cachedData != null) {
      final List<dynamic> jsonBlogs = jsonDecode(cachedData);
      return jsonBlogs.map((json) => Blog.fromJson(json)).toList();
    } else {
      throw Exception('No cached data available.');
    }
  }

  List<Blog> _parseBlogs(Map<String, dynamic> json) {
    final blogsJson = json['blogs'];
    if (blogsJson is List) {
      return blogsJson.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Invalid JSON format: "blogs" key is missing or not a list');
    }
  }
} 