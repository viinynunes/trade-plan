part of '../application_binding.dart';

List<Provider> _operationProviders = [
  Provider<OperationDatasource>(
    create: (context) => HiveOperationDatasource(context.read()),
  ),
  Provider<OperationRepository>(
    create: (context) => OperationRepositoryImpl(context.read()),
  ),
  Provider<OperationListBloc>(
    create: (context) => OperationListBloc(context.read()),
  ),
];
