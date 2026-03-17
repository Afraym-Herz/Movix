import 'package:equatable/equatable.dart';


abstract class SavedShowsStates extends Equatable {
  const SavedShowsStates();

  @override
  List<Object?> get props => [];
}

class SavedShowsInitial extends SavedShowsStates {}

class SavedShowsLoading extends SavedShowsStates {}

class SavedShowsSuccess extends SavedShowsStates {
  final List<Map<String, dynamic>> ratedItems;

  const SavedShowsSuccess(this.ratedItems);

  @override
  List<Object?> get props => [ratedItems];
}

class SavedShowsError extends SavedShowsStates {
  final String message;

  const SavedShowsError(this.message);

  @override
  List<Object?> get props => [message];
}
