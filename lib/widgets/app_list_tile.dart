import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  const AppListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  final String title;
  final String subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style:
            TextStyle(fontSize: 14, color: onTap != null ? null : Colors.grey),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontSize: 12,
            color: onTap != null ? Colors.grey : Colors.grey.shade700),
      ),
      onTap: onTap,
    );
  }
}
