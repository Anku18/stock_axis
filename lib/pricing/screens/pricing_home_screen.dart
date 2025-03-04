// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_axis/pricing/controller/pricing_controller.dart';
import 'package:stock_axis/pricing/widgets/pricing_item.dart';
import 'package:stock_axis/pricing/widgets/proceedtopay_cta.dart';
import 'package:stock_axis/pricing/widgets/saved_amount.dart';

class PricingHomeScreen extends StatefulWidget {
  const PricingHomeScreen({super.key});

  @override
  State<PricingHomeScreen> createState() => _PricingHomeScreenState();
}

class _PricingHomeScreenState extends State<PricingHomeScreen> {
  final pricingController = Get.put(PricingController());

  @override
  void initState() {
    pricingController.getAllPricingDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        // backgroundColor: const Color(0xffF1F1F1),
        elevation: 2,
        centerTitle: false,
        title: const Text("Pricing"),
        actions: [
          // Icon Button for Navigating to Support Feature
          IconButton(
              onPressed: () {
                // Navigate to Support
              },
              icon: const Icon(Icons.headset_mic_sharp))
        ],
      ),
      body: Column(
        children: [
          Obx(() => pricingController.savedAmount.value > 0
              ? SavedAmountWidget(
                  amount: pricingController.savedAmount.value,
                )
              : const SizedBox()),
          ListView(
            shrinkWrap: true,
            // padding: const EdgeInsets.all(8),
            children: [
              Obx(
                () => PricingItem(
                  title: 'Little Masters',
                  subTitle: "Small cap",
                  description:
                      "Invest in up-trending Smallcap stocks screened through MILARS strategy to generate wealth.",
                  leadingIcon: Icons.diamond_outlined,
                  itemList: pricingController.littleMastersPricingList.value,
                  onSelected: (val) {
                    pricingController.selectedLM = null;
                    if (val?.pAmount != null) {
                      pricingController.selectedLM = val;
                    }
                    pricingController.calculateTotalWithDiscount();
                    pricingController.calculateSavedAmount();
                  },
                ),
              ),
              Obx(
                () => PricingItem(
                  title: 'Emerging Market Leaders',
                  subTitle: "Mid cap",
                  description:
                      "Generate wealth by riding momentum in Midcap stocks screened through MILARS strategy.",
                  leadingIcon: Icons
                      .window_outlined, // used alternate icon similar not available
                  itemList:
                      pricingController.emergingMarketLeaderPricingList.value,
                  onSelected: (val) {
                    pricingController.selectedEML = null;
                    if (val?.pAmount != null) {
                      pricingController.selectedEML = val;
                    }
                    pricingController.calculateTotalWithDiscount();
                    pricingController.calculateSavedAmount();
                  },
                ),
              ),
              Obx(
                () => PricingItem(
                  title: 'Large Cap Focus',
                  subTitle: "Large cap",
                  description:
                      "Achieve stable growth in your portfolio by investing in Bluechip stocks passed through MILARS strategy.",
                  leadingIcon: Icons.track_changes,
                  itemList: pricingController.largeCapFousPricingList.value,
                  onSelected: (val) {
                    pricingController.selectedLCF = null;
                    if (val?.pAmount != null) {
                      pricingController.selectedLCF = val;
                    }
                    pricingController.calculateTotalWithDiscount();
                    pricingController.calculateSavedAmount();
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: const ProceedToPayCTA(),
    );
  }
}
