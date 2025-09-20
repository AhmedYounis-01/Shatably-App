import 'package:flutter/material.dart';

class ProfileModel {
  final String name;
  final String email;
  final String profileImage;
  final String backgroundImage;

  const ProfileModel({
    required this.name,
    required this.email,
    required this.profileImage,
    required this.backgroundImage,
  });
}

class ProfileMenuItem {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });
}
