import '../../../utils/exception.dart';
import '../../models/movies/movies_table_model.dart';
import '../db/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchList(MovieTableModel movie);
  Future<String> removeWatchList(MovieTableModel movie);
  Future<MovieTableModel?> getWatchlistById(int id);
  Future<List<MovieTableModel>> getWatchlist();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchList(MovieTableModel movie) async {
    try {
      await databaseHelper.insertWatchListMovie(movie);

      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchList(MovieTableModel movie) async {
    try {
      await databaseHelper.removeWatchlistMovie(movie);

      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTableModel?> getWatchlistById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTableModel.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTableModel>> getWatchlist() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTableModel.fromMap(data)).toList();
  }
}
