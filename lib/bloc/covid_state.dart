part of 'covid_bloc.dart';

abstract class CovidState extends Equatable {
  const CovidState();

  @override
  List<Object> get props => [];
}

class CovidInitial extends CovidState {}

class CovidLoading extends CovidState {}

class CovidLoaded extends CovidState {
  final CovidModel covidModel;
  const CovidLoaded({required this.covidModel});
  @override
  List<Object> get props => [covidModel];
}

class CovidError extends CovidState {
  final String message;
  const CovidError({required this.message});
  @override
  List<Object> get props => [message];
}
