import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_plan/core/extensions/date_format_extension.dart';
import 'package:trade_plan/core/ui/widgets/custom_drawer.dart';
import 'package:trade_plan/core/ui/widgets/crud_bottom_menu.dart';
import 'package:trade_plan/models/closed_order_model.dart';
import 'package:trade_plan/models/order_model.dart';
import 'package:trade_plan/pages/order/controller/order_list_bloc.dart';
import 'package:trade_plan/pages/order/widgets/dialogs/close_order_dialog.dart';
import 'package:trade_plan/pages/order/widgets/tiles/closed_order_tile.dart';
import 'package:trade_plan/pages/order/widgets/tiles/opened_order_tile.dart';

import '../../core/ui/bloc/base_bloc_state.dart';
import '../../core/ui/states/base_state.dart';
import 'controller/states/order_list_state.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends BaseState<OrderListPage, OrderListBloc> {
  @override
  void onReady() {
    super.onReady();

    bloc.getOpenedOrderList(date: DateTime.now());
    bloc.getClosedOrderList(date: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return BlocListener<OrderListBloc, OrderListState>(
      listener: (context, state) {
        if (state.baseStatus == BaseBlocStatus.loading) {
          showLoader();
        }

        if (state.baseStatus == BaseBlocStatus.success) {
          hideLoader();
        }
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        floatingActionButton:
            BlocSelector<OrderListBloc, OrderListState, DateTime?>(
          selector: (state) => state.selectedDate,
          builder: (context, selectedDate) {
            return FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.of(context)
                    .pushNamed('/order-registration');

                if (result is OrderModel) {
                  bloc.registerOrder(order: result);
                  bloc.getClosedOrderList(date: selectedDate!);
                  bloc.getOpenedOrderList(date: selectedDate);
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
        body: SizedBox(
          height: size.height,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: false,
                title: const Text('Ordens'),
                actions: [
                  BlocSelector<OrderListBloc, OrderListState, DateTime?>(
                    selector: (state) => state.selectedDate,
                    builder: (context, selectedDate) {
                      return GestureDetector(
                        onLongPress: () {
                          HapticFeedback.vibrate();

                          bloc.selectDate(selectedDate: DateTime.now());
                        },
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000))
                              .then((value) {
                            bloc.selectDate(selectedDate: value);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            selectedDate!.onlyDateFormat,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Visibility(
                  visible: true,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Operações Abertas',
                              style: textTheme.titleLarge,
                            ),
                            BlocSelector<OrderListBloc, OrderListState, int>(
                              selector: (state) => state.openedOrderList.length,
                              builder: (context, length) {
                                return Text(
                                  length.toString(),
                                  style: textTheme.titleLarge,
                                );
                              },
                            ),
                          ],
                        ),
                        BlocBuilder<OrderListBloc, OrderListState>(
                          bloc: bloc,
                          builder: (context, state) {
                            return state.openedOrderList.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.openedOrderList.length,
                                    itemBuilder: (_, index) {
                                      final order =
                                          state.openedOrderList[index];

                                      return OpenedOrderTile(
                                        onLongPress: () async {
                                          await showModalBottomSheet(
                                            context: context,
                                            builder: (_) => CrudBottomMenu(
                                              onDelete: () {
                                                bloc.disableOrder(
                                                    order: order,
                                                    date: state.selectedDate!);

                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        },
                                        order: order,
                                        onCloseOrder: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (_) => CloseOrderDialog(
                                              order: order,
                                              onFinish: (ClosedOrderModel
                                                  closedOrder) {
                                                bloc.closeOrder(
                                                    order: closedOrder,
                                                    date: state.selectedDate!);
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text('Nenhuma Ordem Encontrada'),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Visibility(
                  visible: true,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Operações Encerradas',
                              style: textTheme.titleLarge,
                            ),
                            BlocSelector<OrderListBloc, OrderListState, int>(
                              selector: (state) => state.closedOrderList.length,
                              builder: (context, length) {
                                return Text(
                                  length.toString(),
                                  style: textTheme.titleLarge,
                                );
                              },
                            ),
                          ],
                        ),
                        BlocBuilder<OrderListBloc, OrderListState>(
                          bloc: bloc,
                          builder: (context, state) {
                            return state.closedOrderList.isNotEmpty
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.closedOrderList.length,
                                    itemBuilder: (_, index) {
                                      final closedOrder =
                                          state.closedOrderList[index];

                                      return ClosedOrderTile(
                                        closedOrder: closedOrder,
                                        onLongPress: () async {
                                          await showModalBottomSheet(
                                            context: context,
                                            builder: (_) => CrudBottomMenu(
                                              onDelete: () {
                                                bloc.disableClosedOrder(
                                                    order: closedOrder,
                                                    date: state.selectedDate!);

                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text('Nenhuma Ordem Encontrada'),
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
