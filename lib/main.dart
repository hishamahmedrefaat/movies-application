import 'package:flutter/material.dart';
import 'package:task_5/screen/home.dart';
import 'package:task_5/screen/MovieList.dart';
import 'package:task_5/screen/MovieDashboard.dart';
import 'package:task_5/screen/TvShowListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'movies': (context) => MovieListPage(),
        '/movie_dashboard': (context) => MovieDashboard(),
        '/tv_shows': (context) => TvShowListPage(),
      },
    );
  }
}
