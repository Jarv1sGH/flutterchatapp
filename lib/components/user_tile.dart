import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  const UserTile({super.key, required this.username, this.userEmail});
  final String username;
  final String? userEmail;
  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9999)),
              ),
              child: Image.asset(
                'assets/images/defaultUser.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              if (widget.userEmail != null)
                Text(
                  widget.userEmail!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                )
            ],
          )
        ],
      ),
    );
  }
}
