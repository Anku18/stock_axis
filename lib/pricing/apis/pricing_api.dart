import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stock_axis/constants/api_url.dart';
import 'package:stock_axis/pricing/controller/pricing_controller.dart';
import 'package:stock_axis/pricing/models/pricing_data_model.dart';
import 'package:stock_axis/services/api_service.dart';

class PricingApi {
  PricingApi.init();
  static final instance = PricingApi.init();

  final apiService = ApiService(dio: Dio());

  Future<void> getLittleMasterPricingList(
      {required PricingController pricingController}) async {
    try {
      final (
        Response<dynamic>? response,
        ApiErrorStatus? apiStatus
      ) = await apiService
          .request(endpoint: ApiUrl.instance.baseUrl, method: "GET", params: {
        'action': 'search',
        'activity': 'PricingV2',
        'CID': '984493',
        'PKGName': 'LM',
      });

      if (apiStatus != null &&
          apiStatus == ApiErrorStatus.noInternetConnection) {
        return showNoInternetDialog(onTryAgain: getLittleMasterPricingList);
      }
      final PricingDataModel pricingDataModel = PricingDataModel.fromJson(
          jsonDecode(response?.data.split("<!DOCTYPE")[0].trim()));

      if (pricingDataModel.data != null && pricingDataModel.data!.isNotEmpty) {
        pricingController.littleMastersPricingList.clear();
        pricingController.littleMastersPricingList
            .addAll(pricingDataModel.data ?? []);
        pricingController.littleMastersPricingList.insert(0, PricingData());
      }
    } on DioException catch (err) {
      print(err.message.toString());
      print(err.response?.data);
    }
  }

  Future<void> getEmergingMarketLeadersPricingList(
      {required PricingController pricingController}) async {
    try {
      final (
        Response<dynamic>? response,
        ApiErrorStatus? apiStatus
      ) = await apiService
          .request(endpoint: ApiUrl.instance.baseUrl, method: "GET", params: {
        'action': 'search',
        'activity': 'PricingV2',
        'CID': '984493',
        'PKGName': 'EML',
      });

      if (apiStatus != null &&
          apiStatus == ApiErrorStatus.noInternetConnection) {
        return showNoInternetDialog(onTryAgain: getLittleMasterPricingList);
      }
      final PricingDataModel pricingDataModel = PricingDataModel.fromJson(
          jsonDecode(response?.data.split("<!DOCTYPE")[0].trim()));

      if (pricingDataModel.data != null && pricingDataModel.data!.isNotEmpty) {
        pricingController.emergingMarketLeaderPricingList.clear();

        pricingController.emergingMarketLeaderPricingList
            .addAll(pricingDataModel.data ?? []);
        pricingController.emergingMarketLeaderPricingList
            .insert(0, PricingData());
      }
    } on DioException catch (err) {
      print(err.message.toString());
      print(err.response?.data);
    }
  }

  Future<void> getLargeCapFocusPricingList(
      {required PricingController pricingController}) async {
    try {
      final (Response<dynamic>? response, ApiErrorStatus? apiStatus) =
          await apiService.request(
        endpoint: ApiUrl.instance.baseUrl,
        method: "GET",
        params: {
          'action': 'search',
          'activity': 'PricingV2',
          'CID': '984493',
          'PKGName': 'LCF',
        },
      );

      if (apiStatus != null &&
          apiStatus == ApiErrorStatus.noInternetConnection) {
        return showNoInternetDialog(onTryAgain: getLittleMasterPricingList);
      }
      final PricingDataModel pricingDataModel = PricingDataModel.fromJson(
          jsonDecode(response?.data.split("<!DOCTYPE")[0].trim()));

      if (pricingDataModel.data != null && pricingDataModel.data!.isNotEmpty) {
        pricingController.largeCapFousPricingList.clear();

        pricingController.largeCapFousPricingList
            .addAll(pricingDataModel.data ?? []);
        pricingController.largeCapFousPricingList.insert(0, PricingData());
      }
    } on DioException catch (err) {
      print(err.message.toString());
      print(err.response?.data);
    }
  }
}
