import 'package:flutter/material.dart';
import 'package:trade_plan/core/configuration/hive_configuration.dart';
import 'package:trade_plan/trade_plan_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveConfiguration.config();

  runApp(const TradePlanApp());
}
