import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractian_challenge/src/core/restClient/rest_client.dart';

class ApplicationBinding extends StatelessWidget {
  final Widget child;

  const ApplicationBinding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RestClient>(
            create: (context) => RestClient('https://fake-api.tractian.com')),
      ],
      child: child,
    );
  }
}
