import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppBar(
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Item 1')),
              const PopupMenuItem(child: Text('Item 2')),
              const PopupMenuItem(child: Text('Item 3')),
            ],
            child: const PopupIconMenu(),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(BorderSide(color: orangeColor)),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          width: sizeOf.width * 0.8,
          margin: const EdgeInsets.only(top: 112),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Bem-vindo', style: titleStyle),
              const SizedBox(height: 32),
              SizedBox(
                width: sizeOf.width * 0.8,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(
                    context,
                  ).pushReplacementNamed<void, void>('/self-service'),
                  child: const Text('Iniciar terminal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
