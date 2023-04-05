import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/usecase/tv_series/get_on_the_air_tv_series.dart';

import '../../../../domain/entities/tv_series/tv_series_entity.dart';

part 'on_the_air_tv_series_event.dart';
part 'on_the_air_tv_series_state.dart';

class OnTheAirTvSeriesBloc
    extends Bloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState> {
  final GetOnTheAirTvSeries _getOnTheAirTvSeries;
  OnTheAirTvSeriesBloc(this._getOnTheAirTvSeries)
      : super(OnTheAirTvSeriesInitialState()) {
    on<OnTheAirTvSeriesEvent>((event, emit) async {
      if (event is GetOnTheAirTvSeriesEvent) {
        emit(OnTheAirTvSeriesLoadingState());

        final result = await _getOnTheAirTvSeries.execute();
        result.fold(
          (failure) => emit(OnTheAirTvSeriesErrorState(failure.message)),
          (data) => emit(OnTheAirTvSeriesHasDataState(data)),
        );
      }
    });
  }
}
