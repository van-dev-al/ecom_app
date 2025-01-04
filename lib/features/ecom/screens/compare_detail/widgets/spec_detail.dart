import 'package:flutter/material.dart';

class SpecDetail extends StatelessWidget {
  const SpecDetail({
    super.key,
    this.label,
    this.value,
  });

  final String? label; // Dành cho cột 1 (Product Info)
  final String? value; // Dành cho cột 2 và 3 (Product Details)

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (label != null)
              Expanded(
                flex: 1,
                child: Text(
                  label!,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            if (value != null)
              Expanded(
                flex: 2,
                child: Text(
                  value!,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        const Divider(thickness: 1, color: Colors.grey),
      ],
    );
  }
}
