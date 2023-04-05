import 'package:flutter_bloc/flutter_bloc.dart';

class TabSelectedCubit extends Cubit<int> {
  TabSelectedCubit() : super(0);

  void selectedTab(int index) {
    emit(index);
  }
}
