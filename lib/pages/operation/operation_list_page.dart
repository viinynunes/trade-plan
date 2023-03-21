import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_plan/core/ui/widgets/crud_bottom_menu.dart';
import 'package:trade_plan/core/ui/widgets/custom_drawer.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:trade_plan/pages/operation/widgets/tiles/operation_list_tile.dart';

import '../../core/ui/states/base_state.dart';
import 'controller/operation_list_bloc.dart';
import 'controller/state/operation_list_state.dart';

class OperationListPage extends StatefulWidget {
  const OperationListPage({Key? key}) : super(key: key);

  @override
  State<OperationListPage> createState() => _OperationListPageState();
}

class _OperationListPageState
    extends BaseState<OperationListPage, OperationListBloc> {
  @override
  void onReady() {
    super.onReady();

    bloc.getOperationList();
  }

  callOperationRegistrationPage({OperationModel? operation}) async {
    final result = await Navigator.of(context)
        .pushNamed('/operation-registration', arguments: operation);

    if (result is OperationModel) {
      if (operation != null) {
        bloc.updateOperation(operation: result);
      } else {
        bloc.registerOperation(operation: result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Operações'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await callOperationRegistrationPage();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<OperationListBloc, OperationListState>(
        listener: (context, state) {
          if (state.status == OperationListStatus.loading) {
            showLoader();
          }
          if (state.status == OperationListStatus.error) {
            hideLoader();
          }
          if (state.status == OperationListStatus.success) {
            hideLoader();
          }
        },
        child: BlocSelector<OperationListBloc, OperationListState,
            List<OperationModel>>(
          selector: (state) => state.operationList,
          builder: (context, operationList) {
            return operationList.isNotEmpty
                ? ListView.builder(
                    itemCount: operationList.length,
                    itemBuilder: (_, index) {
                      final operation = operationList[index];

                      return OperationListTile(
                          operation: operation,
                          onTap: () => callOperationRegistrationPage(
                              operation: operation),
                          onLongPress: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (_) => CrudBottomMenu(
                                onDelete: () {
                                  bloc.disableOperation(operation: operation);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          });
                    },
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Nenhuma operação encontrada'),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
