import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractian_challenge/src/repositories/asset/asset_repository.dart';
import 'package:tractian_challenge/src/repositories/asset/asset_repository_impl.dart';
import 'package:tractian_challenge/src/repositories/location/location_repository.dart';
import 'package:tractian_challenge/src/repositories/location/location_repository_impl.dart';

import 'asset_page.dart';
import 'cubit/asset_cubit.dart';

class AssetRoute {
  AssetRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<LocationRepository>(
            create: (context) =>
                LocationRepositoryImpl(restClient: context.read()),
          ),
          Provider<AssetRepository>(
            create: (context) =>
                AssetRepositoryImpl(restClient: context.read()),
          ),
          Provider<AssetCubit>(
            create: (context) => AssetCubit(
              locationRepository: context.read(),
              assetRepository: context.read(),
            ),
          ),
        ],
        builder: (context, child) {
          final companyId =
              ModalRoute.of(context)!.settings.arguments as String;

          return AssetPage(companyId: companyId);
        },
      );
}
