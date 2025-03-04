import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:stock_axis/pricing/apis/pricing_api.dart';
import 'package:stock_axis/pricing/models/pricing_data_model.dart';
import 'package:stock_axis/services/api_service.dart';

class PricingController extends GetxController {
  RxList<PricingData> littleMastersPricingList = RxList();
  RxList<PricingData> emergingMarketLeaderPricingList = RxList();
  RxList<PricingData> largeCapFousPricingList = RxList();

  PricingData? selectedLM;
  PricingData? selectedEML;
  PricingData? selectedLCF;

  RxNum totalPricing = RxNum(0);

  RxNum savedAmount = RxNum(0);

  void calculateTotalWithDiscount() {
    // Collect non-null selections
    List<PricingData> selectedItems = [selectedLM, selectedEML, selectedLCF]
        .where((item) => item != null)
        .cast<PricingData>()
        .toList();

    if (selectedItems.length >= 2) {
      double totalAmount =
          selectedItems.fold(0.0, (sum, item) => sum + (item.pAmount ?? 0));
      totalPricing.value = totalAmount * 0.8; // Apply 20% discount
      return;
    }

    totalPricing.value = selectedItems.fold(
        0.0, (sum, item) => sum + (item.pAmount ?? 0)); // Return normal total
  }

  void calculateSavedAmount() {
    List<PricingData> selectedItems = [selectedLM, selectedEML, selectedLCF]
        .where((item) => item != null)
        .cast<PricingData>()
        .toList();

    if (selectedItems.length >= 2) {
      double totalAmount =
          selectedItems.fold(0.0, (sum, item) => sum + (item.pAmount ?? 0));
      savedAmount.value = totalAmount * 0.2; // 20% saved amount
      return;
    }

    savedAmount.value = 0.0;
  }

  Future<void> getAllPricingDetail() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      showNoInternetDialog(onTryAgain: getAllPricingDetail);
      return;
    }
    Future.wait([
      PricingApi.instance.getLittleMasterPricingList(pricingController: this),
      PricingApi.instance
          .getEmergingMarketLeadersPricingList(pricingController: this),
      PricingApi.instance.getLargeCapFocusPricingList(pricingController: this),
    ]);
  }
}
