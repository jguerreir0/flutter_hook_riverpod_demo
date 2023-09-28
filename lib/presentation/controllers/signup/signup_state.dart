import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupStateInitial extends SignupState {
  const SignupStateInitial();

  @override
  List<Object?> get props => [];
}

class SignupStateLoading extends SignupState {
  const SignupStateLoading();

  @override
  List<Object?> get props => [];
}

class SignupStateSuccess extends SignupState {
  const SignupStateSuccess();

  @override
  List<Object?> get props => [];
}

class SignupStateFailure extends SignupState {
  final String errorMessage;

  const SignupStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
