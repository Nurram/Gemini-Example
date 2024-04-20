import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final Function() onReload;

  const CustomErrorWidget({
    super.key,
    required this.error,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(error),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onReload,
              child: const Text('Refresh'),
            )
          ],
        ),
      ),
    );
  }
}
