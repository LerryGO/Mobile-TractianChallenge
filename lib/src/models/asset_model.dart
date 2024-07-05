import 'dart:convert';

class AssetModel {
  String id;
  String name;
  String? locationId;
  String? parentId;
  String? sensorType;
  String? status;
  List<AssetModel> assetList;

  AssetModel({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
    required this.assetList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'locationId': locationId,
      'name': name,
      'parentId': parentId,
      'sensorType': sensorType,
      'status': status,
      'assetList': assetList.map((x) => x.toMap()).toList(),
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'] as String,
      name: map['name'] as String,
      locationId: map['locationId'] as String?,
      parentId: map['parentId'] as String?,
      sensorType: map['sensorType'] as String?,
      status: map['status'] as String?,
      assetList: map['assetList'] != null
          ? List<AssetModel>.from(
              (map['assetList'] as List<int>).map<AssetModel>(
                (x) => AssetModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetModel.fromJson(String source) =>
      AssetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssetModel(id: $id, locationId: $locationId, name: $name, parentId: $parentId, sensorType: $sensorType, status: $status, assetList: $assetList)';
  }
}
