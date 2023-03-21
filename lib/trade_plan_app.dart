import 'package:flutter/material.dart';
import 'package:trade_plan/core/bindings/application_binding.dart';
import 'package:trade_plan/core/ui/themes/themes.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:trade_plan/models/paper_model.dart';
import 'package:trade_plan/pages/home/home_page.dart';
import 'package:trade_plan/pages/operation/operation_list_page.dart';
import 'package:trade_plan/pages/operation/operation_registration_page.dart';
import 'package:trade_plan/pages/order/order_list_page.dart';
import 'package:trade_plan/pages/order/order_registration_page.dart';
import 'package:trade_plan/pages/paper/paper_list_page.dart';
import 'package:trade_plan/pages/paper/paper_registration_page.dart';

class TradePlanApp extends StatelessWidget {
  const TradePlanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        routes: {
          '/': (context) => const HomePage(),
          '/order-list': (context) => const OrderListPage(),
          '/order-registration': (context) => const OrderRegistrationPage(),
          '/paper-list': (context) => const PaperListPage(),
          '/operation-list': (context) => const OperationListPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/paper-registration') {
            final paper = settings.arguments as PaperModel?;

            return MaterialPageRoute(
                builder: (_) => PaperRegistrationPage(paper: paper));
          }

          if (settings.name == '/operation-registration') {
            final operation = settings.arguments as OperationModel?;

            return MaterialPageRoute(
              builder: (_) => OperationRegistrationPage(
                operation: operation,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
