import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movix/core/models/show_model.dart';
import 'package:movix/features/search/repos/search_repo.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit(this._searchRepo) : super(SearchCubitInitial());
  final SearchRepo _searchRepo ;
  Timer? _debounce;

  Future<void> searchMethod({required String showTitle}) async {
    if (showTitle.isEmpty) {
      _debounce?.cancel();
      emit(SearchCubitInitial());
      return;
    }

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(SearchCubitLoading());
      
      final result = await _searchRepo.searchMethod(showTitle: showTitle);
      result.fold(
        (l) => emit(SearchCubitFailure(errMessage: l.message)),
        (r) {
          if (r.results.isEmpty) {
            emit(SearchCubitEmpty());
          } else {
            emit(SearchCubitSuccess(shows: r.results));
          }
        },
      );
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
