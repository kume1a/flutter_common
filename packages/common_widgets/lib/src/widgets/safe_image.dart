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
        super(key: key);

  const SafeImage.withAssetPlaceholder({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = 4,
    this.placeholderAssetPath,
  })  : placeholderColor = null,
        super(key: key);

  final String? url;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? placeholderColor;
  final String? placeholderAssetPath;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.trim().isEmpty) {
      if (placeholderAssetPath != null) {
        return _image(AssetImage(placeholderAssetPath!));
      }
      return _blankContainer();
    }
    return _image(NetworkImage(url!));
  }

  Widget _image(ImageProvider imageProvider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image(
        image: imageProvider,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _blankContainer(),
      ),
    );
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
