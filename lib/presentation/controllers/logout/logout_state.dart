import 'package:equatable/equatable.dart';

class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object?> get props => [];
}

class LogoutStateInitial extends LogoutState {
  const LogoutStateInitial();

  @override
  List<Object?> get props => [];
}

class LogoutStateLoading extends LogoutState {
  const LogoutStateLoading();

  @override
  List<Object?> get props => [];
}

class LogoutStateSuccess extends LogoutState {
  const LogoutStateSuccess();

  @override
  List<Object?> get props => [];
}

class LogoutStateFailure extends LogoutState {
  final String errorMessage;

  const LogoutStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
