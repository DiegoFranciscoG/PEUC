import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/bank_loader.dart';
import '../../domain/models.dart';

/// Renders text paragraphs and pictures of the official bank in order.
/// Pictures sit on a white card so black strokes stay visible in dark mode.
class ContentBlocksView extends StatelessWidget {
  const ContentBlocksView(this.blocks, {super.key, this.style, this.maxImageHeight = 280});

  final List<ContentBlock> blocks;
  final TextStyle? style;
  final double maxImageHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (i, block) in blocks.indexed)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 8),
            child: block.isImage
                ? BankImage(block.image!, width: block.width, height: block.height, maxHeight: maxImageHeight)
                : Text(block.text!, style: style ?? Theme.of(context).textTheme.bodyLarge),
          ),
      ],
    );
  }
}

class BankImage extends StatelessWidget {
  const BankImage(this.name, {super.key, this.width, this.height, this.maxHeight = 280});

  final String name;

  /// Size in PDF points, used to show every picture at the same relative size
  /// it has in the official PDF (the bank mixes low and high resolution images).
  final double? width;
  final double? height;
  final double maxHeight;

  /// Logical pixels per PDF point.
  static const double _pointScale = 1.25;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final available = constraints.maxWidth.isFinite ? constraints.maxWidth - 12 : double.infinity;
      final w = width, h = height;
      Widget image;
      if (w != null && h != null && w > 0 && h > 0) {
        var targetWidth = min(w * _pointScale, available);
        if (targetWidth * h / w > maxHeight) targetWidth = maxHeight * w / h;
        image = _asset(width: targetWidth, height: targetWidth * h / w);
      } else {
        image = ConstrainedBox(constraints: BoxConstraints(maxHeight: maxHeight), child: _asset());
      }
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: image,
      );
    });
  }

  Widget _asset({double? width, double? height}) => Image.asset(
        '$bankImagesPath/$name',
        width: width,
        height: height,
        fit: width == null ? BoxFit.scaleDown : BoxFit.contain,
        filterQuality: FilterQuality.medium,
        semanticLabel: 'Imagen del banco oficial',
        errorBuilder: (context, error, stack) => const Padding(
          padding: EdgeInsets.all(8),
          child: Text('Imagen no disponible', style: TextStyle(color: Colors.black54)),
        ),
      );
}
