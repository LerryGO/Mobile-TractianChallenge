import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/src/repositories/asset/asset_repository.dart';
import 'package:tractian_challenge/src/repositories/location/location_repository.dart';

import '../../../models/asset_model.dart';
import '../../../models/location_model.dart';

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
    try {
      emit(AssetLoading());
      final locations = await _fetchLocations(companyId);
      final assets = await _fetchAssets(companyId);
      _fillData(locations, assets);
    } on Exception catch (e, s) {
      log('ERRO ao iniciar asset', error: e, stackTrace: s);
      emit(AssetError(message: 'Algum erro ocorreu'));
    }
  }

  Future<List<LocationModel>> _fetchLocations(String companyId) async {
    final result = await _locationRepository.fetchLocations(companyId);
    return result ?? [];
  }

  Future<List<AssetModel>> _fetchAssets(String companyId) async {
    final result = await _assetRepository.fetchAssets(companyId);
    return result ?? [];
  }

  void _fillData(List<LocationModel> locations, List<AssetModel> assets) async {
    final locationList = [...locations];
    final assetsList = [...assets];
    final assetToRemove = [];
    final finalList = <dynamic>[];

    for (AssetModel asset in assets) {
      if (asset.parentId != null) {
        final index = assetsList.indexWhere(
          (element) => element.id == asset.parentId,
        );
        if (index != -1) {
          assetsList[index].assetList.add(asset);
          assetToRemove.add(asset);
        }
      }
    }

    for (AssetModel asset in assetsList) {
      if (asset.locationId != null) {
        final index = locationList.indexWhere(
          (element) => element.id == asset.locationId,
        );
        if (index != -1) {
          locationList[index].assetLists.add(asset);
          assetToRemove.add(asset);
        }
      }
    }

    for (var asset in assetToRemove) {
      assetsList.remove(asset);
    }

    finalList.addAll([...assetsList, ...locationList]);

    emit(AssetLoaded(dataList: finalList));
  }
}
