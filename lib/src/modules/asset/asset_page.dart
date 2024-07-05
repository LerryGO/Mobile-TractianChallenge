import 'package:flutter/material.dart';
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
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
