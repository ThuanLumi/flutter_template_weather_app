part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class LanguageEventToggle extends LanguageEvent {
  final String country;

  LanguageEventToggle({required this.country});

  @override
  List<Object?> get props => [country];
}
