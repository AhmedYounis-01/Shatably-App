import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();
  static final NavigationService instance = NavigationService._();
  final navKey = GlobalKey<NavigatorState>();

  bool _checkDuplicates({
    required String routePath,
    required Object? arguments,
  }) {
    bool isNewRouteSameRoute = false;

    popUntil(
      predicate: (route) {
        var isNewRouteSameRoute = route.settings.name == routePath;

        return isNewRouteSameRoute;
      },
    );

    return isNewRouteSameRoute;
  }

  Future<T?> popAndPushNamed<T>({
    required String path,
    Object? arguments,
    bool preventDuplicate = false,
  }) async {
    if (preventDuplicate) {
      if (_checkDuplicates(routePath: path, arguments: arguments)) {
        return Future.value();
      }
    }
    return navKey.currentState?.popAndPushNamed<T, T>(
      path,
      arguments: arguments,
    );
  }

  Future<T?> pushNamed<T>({
    required String path,
    Object? arguments,
    bool preventDuplicate = false,
  }) async {
    if (preventDuplicate) {
      if (_checkDuplicates(routePath: path, arguments: arguments)) {
        return Future.value();
      }
    }
    return navKey.currentState?.pushNamed<T>(
      path,
      arguments: arguments,
      
    );
  }

  Future<T?> pushReplacementNamed<T>({
    required String path,
    Object? arguments,
  }) async =>
      navKey.currentState?.pushReplacementNamed(
        path,
        arguments: arguments,
      );

  Future<T?> pushReplacement<T>({
    required Widget page,
    Object? arguments,
  }) async =>
      navKey.currentState?.pushReplacement(
        MaterialPageRoute(
            builder: (_) => page,
            settings: RouteSettings(arguments: arguments)),
      );

  Future<T?> pushAndRemoveUntil<T>({
    required String path,
    Object? arguments,
    bool Function(Route<dynamic> route)? predicate,
  }) =>
      navKey.currentState!.pushNamedAndRemoveUntil<T?>(
        path,
        predicate ?? (route) => false,
        arguments: arguments,
      );

  Future<void> pop<T>({
    T? result,
  }) async =>
      navKey.currentState?.pop<T>(
        result,
      );

  Future<void> popUntil({
    required bool Function(Route<dynamic> route) predicate,
  }) async =>
      navKey.currentState?.popUntil(
        predicate,
      );
}