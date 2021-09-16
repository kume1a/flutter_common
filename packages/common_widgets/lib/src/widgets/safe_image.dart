import 'package:flutter/material.dart';

import 'blank_container.dart';

class SafeImage extends StatelessWidget {
  const SafeImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = 4,
    this.placeholderColor,
  })  : placeholderAssetPath = null,
        assetWidth = null,
        assetHeight = null,
        super(key: key);

  const SafeImage.withAssetPlaceholder({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = 4,
    this.placeholderAssetPath,
    this.assetWidth,
    this.assetHeight,
  })  : placeholderColor = null,
        super(key: key);

  final String? url;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? placeholderColor;
  final String? placeholderAssetPath;
  final double? assetWidth;
  final double? assetHeight;

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
      return _blankContainer();
    }
    return _image(NetworkImage(url!));
  }

  Widget _image(
    ImageProvider imageProvider, {
    double? width,
    double? height,
  }) {
    final Widget imageContent = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image(
        image: imageProvider,
        width: width ?? this.width,
        height: height ?? this.height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _blankContainer(),
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

  Widget _blankContainer() {
    return BlankContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      color: placeholderColor,
    );
  }
}
