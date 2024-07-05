import '../../models/location_model.dart';

abstract interface class LocationRepository {
  Future<List<LocationModel>?> fetchLocations(String companyId);
}
