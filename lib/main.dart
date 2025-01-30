import 'package:flutter/material.dart';
import 'package:flutter_application_4/bloc/connectivity/bloc/connectivity_bloc.dart';
import 'package:flutter_application_4/bloc/connectivity/bloc/connectivity_event.dart';
import 'package:flutter_application_4/services/sp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'screens/blog_list_screen.dart';
import 'screens/blog_detail_screen.dart';
import 'services/blog_service.dart';
import 'bloc/blog_bloc.dart';
import 'bloc/blog_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final blogService = BlogService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BlogBloc(blogService)..add(FetchBlogs()),
        ),
        BlocProvider(
          create: (_) => ConnectivityBloc(Connectivity())..add(ConnectivityCheck()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const BlogListScreen(),
          '/details': (_) => const BlogDetailScreen(),
        },
      ),
    );
  }
}
