import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';

/// Combines the results of multiple loaders.
class MultiAssetLoader extends AssetLoader {
  /// The loaders. Results from latter loaders get merged or overwrite
  /// the results from the earlier ones.
  final List<AssetLoader> loaders;

  /// Combines the results of multiple loaders.
  const MultiAssetLoader(this.loaders);

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final futures = <Future<Map<String, dynamic>?>>[];
    final result = <String, dynamic>{};

    for (final loader in loaders) {
      futures.add(loader.load(path, locale));
    }

    final maps = await Future.wait(futures);

    maps.whereNotNull().forEach(result.addAllRecursive);
    return result;
  }
}
