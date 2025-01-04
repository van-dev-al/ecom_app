import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:flutter/material.dart';

class ESettingsMenuTitle extends StatelessWidget {
  const ESettingsMenuTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: EColors.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
