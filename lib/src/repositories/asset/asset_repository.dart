import '../../models/asset_model.dart';

abstract interface class AssetRepository {
  Future<List<AssetModel>?> fetchAssets(String companyId);
}
