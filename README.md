<p align="center">
[![Pub Package](https://img.shields.io/pub/v/easy_localization_multi.svg)](https://pub.dev/packages/easy_localization_multi)
[![GitHub](https://img.shields.io/github/license/alexeyinkin/flutter-easy-localization-multi)](https://github.com/alexeyinkin/flutter-easy-localization-multi/blob/main/LICENSE)
[![CodeFactor](https://img.shields.io/codefactor/grade/github/alexeyinkin/flutter-easy-localization-multi?style=flat-square)](https://www.codefactor.io/repository/github/alexeyinkin/flutter-easy-localization-multi)
[![Support Chat](https://img.shields.io/badge/support%20chat-telegram-brightgreen)](https://ainkin.com/chat)
</p>

A loader for
[easy_localization_loader](https://pub.dev/packages/easy_localization_loader) package
that merges strings from multiple other asset loaders.
Use this if you have localized packages and must merge their strings with ones from your app.

## Example

Follow the easy_localization docs except adding the loader.
This example uses
[easy_localization_yaml](https://pub.dev/packages/easy_localization_yaml)
package that supports loading package assets.

```dart
runApp(
  EasyLocalization(
    // NEW:
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
```

## Tech Support, Jobs, and Education

Please join my Telegram channel for announcements, Flutter jobs, articles, talks, and more:
[@ainkin_com](https://t.me/ainkin_com)

Do you have any questions? Feel free to ask in the [Telegram Support Chat](https://ainkin.com/chat).

Or even just join to say 'Hi!'. I like to hear from the users.
