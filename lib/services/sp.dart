import 'dart:convert';
import 'package:flutter_application_4/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
 

class SharedPreferencesService {
  static const String _cacheKey = "cached_blogs";

  /// Save blogs to SharedPreferences
  Future<void> saveBlogsToCache(List<Blog> blogs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonBlogs = blogs.map((blog) => blog.toJson()).toList();
    await prefs.setString(_cacheKey, jsonEncode(jsonBlogs));
  }

  /// Load blogs from SharedPreferences
  Future<List<Blog>> loadBlogsFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cacheKey);

    if (cachedData != null) {
      final List<dynamic> jsonBlogs = jsonDecode(cachedData);
      return jsonBlogs.map((json) => Blog.fromJson(json)).toList();
    } else {
      throw Exception('No cached blogs available.');
    }
  }

  /// Clear cached blogs
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }

  getBool(String s) {}

  setBool(String s, bool isConnected) {}
}
