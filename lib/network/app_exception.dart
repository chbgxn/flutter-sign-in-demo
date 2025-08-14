class AppException implements Exception {
  final String message;
  final String? detail;
  final int? code;
  final ExceptionType type;

  AppException({
    required this.message, 
    this.detail, 
    this.code, 
    this.type = ExceptionType.unknown
  });

  @override
  String toString() => message;
}

enum ExceptionType {
  network,
  timeout,
  business,
  parse,
  unknown
}