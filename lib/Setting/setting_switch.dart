import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final bool value;
  final ValueChanged<bool> onTap;

  const SettingSwitch({
    Key? key,
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(!value);
      },
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
            Switch(
              value: value,
              onChanged: (newValue) {
                onTap(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
