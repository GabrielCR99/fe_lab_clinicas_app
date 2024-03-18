import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

final class DocumentBox extends StatelessWidget {
  final bool hasUploaded;
  final Widget icon;
  final String label;
  final int totalFiles;
  final VoidCallback? onTap;

  const DocumentBox({
    required this.hasUploaded,
    required this.icon,
    required this.label,
    required this.totalFiles,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final totalFileLabel = totalFiles > 0 ? '($totalFiles)' : '';

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: hasUploaded ? lightOrangeColor : Colors.white,
            border: const Border.fromBorderSide(BorderSide(color: orangeColor)),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            children: [
              Expanded(child: icon),
              Text(
                '$label $totalFileLabel',
                style: const TextStyle(
                  color: orangeColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
