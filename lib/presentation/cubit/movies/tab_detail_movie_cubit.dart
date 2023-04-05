import 'package:flutter_bloc/flutter_bloc.dart';

class TabDetailMovieCubit extends Cubit<int> {
  TabDetailMovieCubit() : super(0);

  void selectedTab(int index) {
    emit(index);
  }
}
