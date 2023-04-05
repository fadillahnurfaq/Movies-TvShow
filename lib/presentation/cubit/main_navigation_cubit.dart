import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationCubit extends Cubit<int> {
  MainNavigationCubit() : super(0);

  void onBottomNavTapped(int index) {
    emit(index);
  }
}
