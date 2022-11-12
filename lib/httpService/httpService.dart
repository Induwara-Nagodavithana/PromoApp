import 'package:dio/dio.dart';

class HttpService {
  static final Dio _instance = Dio();

  HttpService() {}

  Dio getInstance() {
    _instance.options.baseUrl = 'https://jm2fwv34x0.execute-api.us-east-1.amazonaws.com';
    return _instance;
  }

  HttpService.getInstance();
}
