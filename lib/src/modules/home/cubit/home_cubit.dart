import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/src/repositories/company/company_repository.dart';

import '../../../models/company_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CompanyRepository companyRepository;
  HomeCubit({required this.companyRepository}) : super(HomeInitial());

  Future<void> fetchCompanies() async {
    emit(HomeLoading());
    final result = await companyRepository.fetchCompanies();
    if (result != null) {
      emit(HomeLoaded(companies: result));
    } else {
      emit(const HomeError());
    }
  }
}
