part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final String country;

  LanguageState({required this.country});

  @override
  List<Object?> get props => [country];
}
