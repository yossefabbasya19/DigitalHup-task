import 'package:dio/dio.dart';

class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: "connectionTimeout");
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: "sendTimeout");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: "receiveTimeout");
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: "badCertificate");
      case DioExceptionType.badResponse:
        return ServerFailure.badResponse(dioException);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: "request canceled");
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: "connection error");
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: "there was an error , please try later",
        );
    }
  }

  factory ServerFailure.badResponse(DioException dioException) {
    if (
    dioException.response!.statusCode == 404 ||
    dioException.response!.statusCode == 426 ||
    dioException.response!.statusCode == 429 ||
        dioException.response!.statusCode == 401
    ) {
      return ServerFailure(
        errorMessage: dioException.response!.data["message"],
      );
    } else {
      return ServerFailure(
        errorMessage: "there was an error , please try later",
      );
    }
  }
}
