import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/src/models/asset_model.dart';
import 'package:tractian_challenge/src/models/location_model.dart';
import 'package:tractian_challenge/src/modules/asset/cubit/asset_cubit.dart';

import '../../core/ui/base_state.dart';

class AssetPage extends StatefulWidget {
  final String companyId;
  const AssetPage({required this.companyId, super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends BaseState<AssetPage, AssetCubit> {
  @override
  void onReady() {
    controller.init(widget.companyId);
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Assets",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocConsumer<AssetCubit, AssetState>(
        listener: (context, state) {
          switch (state) {
            case AssetLoading():
              showLoader();
              break;
            case AssetError():
              hideLoader();
              showError(state.message ?? 'Algum erro ocorreu');
              break;
            default:
              hideLoader();
          }
        },
        builder: (context, state) {
          switch (state) {
            case AssetLoading():
              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                  ),
                ),
              );
            case AssetLoaded():
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemCount: state.dataList.length,
                itemBuilder: (context, index) {
                  final item = state.dataList[index];
                  if (item is AssetModel) {
                    return Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          SizedBox(
                              height: 22,
                              width: 22,
                              child: Image.asset('assets/component.png')),
                          Expanded(
                            child: Text(
                              item.name,
                              style: const TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return ExpansionTile(
                      leading: const Icon(Icons.keyboard_arrow_down),
                      trailing: const SizedBox.shrink(),
                      title: Row(
                        children: [
                          SizedBox(
                            height: 22,
                            width: 22,
                            child: Image.asset(
                              'assets/location.png',
                            ),
                          ),
                          Text(
                            (item as LocationModel).name,
                            style: const TextStyle(
                                fontSize: 14, overflow: TextOverflow.clip),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            default:
              return const Center(
                child: Text('Nada para mostrar'),
              );
          }
        },
      ),
    );
  }
}
