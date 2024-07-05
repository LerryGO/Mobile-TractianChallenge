import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/src/models/company_model.dart';
import 'package:tractian_challenge/src/modules/home/cubit/home_cubit.dart';
import 'package:tractian_challenge/src/routes/app_routes.dart';

import '../../core/ui/base_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeCubit> {
  @override
  void onReady() {
    controller.fetchCompanies();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
        title: const Text(
          "TRACTIAN",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          switch (state) {
            case HomeLoading():
              showLoader();
              break;
            case HomeError():
              hideLoader();
              showError(state.message ?? 'Algum erro ocorreu');
              break;
            default:
              hideLoader();
          }
        },
        builder: (context, state) {
          if (state is HomeLoaded) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 40,
                ),
                itemCount: state.companies.length,
                itemBuilder: (context, index) {
                  return CompanyItem(
                    company: state.companies[index],
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('Nada a apresentar'),
            );
          }
        },
      ),
    );
  }
}

class CompanyItem extends StatelessWidget {
  final CompanyModel company;

  const CompanyItem({required this.company, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(AppRoutes.asset, arguments: company.id),
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF2188FF),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: Text(
                company.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
