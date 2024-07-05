import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/src/repositories/asset/asset_repository.dart';
import 'package:tractian_challenge/src/repositories/location/location_repository.dart';

part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  final LocationRepository _locationRepository;
  final AssetRepository _assetRepository;

  AssetCubit(
      {required LocationRepository locationRepository,
      required AssetRepository assetRepository})
      : _assetRepository = assetRepository,
        _locationRepository = locationRepository,
        super(AssetInitial());

  Future<void> init(String companyId) async {
    await _fetchLocations(companyId);
    await _fetchAssets(companyId);
  }

  Future<void> _fetchLocations(String companyId) async {
    final result = await _locationRepository.fetchLocations(companyId);
  }

  Future<void> _fetchAssets(String companyId) async {
    final result = await _assetRepository.fetchAssets(companyId);
  }
}
