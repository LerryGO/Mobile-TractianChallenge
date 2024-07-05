import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tractian_challenge/src/core/restClient/rest_client.dart';
import 'package:tractian_challenge/src/models/company_model.dart';

import './company_repository.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final RestClient restClient;
  CompanyRepositoryImpl({required this.restClient});

  @override
  Future<List<CompanyModel>?> fetchCompanies() async {
    try {
      final result = await restClient.get('/companies');
      final companyList = result.data
          .map<CompanyModel>((e) => CompanyModel.fromMap(e))
          .toList();
      return companyList;
    } on DioException catch (e, s) {
      log('Erro ao buscar companias', error: e, stackTrace: s);
      return null;
    }
  }
}
