import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trade_plan/core/services/order_result_service_impl.dart';
import 'package:trade_plan/data/order/datasources/closed_order_datasource.dart';
import 'package:trade_plan/pages/operation/controller/operation_list_bloc.dart';
import 'package:trade_plan/pages/order/controller/close_order_bloc.dart';
import 'package:trade_plan/pages/order/controller/order_list_bloc.dart';
import 'package:trade_plan/pages/order/controller/order_registration_bloc.dart';
import 'package:trade_plan/pages/paper/controller/paper_list_bloc.dart';

import '../../data/operation/datasources/operation_datasource.dart';
import '../../data/operation/local/hive_operation_datasource.dart';
import '../../data/operation/repositories/operation_repository.dart';
import '../../data/operation/repositories/operation_repository_impl.dart';
import '../../data/order/datasources/order_datasource.dart';
import '../../data/order/local/hive_closed_order_datasource.dart';
import '../../data/order/local/hive_order_datasource.dart';
import '../../data/order/repositories/order_repository.dart';
import '../../data/order/repositories/order_repository_impl.dart';
import '../../data/paper/datasources/paper_datasource.dart';
import '../../data/paper/local/paper_hive_datasource.dart';
import '../../data/paper/repositories/paper_repository.dart';
import '../../data/paper/repositories/paper_repository_impl.dart';
import '../services/order_result_service.dart';

part 'providers/operation_providers.dart';
part 'providers/paper_providers.dart';
part 'providers/order_providers.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final providers = [
      Provider<HiveInterface>(
        create: (context) => Hive,
      ),
      Provider<OrderResultService>(
        create: (context) => OrderResultServiceImpl(),
      ),
      ..._operationProviders,
      ..._paperProviders,
      ..._orderProviders,
    ];

    return MultiProvider(
      providers: providers,
      child: child,
    );
  }
}
