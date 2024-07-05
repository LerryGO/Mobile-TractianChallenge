import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractian_challenge/src/modules/home/cubit/home_cubit.dart';
import 'package:tractian_challenge/src/modules/home/home_page.dart';
import 'package:tractian_challenge/src/repositories/company/company_repository_impl.dart';

import '../../repositories/company/company_repository.dart';

class HomeRoute {
  HomeRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<CompanyRepository>(
            create: (context) =>
                CompanyRepositoryImpl(restClient: context.read()),
          ),
          Provider<HomeCubit>(
            create: (context) => HomeCubit(companyRepository: context.read()),
          ),
        ],
        child: const HomePage(),
      );
}
