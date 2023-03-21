class BaseRepositoryException implements Exception {
  final String? message;
  final StackTrace? stackTrace;


  BaseRepositoryException({
    this.message,
    this.stackTrace,
  });

  
  
}
