// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException(message: $message)';
}
