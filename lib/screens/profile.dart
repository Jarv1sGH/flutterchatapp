import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
                      'assets/images/defaultUser.png',
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
                          // color: Colors.black,
                        ),
                      )),
                ],
              ),
            ),
          ),
          const Row(
            children: [],
          )
        ],
      ),
    );
  }
}
