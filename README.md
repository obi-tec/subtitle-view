<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Package thats fetch data from webVtt url and show it based on milliseconds.

## Features

This package allows you to customize the display of subtitle, like fontSize, fontFamily, color, backgroundColor and text border color.

## Getting started

To use the package, you will need to set a SubtitleController, that will receive the webVtt url.
After That, you will pass this parameter to the SubtitleView.
Other parameter that is necessary is currentTimeInMilliseconds, this parameter will show the correct subtitle based on time.

## Customization

You can change all the parameters of textStyle to customize size, fonts, colors and fontWeigth.
SubtitleView(
currentTimeInMilliseconds: 1222,
subtitleController: SubtitleController("webVttUrlHere"),
textColor : Colors.blue,
borderColor: Colors.red,
fontSize : 23,
fontWeight : FontWeight.w700,
backgroundSubtitleColor : const Color.fromRGBO(12, 12, 12, 0.6),
fontFamily : "Your font here"
);

## Additional information

Please open an [issue](https://issue.com) if you find any bugs
