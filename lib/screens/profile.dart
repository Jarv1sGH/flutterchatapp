import 'package:flutter/material.dart';
import 'package:flutterchatapp/components/profile_info_row.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.aboutMe,
    required this.username,
    required this.imgUrl,
    required this.phone,
    required this.email,
  });
  final String username;
  final String aboutMe;
  final String phone;
  final String imgUrl;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(9999),
                      ),
                    ),
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(9999),
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                        ),
                      )),
                ],
              ),
            ),
          ),
          ProfileInfoRow(
            label: 'Name',
            value: username,
            icon: Icons.person_2_outlined,
          ),
          ProfileInfoRow(
            label: 'Email',
            value: email,
            icon: Icons.mail_outline,
          ),
          ProfileInfoRow(
            label: 'Phone',
            value: phone,
            icon: Icons.phone_enabled_outlined,
          ),
          ProfileInfoRow(
            label: 'About',
            value: aboutMe,
            icon: Icons.info_outline,
          ),
        ],
      ),
    );
  }
}
