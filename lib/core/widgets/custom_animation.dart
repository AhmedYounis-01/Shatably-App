import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class FadeAnimationIcon extends StatefulWidget {
  const FadeAnimationIcon({super.key});

  @override
  State<FadeAnimationIcon> createState() => _FadeAnimationIconState();
}

class _FadeAnimationIconState extends State<FadeAnimationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true, count: 5); 
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Center(child: SvgPicture.asset(AppIcons.right)),
    );
  }
}
