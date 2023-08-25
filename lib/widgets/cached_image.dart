import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.borderRaduis = 10,
    this.fit = BoxFit.cover,
  });

  final String? imageUrl;
  final double borderRaduis;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRaduis),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: fit,
        errorWidget: (context, url, error) {
          return Container(
            color: Colors.red[100],
          );
        },
        placeholder: (context, url) {
          return Container(
            color: Colors.grey,
          );
        },
      ),
    );
  }
}
