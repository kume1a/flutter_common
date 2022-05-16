import 'package:flutter/material.dart';

import 'blank_container.dart';

class SafeImage extends StatelessWidget {
  const SafeImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.placeholderColor,
    this.fit = BoxFit.cover,
  })  : placeholderAssetPath = null,
        assetWidth = null,
        assetHeight = null,
        super(key: key);

  const SafeImage.withAssetPlaceholder({
    Key? key,
    required this.url,
    required this.placeholderAssetPath,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
    this.assetWidth,
    this.assetHeight,
    this.fit = BoxFit.cover,
  })  : placeholderColor = null,
        super(key: key);

  final String? url;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final Color? placeholderColor;
  final String? placeholderAssetPath;
  final double? assetWidth;
  final double? assetHeight;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.trim().isEmpty) {
      if (placeholderAssetPath != null) {
        return _image(
          AssetImage(placeholderAssetPath!),
          width: assetWidth,
          height: assetHeight,
        );
      }
      return BlankContainer(
        width: width,
        height: height,
        borderRadius: borderRadius,
        color: placeholderColor,
      );
    }
    return _image(NetworkImage(url!));
  }

  Widget _image(
    ImageProvider imageProvider, {
    double? width,
    double? height,
  }) {
    final Widget imageContent = ClipRRect(
      borderRadius: borderRadius,
      child: Image(
        image: imageProvider,
        width: width ?? this.width,
        height: height ?? this.height,
        fit: fit,
        errorBuilder: (_, __, ___) {
          if (placeholderAssetPath != null) {
            return ClipRRect(
              borderRadius: borderRadius,
              child: Image.asset(
                placeholderAssetPath!,
                width: assetWidth,
                height: assetHeight,
                fit: fit,
              ),
            );
          }
          return BlankContainer(
            width: this.width,
            height: this.height,
            borderRadius: borderRadius,
            color: placeholderColor,
          );
        },
      ),
    );

    if ((width != null && width != this.width) || (height != null && height != this.height)) {
      return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: imageContent,
      );
    }
    return imageContent;
  }
}
