import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState(country: 'USA')) {
    on<LanguageEventToggle>(
      (event, emit) async {
        emit(LanguageState(country: event.country));
      },
    );
  }
}
