import 'package:flutter/material.dart';
import 'package:task_5/model/TVshow.dart';

class TvShowDetailsPage extends StatelessWidget {
  final TvShow tvShow;

  const TvShowDetailsPage({Key? key, required this.tvShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tvShow.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://image.tmdb.org/t/p/w500${tvShow.posterPath}'),
            SizedBox(height: 16),
            Text(
              tvShow.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              tvShow.overview,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}