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
        return ServerFailure(
          errorMessage: 'Connection Timeout with Api server, please try again',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMessage: 'Send Timeout with Api server , please try again',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMessage: 'Receive Timeout , please try again',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage: 'Bad Certificate , please try again',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.badResponse(
          statusCode: dioException.response!.statusCode!,
          response: dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage: 'Request Canceled , please try again',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage: ' No Internet Connection  , please try again',
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: 'oops there was an error , please try again',
        );
    }
  }
  factory ServerFailure.badResponse({
    required int statusCode,
    required dynamic response,
  }) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(errorMessage: "your request is not found");
    } else if (statusCode == 500) {
      return ServerFailure(
        errorMessage: "there is a problem with the server , please try later",
      );
    } else {
      return ServerFailure(
        errorMessage: 'oops there was an error , please try again',
      );
    }
  }
}
