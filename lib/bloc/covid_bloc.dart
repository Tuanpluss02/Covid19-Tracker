import 'package:covid19_tracker/model/covid.dart';
import 'package:covid19_tracker/resources/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<FetchCovid>((event, emit) {
      try {
        emit(CovidLoading());
        apiRepository.getCovidWithIsolate().then((value) {
          emit(CovidLoaded(covidModel: value));
        });
      } on NetworkError {
        emit(const CovidError(
            message: "Couldn't fetch data. Is the device online?"));
      }
    });
  }
}
