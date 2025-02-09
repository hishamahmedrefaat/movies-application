import 'package:flutter/material.dart';
import 'package:task_5/services/FirebaseService.dart';

class MovieDashboard extends StatefulWidget {
  const MovieDashboard({super.key});

  @override
  State<MovieDashboard> createState() => _MovieDashboardState();
}

class _MovieDashboardState extends State<MovieDashboard> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  Map<String, dynamic> movies = {};

  bool _isEditing = false;
  String? _editedMovieId;

  @override
  void initState() {
    super.initState();
    getMoviesData();
  }

  void _saveData() async {
    final title = _titleController.text;
    final rating = _ratingController.text;
    var newMovie = {'title': title, 'rating': double.parse(rating)};
    
    if (_isEditing && _editedMovieId != null) {
      await _firebaseService.editMovie(_editedMovieId!, newMovie);
      setState(() {
        _isEditing = false;
        _editedMovieId = null;
      });
    } else {
      await _firebaseService.addMovie(newMovie);
    }
    
    _titleController.clear();
    _ratingController.clear();
    getMoviesData();
  }

  void getMoviesData() async {
    var response = await _firebaseService.getMovies();
    setState(() {
      movies = response;
    });
  }

  void deleteMovie(String id) async {
    await _firebaseService.deleteMovie(id);
    getMoviesData();
  }

  void _editMovie(String movieId, Map<String, dynamic> movieData) {
    setState(() {
      _isEditing = true;
      _editedMovieId = movieId;
      _titleController.text = movieData['title'];
      _ratingController.text = movieData['rating'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Dashboard'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Movie Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _ratingController,
              decoration: InputDecoration(labelText: 'Movie Rating'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveData,
              child: Text(_isEditing ? 'Edit Movie' : 'Add Movie'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movieId = movies.keys.elementAt(index);
                  final movieData = movies[movieId];
                  return ListTile(
                    title: Text('Title: ${movieData['title']}'),
                    subtitle: Text(
                      'Rating: ${movieData['rating']}',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _editMovie(movieId, movieData);
                          },
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteMovie(movieId);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
