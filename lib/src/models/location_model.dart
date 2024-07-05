import 'dart:convert';

import 'asset_model.dart';

class LocationModel {
  String id;
  String name;
  String? parentId;
  List<LocationModel> childLocations;
  List<AssetModel> assetLists;

  LocationModel({
    required this.id,
    required this.name,
    this.parentId,
    required this.childLocations,
    required this.assetLists,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parentId': parentId,
      'childLocations': childLocations.map((x) => x.toMap()).toList(),
      'assetLists': assetLists.map((x) => x.toMap()).toList(),
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] as String?,
      childLocations: map['childLocations'] != null
          ? List<LocationModel>.from(
              (map['childLocations'] as List<int>).map<LocationModel>(
                (x) => LocationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      assetLists: map['assetLists'] != null
          ? List<AssetModel>.from(
              (map['assetLists'] as List<int>).map<AssetModel>(
                (x) => AssetModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(id: $id, name: $name, parentId: $parentId, childLocations: $childLocations, assetLists: $assetLists)';
  }
}
