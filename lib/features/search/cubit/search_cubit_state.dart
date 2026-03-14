part of 'search_cubit.dart';

abstract class SearchCubitState extends Equatable {
  const SearchCubitState();

  @override
  List<Object?> get props => [];
}

class SearchCubitInitial extends SearchCubitState {}

class SearchCubitLoading extends SearchCubitState {}

class SearchCubitSuccess extends SearchCubitState {
  final List<ShowModel>? shows;

  const SearchCubitSuccess({required this.shows});

  @override
  List<Object?> get props => [shows];
}

class SearchCubitEmpty extends SearchCubitState {}

class SearchCubitFailure extends SearchCubitState {
  final String errMessage;

  const SearchCubitFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
