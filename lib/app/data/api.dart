import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
class ApiRequest {
  final Dio _dio = Dio();

  Future<Response> getRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    return response;

  }

  Future<Response> postRequest(String endPoint, dynamic data) async {
    Response response;

    try {
      response = await _dio.post(endPoint, data: data );
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    return response;

  }

  Future<Response> putRequest(String endPoint, dynamic data) async {
    Response response;

    try {
      response = await _dio.put(endPoint, data: data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    return response;

  }

  Future<bool> putRequestValid(String endPoint, String id, dynamic data) async {
    Response response;
    var OkOrNot = false;

    try {
      response = await _dio.put(endPoint +id, data: data);
      OkOrNot = true;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      OkOrNot = false;
      throw Exception(e.message);
    }
    return OkOrNot;

  }

  Future<Response> deleteRequest(String endPoint, String id) async {
    Response response;

    try {
      response = await _dio.delete(endPoint +id );
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    return response;

  }


  Future<Response> deleteLikeRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.delete(endPoint);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      throw Exception(e.message);
    }
    return response;
  }

  Future upload(File image) async {
    try {
      Uint8List bytes = await image.readAsBytes();
      var uploadResponse = await ApiRequest().getRequest('https://agile-refuge-76481.herokuapp.com/s3Url');
      String url = uploadResponse.data;
      var response = await http.put(Uri.parse(url), body: bytes);
      if (response.statusCode == 200) {
        return url.toString().split('?')[0];
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}
