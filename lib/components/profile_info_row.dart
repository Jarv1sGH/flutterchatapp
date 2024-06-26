import 'package:flutter/material.dart';
import 'package:flutterchatapp/components/theme_extension.dart';

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow(
      {super.key,
      required this.label,
      required this.value,
      required this.icon});
  final String label;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            color: context.iconColor,
            size: 28,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: context.secondaryTextColor),
                ),
                Text(
                  maxLines: 2,
                  softWrap: true,
                  value,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            Icons.edit,
            color: context.primaryIconColor,
            size: 28,
          )
        ],
      ),
    );
  }
}
