/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsGifGen {
  const $AssetsGifGen();

  /// File path: assets/gif/loading_animation.gif
  AssetGenImage get loadingAnimation =>
      const AssetGenImage('assets/gif/loading_animation.gif');

  /// List of all assets
  List<AssetGenImage> get values => [loadingAnimation];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/images/google_logo.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_bw.png
  AssetGenImage get logoBw => const AssetGenImage('assets/images/logo_bw.png');

  /// File path: assets/images/splash_icon.png
  AssetGenImage get splashIcon =>
      const AssetGenImage('assets/images/splash_icon.png');

  /// File path: assets/images/splash_icon_a_12.png
  AssetGenImage get splashIconA12 =>
      const AssetGenImage('assets/images/splash_icon_a_12.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [googleLogo, logo, logoBw, splashIcon, splashIconA12];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/Capsule.svg
  SvgGenImage get capsule => const SvgGenImage('assets/svg/Capsule.svg');

  /// File path: assets/svg/Inhaler.svg
  SvgGenImage get inhaler => const SvgGenImage('assets/svg/Inhaler.svg');

  /// File path: assets/svg/Injection.svg
  SvgGenImage get injection => const SvgGenImage('assets/svg/Injection.svg');

  /// File path: assets/svg/Powder.svg
  SvgGenImage get powder => const SvgGenImage('assets/svg/Powder.svg');

  /// File path: assets/svg/Syrup.svg
  SvgGenImage get syrup => const SvgGenImage('assets/svg/Syrup.svg');

  /// File path: assets/svg/Tablet.svg
  SvgGenImage get tablet => const SvgGenImage('assets/svg/Tablet.svg');

  /// File path: assets/svg/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/svg/logo.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [capsule, inhaler, injection, powder, syrup, tablet, logo];
}

class Assets {
  Assets._();

  static const $AssetsGifGen gif = $AssetsGifGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
