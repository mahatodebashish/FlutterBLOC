import 'package:flutter/material.dart';
import 'package:flutter_application_4/model/model.dart';
import 'package:flutter_application_4/services/sp.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve and cast the arguments to Blog type
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final sharedPreferencesService = SharedPreferencesService();

    if (arguments is Blog) {
      final blog = arguments;

      // Save blog as viewed in SharedPreferences
      sharedPreferencesService.setBool('blog_${blog.id}_viewed', true);

      return Scaffold(
        appBar: AppBar(
          title: Text(blog.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image handling with fallback
              blog.image.isNotEmpty
                  ? Image.network(
                      blog.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text('Image could not be loaded'),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No image available'),
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Display an error if arguments are missing or invalid
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Error: Blog details not found'),
        ),
      );
    }
  }
}
