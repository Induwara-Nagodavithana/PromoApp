import 'package:dio/dio.dart';

class HttpService {
  static final Dio _instance = Dio();

  HttpService() {}

  Dio getInstance() {
    return _instance;
  }

  HttpService.getInstance();
}
