import 'package:flutter_bloc/flutter_bloc.dart';

class TabDetailTvSeriesCubit extends Cubit<int> {
  TabDetailTvSeriesCubit() : super(0);

  void selectedTab(int index) {
    emit(index);
  }
}
