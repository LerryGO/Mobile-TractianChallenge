import '../../models/company_model.dart';

abstract interface class CompanyRepository {
  Future<List<CompanyModel>?> fetchCompanies();
}
