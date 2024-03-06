import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:findigitalservice/app_provider.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class DaybookService {
  static BaseOptions options = BaseOptions(
    baseUrl: "http://localhost:8080/api/daybook",
  );
  final Dio _dio = Dio(options);

  Future<dynamic> count(
      AppProvider provider, Map<String, dynamic> param) async {
    try {
      String url = '/count';
      if (param.isNotEmpty) {
        url += '?${Uri(queryParameters: param).query}';
      }
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer ${provider.accessToken}'},
        ),
      );
      //returns the successful user data json object
      return response.data;
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<dynamic> findAll(
      AppProvider provider, Map<String, dynamic> param) async {
    try {
      String url = '';
      if (param.isNotEmpty) {
        url = '?${Uri(queryParameters: param).query}';
      }
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer ${provider.accessToken}'},
        ),
      );
      //returns the successful user data json object
      return response.data;
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<dynamic> findById(AppProvider provider, String id) async {
    try {
      Response response = await _dio.get(
        '/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${provider.accessToken}'},
        ),
      );
      //returns the successful user data json object
      return response.data;
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<dynamic> save(AppProvider provider, Map<String, dynamic>? data) async {
    try {
      Response response;
      final options = Options(
        headers: {'Authorization': 'Bearer ${provider.accessToken}'},
      );
      if (data?['id'] != "" && data?['id'] != null) {
        final id = data?['id'];
        response = await _dio.put('/$id', //ENDPONT URL
            data: data, //REQUEST BODY
            options: options);
      } else {
        data?['id'] = null;
        data?['daybookDetails'] = [];
        response = await _dio.post('', //ENDPONT URL
            data: data, //REQUEST BODY
            options: options);
      }
      return response.data;
    } on DioException catch (e) {
      //returns the error object if there is
      return e.response!.data;
    }
  }

  Future<dynamic> delete(AppProvider provider, String id) async {
    try {
      Response response = await _dio.delete(
        '/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${provider.accessToken}'},
        ),
      );
      //returns the successful user data json object
      return response.data;
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<void> downloadExcel(
      AppProvider provider, String id, String fileName) async {
    try {
      if (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux) {
        Response response = await _dio.get(
          '/generate/excel/$id',
          options: Options(
            headers: {'Authorization': 'Bearer ${provider.accessToken}'},
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: Duration.zero,
          ),
        );

        final base64 = base64Encode(response.data);

        // Create the link with the file
        // AnchorElement comes from the
        final anchor = html.AnchorElement(
            href: 'data:application/octet-stream;base64,$base64')
          ..target = 'blank';

        // add the name and extension
        anchor.download = fileName;

        // add the anchor to the document body
        html.document.body?.append(anchor);

        // trigger download
        anchor.click();

        // remove the anchor
        anchor.remove();
      } else {
        await _dio.download("/generate/excel/$id",
            "${(await getDownloadsDirectory())?.path}/$fileName");
      }
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future<void> downloadFinancialStatement(AppProvider provider, String company,
      String year, String fileName) async {
    try {
      String url = "/generate/financial/$company/$year";
      if (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux) {
        Response response = await _dio.get(
          url,
          options: Options(
            headers: {'Authorization': 'Bearer ${provider.accessToken}'},
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: Duration.zero,
          ),
        );

        final base64 = base64Encode(response.data);

        // Create the link with the file
        // AnchorElement comes from the
        final anchor = html.AnchorElement(
            href: 'data:application/octet-stream;base64,$base64')
          ..target = 'blank';

        // add the name and extension
        anchor.download = fileName;

        // add the anchor to the document body
        html.document.body?.append(anchor);

        // trigger download
        anchor.click();

        // remove the anchor
        anchor.remove();
      } else {
        await _dio.download(
            url, "${(await getDownloadsDirectory())?.path}/$fileName");
      }
    } on DioException catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }
}
