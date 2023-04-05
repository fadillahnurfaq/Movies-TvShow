import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/tv_series/tv_series_entity.dart';
import 'package:movies_app/domain/usecase/tv_series/get_airing_today_tv_series.dart';

part 'airing_today_tv_series_event.dart';
part 'airing_today_tv_series_state.dart';

class AiringTodayTvSeriesBloc
    extends Bloc<AiringTodayTvSeriesEvent, AiringTodayTvSeriesState> {
  final GetAiringTodayTvSeries _getAiringTodayTvSeries;

  AiringTodayTvSeriesBloc(this._getAiringTodayTvSeries)
      : super(AiringTodayTvSeriesInitialState()) {
    on<AiringTodayTvSeriesEvent>((event, emit) async {
      if (event is GetAiringTodayTvSeriesEvent) {
        emit(AiringTodayTvSeriesLoadingState());

        final result = await _getAiringTodayTvSeries.execute();
        result.fold(
          (failure) => emit(AiringTodayTvSeriesErrorState(failure.message)),
          (data) => emit(AiringTodayTvSeriesHasDataState(data)),
        );
      }
    });
  }
}
