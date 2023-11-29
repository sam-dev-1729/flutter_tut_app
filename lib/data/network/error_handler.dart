// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_tut_app/data/network/failure.dart';

enum DataSource {
  SUCCESS, //200 The request succeeded.
  ACCEPTED, //202 The request has been received but not yet acted upon
  NO_CONTENT, // 204 There is no content to send for this request, but the headers may be useful.
  BAD_REQUEST, //400 The server cannot or will not process the request due to something that is perceived to be a client error
  UNAUTHORISED, //401 the client request has not been completed because it lacks valid authentication credentials for the requested resource.
  FORBIDDEN, //403 The client does not have access rights to the content
  NOT_FOUND, //404 The server cannot find the requested resource.
  REQUEST_TIMEOUT, //408 server would like to shut down this unused connection
  TOO_MANY_REQUEST, //429 The user has sent too many requests in a given amount of time ("rate limiting").
  INTERNAL_SERVER_ERROR, //500 The server has encountered a situation it does not know how to handle.
  BAD_GATEWAY, // 502 the server, while working as a gateway to get a response needed to handle the request, got an invalid response.
  SERVICE_UNAVAILABLE, // 503 The server is not ready to handle the request
  GATEWAY_TIMEOUT, //504  the server is acting as a gateway and cannot get a response in time.

  // local status code
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handel(dynamic error) {
    print(error);
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.DEFAULT.getFailure();

      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }

      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();

      case DioExceptionType.connectionError:
        return DataSource.NO_INTERNET_CONNECTION.getFailure();

      case DioExceptionType.unknown:
        return DataSource.DEFAULT.getFailure();
      default:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

extension ErrorHandleExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.REQUEST_TIMEOUT:
        return Failure(
            ResponseCode.REQUEST_TIMEOUT, ResponseMessage.REQUEST_TIMEOUT);
      case DataSource.TOO_MANY_REQUEST:
        return Failure(
            ResponseCode.TOO_MANY_REQUEST, ResponseMessage.TOO_MANY_REQUEST);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.BAD_GATEWAY:
        return Failure(ResponseCode.BAD_GATEWAY, ResponseMessage.BAD_GATEWAY);
      case DataSource.SERVICE_UNAVAILABLE:
        return Failure(ResponseCode.SERVICE_UNAVAILABLE,
            ResponseMessage.SERVICE_UNAVAILABLE);
      case DataSource.GATEWAY_TIMEOUT:
        return Failure(
            ResponseCode.GATEWAY_TIMEOUT, ResponseMessage.GATEWAY_TIMEOUT);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200;

  static const int ACCEPTED = 202;
  static const int NO_CONTENT = 204;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORISED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int REQUEST_TIMEOUT = 408;
  static const int TOO_MANY_REQUEST = 429;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;
// app status
  static const int CONNECT_TIMEOUT = -3;
  static const int CANCEL = -4;
  static const int RECEIVE_TIMEOUT = -5;
  static const int SEND_TIMEOUT = -6;
  static const int CACHE_ERROR = -7;
  static const int NO_INTERNET_CONNECTION = -8;
  static const int DEFAULT = -9;
}

class ResponseMessage {
  static const String SUCCESS = " The request succeeded.";

  static const String ACCEPTED =
      " The request has been received but not yet acted upon.";
  static const String NO_CONTENT =
      " There is no content to send for this request.";
  static const String BAD_REQUEST =
      " Bad request! The server cannot or will not process the request, try again later";
  static const String UNAUTHORISED = " Unauthorized! ";
  static const String FORBIDDEN =
      " Forbidden! You do not have access rights to the content";
  static const String NOT_FOUND =
      " Not found! The server cannot find the requested resource";
  static const String REQUEST_TIMEOUT = " Request timeout! try again later";
  static const String TOO_MANY_REQUEST =
      " Too many request! You have sent too many requests in a given amount of time, try again later";
  static const String INTERNAL_SERVER_ERROR =
      " Internal server error! something went wrong . we'll back soon!";
  static const String BAD_GATEWAY = " Bad Gateway";
  static const String SERVICE_UNAVAILABLE = " Server Unavailable";
  static const String GATEWAY_TIMEOUT = " Gateway Timeout";

  // local status code
  static const String DEFAULT = "some thing went wrong, try again later";
  static const String CONNECT_TIMEOUT = "time out error, try again later";
  static const String CANCEL = "request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "time out error, try again later";
  static const String SEND_TIMEOUT = "time out error, try again later";
  static const String CACHE_ERROR = "Cache error, try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
}
