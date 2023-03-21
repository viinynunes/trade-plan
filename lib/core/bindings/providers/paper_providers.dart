part of '../application_binding.dart';

List<Provider> _paperProviders = [
  Provider<PaperDatasource>(
    create: (context) => PaperHiveDatasource(context.read()),
  ),
  Provider<PaperRepository>(
    create: (context) => PaperRepositoryImpl(context.read()),
  ),
  Provider<PaperListBloc>(
    create: (context) => PaperListBloc(context.read()),
  ),
];
