import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stock_axis/pricing/screens/pricing_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Stock_Axis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const PricingHomeScreen(),
    );
  }
}
