import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shatably_app/feature/home/ui/home_screen.dart';
import 'applayout_state.dart';

class ApplayoutCubit extends Cubit<ApplayoutState> {
  ApplayoutCubit() : super(ApplayoutInitial());

  List<Widget> pages = [HomeScreen(), Scaffold(), Scaffold(), Scaffold()];

  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    emit(ApplayoutChangePage());
  }
}
