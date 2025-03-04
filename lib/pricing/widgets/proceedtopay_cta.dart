import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_axis/pricing/controller/pricing_controller.dart';
import 'package:stock_axis/pricing/widgets/custom_button.dart';

class ProceedToPayCTA extends StatelessWidget {
  const ProceedToPayCTA({super.key});

  @override
  Widget build(BuildContext context) {
    final PricingController pricingController = Get.find();
    bool showFraction = (pricingController.totalPricing.value -
            pricingController.totalPricing.value.truncate()) >
        0;
    return Container(
        padding: EdgeInsets.only(
            left: 8, right: 8, bottom: MediaQuery.of(context).padding.bottom),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          visualDensity: const VisualDensity(
              vertical: VisualDensity.minimumDensity,
              horizontal: VisualDensity.minimumDensity),
          title: Obx(() => Text(
                "Rs.${pricingController.totalPricing.value.toStringAsFixed(showFraction ? 2 : 0)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )),
          subtitle: const Text(
            'Inclusive GST',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: CustomButton(
              onPressed: () {
                // PROCEED TO PAYMENT CTA
              },
              buttonTitle: 'Proceed For Payment'),
        ));
  }
}
