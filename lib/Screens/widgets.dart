import 'package:flutter/material.dart';

class myAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onMedalPressed;
  final VoidCallback? onSettingsPressed;

  const myAppBar({
    Key? key,
    required this.title,
    this.onMedalPressed,
    this.onSettingsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          image: const DecorationImage(
            image: AssetImage('assets/other/Appbar.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onMedalPressed,
                    icon: Image.asset(
                      'assets/Avatar/Gold Medal.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: onSettingsPressed,
                    icon: const Icon(Icons.settings),
                    iconSize: 35,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

