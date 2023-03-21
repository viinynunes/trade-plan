import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/core/ui/widgets/custom_drawer.dart';
import 'package:trade_plan/core/ui/widgets/crud_bottom_menu.dart';
import 'package:trade_plan/models/paper_model.dart';
import 'package:trade_plan/pages/paper/controller/paper_list_bloc.dart';
import 'package:trade_plan/pages/paper/controller/states/paper_list_state.dart';
import 'package:trade_plan/pages/paper/widgets/tiles/paper_list_tile.dart';

import '../../core/ui/states/base_state.dart';

class PaperListPage extends StatefulWidget {
  const PaperListPage({Key? key}) : super(key: key);

  @override
  State<PaperListPage> createState() => _PaperListPageState();
}

class _PaperListPageState extends BaseState<PaperListPage, PaperListBloc> {
  @override
  void onReady() {
    super.onReady();

    bloc.getPaperList();
  }

  _callPaperRegistrationPage({PaperModel? paper}) async {
    var result = await Navigator.of(context)
        .pushNamed('/paper-registration', arguments: paper);

    if (result is PaperModel) {
      if (paper != null) {
        bloc.updatePaper(paper: result);
      } else {
        bloc.registerPaper(paper: result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Ativos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _callPaperRegistrationPage();
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<PaperListBloc, PaperListState>(
        listener: (context, state) {
          if (state.baseStatus == BaseBlocStatus.loading) {
            showLoader();
          }

          if (state.baseStatus == BaseBlocStatus.success) {
            hideLoader();
          }

          if (state.baseStatus == BaseBlocStatus.error) {
            hideLoader();
          }
        },
        child: BlocSelector<PaperListBloc, PaperListState, List<PaperModel>>(
          selector: (state) => state.paperList,
          builder: (context, paperList) {
            return paperList.isNotEmpty
                ? ListView.builder(
                    itemCount: paperList.length,
                    itemBuilder: (_, index) {
                      final paper = paperList[index];

                      return PaperListTile(
                          onTap: () async {
                            await _callPaperRegistrationPage(paper: paper);
                          },
                          onLongPress: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (_) => CrudBottomMenu(
                                onDelete: () {
                                  bloc.disablePaper(paper: paper);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          paper: paper);
                    },
                  )
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Nenhum Ativo Encontrado'),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
