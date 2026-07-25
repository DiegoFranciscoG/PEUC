import 'package:flutter/material.dart';
import 'dart:math' as math;

class FiguraGeometrica extends StatelessWidget {
  final String iconName;
  final int rotacion;
  final String relleno; // "solido", "contorno", "rayado"
  final double tamano;
  final Color color;

  const FiguraGeometrica({
    super.key,
    required this.iconName,
    required this.rotacion,
    this.relleno = 'solido',
    this.tamano = 40.0,
    this.color = Colors.black,
  });

  IconData _getIconData(String name) {
    // Basic mapping for abstract shapes. We can extend this.
    switch (name) {
      case 'circle': return Icons.circle;
      case 'square': return Icons.square;
      case 'triangle': return Icons.change_history; // outline triangle, we'll handle solid vs outline
      case 'star': return Icons.star;
      case 'diamond': return Icons.diamond;
      case 'pentagon': return Icons.pentagon;
      case 'hexagon': return Icons.hexagon;
      case 'arrow_up': return Icons.arrow_upward;
      case 'arrow_right': return Icons.arrow_forward;
      default: return Icons.help_outline;
    }
  }
  
  IconData _getOutlineIconData(String name) {
    switch (name) {
      case 'circle': return Icons.circle_outlined;
      case 'square': return Icons.crop_square;
      case 'triangle': return Icons.change_history;
      case 'star': return Icons.star_border;
      case 'diamond': return Icons.diamond_outlined;
      case 'pentagon': return Icons.pentagon_outlined;
      case 'hexagon': return Icons.hexagon_outlined;
      case 'arrow_up': return Icons.arrow_upward;
      case 'arrow_right': return Icons.arrow_forward;
      default: return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isOutline = relleno == 'contorno';
    final IconData icon = isOutline ? _getOutlineIconData(iconName) : _getIconData(iconName);
    
    Widget widget = Icon(
      icon,
      size: tamano,
      color: color,
    );

    // Apply "rayado" (striped) effect using a ShaderMask
    if (relleno == 'rayado') {
      widget = ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.transparent, Colors.black, Colors.transparent],
            stops: [0.0, 0.25, 0.5, 0.75],
            tileMode: TileMode.repeated,
          ).createShader(bounds); // We need a proper repeating stripe pattern
        },
        blendMode: BlendMode.srcATop,
        child: Icon(
          _getIconData(iconName), // Use solid icon for the mask
          size: tamano,
          color: Colors.white, // Base color to be masked
        ),
      );
      
      // We actually need a custom shader or a simpler approach for stripes. 
      // Let's refine the ShaderMask for stripes.
      widget = ShaderMask(
        shaderCallback: (bounds) {
          // Creating a repeating stripe pattern
          return LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color, Colors.transparent, Colors.transparent],
            stops: const [0.0, 0.5, 0.5, 1.0],
            tileMode: TileMode.repeated,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width * 0.1, bounds.height * 0.1)); 
          // The Rect defines the tile size, making it small creates multiple stripes
        },
        blendMode: BlendMode.srcIn,
        child: Icon(
          _getIconData(iconName), // Solid icon as mask
          size: tamano,
          color: color,
        ),
      );
      
      // To add the border around the stripes, we stack an outline icon on top
      widget = Stack(
        alignment: Alignment.center,
        children: [
          widget, // Striped solid shape
          Icon(_getOutlineIconData(iconName), size: tamano, color: color), // Outline
        ],
      );
    }

    if (rotacion != 0) {
      widget = Transform.rotate(
        angle: rotacion * math.pi / 180,
        child: widget,
      );
    }

    return widget;
  }
}
