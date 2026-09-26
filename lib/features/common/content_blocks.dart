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
                ? BankImage(block.image!, maxHeight: maxImageHeight)
                : Text(block.text!, style: style ?? Theme.of(context).textTheme.bodyLarge),
          ),
      ],
    );
  }
}

class BankImage extends StatelessWidget {
  const BankImage(this.name, {super.key, this.maxHeight = 280});

  final String name;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Image.asset(
        '$bankImagesPath/$name',
        // Pictures come from a 72 dpi PDF: show them ~1.6x larger, shrinking
        // only when they do not fit the available width.
        scale: 0.6,
        fit: BoxFit.scaleDown,
        filterQuality: FilterQuality.medium,
        semanticLabel: 'Imagen del banco oficial',
        errorBuilder: (context, error, stack) => const Padding(
          padding: EdgeInsets.all(8),
          child: Text('Imagen no disponible', style: TextStyle(color: Colors.black54)),
        ),
      ),
    );
  }
}
