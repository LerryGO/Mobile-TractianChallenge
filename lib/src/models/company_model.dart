import 'dart:convert';

class CompanyModel {
  String id;
  String name;

  CompanyModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CompanyModel(id: $id, name: $name)';
}
