import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:findigitalservice/app_provider.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ReportService {
  static BaseOptions options = BaseOptions(
    baseUrl: "http://localhost:8080/api/report",
  );
  final Dio _dio = Dio(options);

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

  Future<dynamic> findLedgerAccount(
      AppProvider provider, String company, String year) async {
    try {
      Response response = await _dio.get(
        "/ledger/account/$company/$year",
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
}
