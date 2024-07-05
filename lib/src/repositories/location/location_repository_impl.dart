import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/restClient/rest_client.dart';
import '../../models/location_model.dart';
import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final RestClient restClient;
  LocationRepositoryImpl({required this.restClient});

  @override
  Future<List<LocationModel>?> fetchLocations(String companyId) async {
    try {
      final result = await restClient.get('/companies/$companyId/locations');
      final locationList = result.data
          .map<LocationModel>((e) => LocationModel.fromMap(e))
          .toList();
      return locationList;
    } on DioException catch (e, s) {
      log('Erro ao buscar locations', error: e, stackTrace: s);
      return null;
    }
  }
}
