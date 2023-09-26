import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';

/// Combines the results of multiple loaders.
class MultiAssetLoader extends AssetLoader {
  /// The loaders. Results from latter loaders get merged or overwrite
  /// the results from the earlier ones.
  // https://github.com/aissat/easy_localization/issues/524
  final List<dynamic> loaders;

  ///
  const MultiAssetLoader(this.loaders);

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final futures = <Future<Map<String, dynamic>?>>[];
    final result = <String, dynamic>{};

    for (final loader in loaders) {
      // ignore: avoid_dynamic_calls
      futures.add(loader.load(path, locale));
    }

    final maps = await Future.wait(futures);

    maps.whereNotNull().forEach(result.addAllRecursive);
    return result;
  }
}

///
extension _MapExtension<K> on Map<K, dynamic> {
  /// Merges entries from [other].
  /// Unlike [addAll], tries to recursively merge an entry
  /// if it is a compatible map.
  void addAllRecursive(Map<K, dynamic> other) {
    for (final entry in other.entries) {
      final oldValue = this[entry.key];
      final newValue = entry.value;

      if (oldValue is Map<K, dynamic> && newValue is Map<K, dynamic>) {
        oldValue.addAllRecursive(newValue);

        continue;
      }

      this[entry.key] = newValue;
    }
  }
}
