import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/domain/entities/tv_series/tv_series_entity.dart';
import 'package:movies_app/domain/usecase/tv_series/get_search_tv_series.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final GetSearchTvSeries _getSearchTvSeries;

  SearchTvSeriesBloc(this._getSearchTvSeries)
      : super(SearchTvSeriesInitialState()) {
    on<SearchTvSeriesEvent>(
      (event, emit) async {
        if (event is SearchTvSeriesOnQueryChangedEvent) {
          final query = event.query;

          emit(SearchTvSeriesLoadingState());

          final result = await _getSearchTvSeries.execute(query);

          result.fold(
            (failure) => emit(SearchTvSeriesErrorState(failure.message)),
            (data) {
              if (data.isEmpty) {
                emit(SearchTvSeriesEmptyState());
              } else {
                emit(SearchTvSeriesHasDataState(data));
              }
            },
          );
        }
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
