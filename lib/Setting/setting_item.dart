import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String? value;
  final VoidCallback onTap;

  const SettingItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 20),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 18))),
            if (value != null) Text(value!, style: const TextStyle(color: Colors.grey)),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
