import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedAmountWidget extends StatelessWidget {
  final num amount;
  const SavedAmountWidget({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    bool showFraction = (amount - amount.truncate()) > 0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: Get.width,
      color: const Color(0xff008800),
      child: Center(
        child: Text(
          "You will save Rs. ${amount.toStringAsFixed(showFraction ? 2 : 0)} on this plan",
          style:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
