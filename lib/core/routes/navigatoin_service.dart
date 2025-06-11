import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();
  static final NavigationService instance = NavigationService._();

  // Global navigator key for root navigation
  final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();

  // Navigator key for tab navigation (inside bottom nav bar)
  final GlobalKey<NavigatorState> tabNavKey = GlobalKey<NavigatorState>();

  // Get current context
  BuildContext? get currentContext =>
      rootNavKey.currentContext ?? tabNavKey.currentContext;

  // Check if we're currently in a tab navigation context
  bool get isInTabNavigation => tabNavKey.currentState != null;
}
