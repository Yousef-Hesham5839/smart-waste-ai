import 'package:flutter/material.dart';

class CircularConfidenceWidget extends StatelessWidget {
  final double confidence;
  final Color color;
  final double size;

  const CircularConfidenceWidget({
    super.key,
    required this.confidence,
    required this.color,
    this.size = 90.0,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (confidence * 100).toInt();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: confidence.clamp(0.0, 1.0),
              strokeWidth: 8,
              backgroundColor: color.withValues(alpha: 0.18),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: size * 0.26,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                'دقة التصنيف',
                style: TextStyle(
                  fontSize: size * 0.12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
