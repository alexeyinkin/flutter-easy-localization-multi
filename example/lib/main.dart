import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_multi/easy_localization_multi.dart';
import 'package:easy_localization_yaml/easy_localization_yaml.dart';
import 'package:flutter/material.dart';
import 'package:my_package/my_package.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      assetLoader: const MultiAssetLoader(
        [
          YamlAssetLoader(directory: 'assets/translations'),
          YamlAssetLoader(
            directory: 'assets/translations',
            package: 'my_package',
          ),
        ],
      ),
      fallbackLocale: const Locale('en'),
      path: 'unused',
      startLocale: const Locale('en'),
      supportedLocales: const [Locale('en')],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'easy_localization_yaml',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),

      // NEW
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('hello'.tr()),
      ),
      body: Center(
        child: MyPackageWidget(),
      ),
    );
  }
}
