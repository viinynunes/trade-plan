part of '../application_binding.dart';

List<Provider> _orderProviders = [
  Provider<OrderDatasource>(
    create: (context) => HiveOrderDatasource(context.read()),
  ),
  Provider<ClosedOrderDatasource>(
    create: (context) => HiveClosedOrderDatasource(context.read()),
  ),
  Provider<OrderRepository>(
    create: (context) => OrderRepositoryImpl(context.read(), context.read()),
  ),
  Provider<OrderListBloc>(create: (context) => OrderListBloc(context.read())),
  Provider<OrderRegistrationBloc>(
    create: (context) => OrderRegistrationBloc(
      context.read(),
      context.read(),
    ),
  )
];
