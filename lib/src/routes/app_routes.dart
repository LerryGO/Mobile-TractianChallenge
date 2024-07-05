import 'package:flutter/material.dart';

import '../modules/asset/asset_route.dart';
import '../modules/home/home_route.dart';

abstract class AppRoutes {
  static const String home = '/';
  static const String asset = '/asset';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomeRoute.page,
    asset: (context) => AssetRoute.page,
  };
}
