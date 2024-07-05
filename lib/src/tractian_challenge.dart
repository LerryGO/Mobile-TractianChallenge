import 'package:flutter/material.dart';
import 'package:tractian_challenge/src/core/provider/application_binding.dart';
import 'package:tractian_challenge/src/routes/app_routes.dart';

class TractianChallenge extends StatelessWidget {
  const TractianChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return  ApplicationBinding(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tractian Challenge',
        initialRoute: AppRoutes.home,
        routes: AppRoutes.routes,
      ),
    );
  }
}
