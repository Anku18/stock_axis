import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:stock_axis/pricing/widgets/custom_button.dart';

enum ApiErrorStatus { reloadScreen, otherError, noInternetConnection }

class ApiService {
  final Dio? dio;

  ApiService({required this.dio});

  Future<(Response?, ApiErrorStatus?)> request({
    required String method,
    required String endpoint,
    dynamic params,
  }) async {
    try {
      Response response;
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        return (null, ApiErrorStatus.noInternetConnection);
      }
      switch (method.toUpperCase()) {
        case 'GET':
          response = await dio!.get(endpoint, queryParameters: params);
          break;
        case 'POST':
          response = await dio!.post(endpoint, data: params);
          break;
        case 'PUT':
          response = await dio!.put(endpoint, data: params);
          break;
        case 'DELETE':
          response = await dio!.delete(endpoint, data: params);
          break;
        default:
          throw UnsupportedError('Method not supported');
      }
      print(response.realUri);
      return (response, null);
    } on DioException catch (e) {
      print(e.response?.realUri);
      ApiErrorStatus status = await _handleError(e);

      if (status == ApiErrorStatus.reloadScreen) {
        return (e.response, status);
      }
      // Fluttertoast.showToast(msg: "Something went wrong");
      return Future.error(e);
    }
  }

  // Error handling
  Future<ApiErrorStatus> _handleError(DioException error) async {
    try {
      final Response? response = error.response;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          debugPrint('Connection Timeout Error');
          break;
        case DioExceptionType.badResponse:
          debugPrint(
              'Received invalid status code: ${error.response?.statusCode}');
          break;
        case DioExceptionType.cancel:
          debugPrint('Request was cancelled');
          break;
        case DioExceptionType.unknown:
          debugPrint('Other Error: ${error.message}');
          break;
        case DioExceptionType.sendTimeout:
          debugPrint('Timeout Error: ${error.message}');
          break;
        case DioExceptionType.badCertificate:
          debugPrint('Bad Certificate Error: ${error.message}');
          break;
        case DioExceptionType.connectionError:
          debugPrint('Connection Error: ${error.message}');
          break;
      }

      throw error;
    } catch (e) {
      rethrow;
    }
  }
}

void showNoInternetDialog({required Function onTryAgain}) {
  getx.Get.dialog(
    barrierDismissible: false,
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.signal_wifi_off,
              size: 60,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 16),
            const Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please check your internet connection and try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () async {
                getx.Get.back();
                onTryAgain();
              },
              buttonTitle: "Try Again!",
            ),
          ],
        ),
      ),
    ),
  );
}
