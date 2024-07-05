import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/restClient/rest_client.dart';

import '../../models/asset_model.dart';
import 'asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final RestClient restClient;
  AssetRepositoryImpl({required this.restClient});

  @override
  Future<List<AssetModel>?> fetchAssets(String companyId) async {
    try {
      final result = await restClient.get('/companies/$companyId/assets');
      final assetList = result.data
          .map<AssetModel>((e) => AssetModel.fromMap(e))
          .toList();
      return assetList;
    } on DioException catch (e, s) {
      log('Erro ao buscar assets', error: e, stackTrace: s);
      return null;
    }
  }
}
