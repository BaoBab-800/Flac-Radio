import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'providers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: appProviders,
      child: const FlacRadioApp(),
    ),
  );
}