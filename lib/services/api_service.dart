import 'package:dio/dio.dart';
import 'package:task_5/model/movie.dart';
import 'package:task_5/model/TVshow.dart';

class MovieApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));
  final String apiKey = '0ab69d58b9382bc390a939b7dbbe713b';

  /// Fetches currently playing movies (with pagination)
  Future<List<Movie>> getNowPlayingMovies(int pageNumber) async {
    try {
      final response = await _dio.get('/movie/now_playing', queryParameters: {
        'api_key': apiKey,
        'page': pageNumber,
      });

      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      }
      throw Exception('Error casting data');
    } catch (e) {
      throw Exception('Error getting Data');
    }
  }

  /// Fetches popular movies
  Future<List<Movie>> getPopularMovies(int pageNumber) async {
    try {
      final response = await _dio.get('/movie/popular', queryParameters: {
        'api_key': apiKey,
        'page': pageNumber,
      });

      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      }
      throw Exception('Failed to load popular movies (Status: ${response.statusCode})');
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  /// Fetches top-rated movies
  Future<List<Movie>> getTopRatedMovies(int pageNumber) async {
    try {
      final response = await _dio.get('/movie/top_rated', queryParameters: {
        'api_key': apiKey,
        'page': pageNumber,
      });

      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      }
      throw Exception('Failed to load top-rated movies (Status: ${response.statusCode})');
    } catch (e) {
      throw Exception('Error fetching top-rated movies: $e');
    }
  }

  /// Fetches upcoming movies
  Future<List<Movie>> getUpcomingMovies(int pageNumber) async {
    try {
      final response = await _dio.get('/movie/upcoming', queryParameters: {
        'api_key': apiKey,
        'page': pageNumber,
      });

      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      }
      throw Exception('Failed to load upcoming movies (Status: ${response.statusCode})');
    } catch (e) {
      throw Exception('Error fetching upcoming movies: $e');
    }
  }

  /// Fetches movie details by ID
  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final response = await _dio.get('/movie/$movieId', queryParameters: {
        'api_key': apiKey,
      });

      if (response.statusCode == 200) {
        return Movie.fromJson(response.data);
      }
      throw Exception('Failed to load movie details (Status: ${response.statusCode})');
    } catch (e) {
      throw Exception('Error fetching movie details: $e');
    }
  }

  /// Searches for movies by query string
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _dio.get('/search/movie', queryParameters: {
        'api_key': apiKey,
        'query': query,
      });

      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      }
      throw Exception('Failed to search movies (Status: ${response.statusCode})');
    } catch (e) {
      throw Exception('Error searching movies: $e');
    }
  }
}

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3'));
  final String apiKey = '0ab69d58b9382bc390a939b7dbbe713b';

  Future<List<TvShow>> getTvShows(int pageNumber) async {
    try {
      final response = await _dio.get(
        '/tv/popular',
        queryParameters: {'api_key': apiKey, 'page': pageNumber},
      );
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((tvShowJson) => TvShow.fromJson(tvShowJson))
            .toList();
      } else {
        throw Exception('Error casting data');
      }
    } catch (e) {
      throw Exception('Error getting Data');
    }
  }
}
