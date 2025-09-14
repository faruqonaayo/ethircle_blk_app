import 'package:flutter/material.dart';

class InformationCard extends StatefulWidget {
  const InformationCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final IconData icon;
  final num value;

  @override
  State<InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<InformationCard> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,

      child: GestureDetector(
        onTap: () {
          setState(() {
            _active = !_active;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          height: 96,
          width: 200,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: _active
                  ? [
                      Color.fromRGBO(57, 62, 70, .48),
                      Color.fromRGBO(255, 211, 105, .32),
                    ]
                  : [
                      colorScheme.surfaceContainerHigh,
                      colorScheme.surfaceContainerHighest,
                    ],
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _active ? widget.value.toString() : "****",
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(),
                  Icon(widget.icon, size: 32, color: colorScheme.onSurface),
                ],
              ),
              const Spacer(),
              Text(
                widget.label,
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
