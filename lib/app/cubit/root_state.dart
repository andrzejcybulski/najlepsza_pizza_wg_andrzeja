part of 'root_cubit.dart';

@immutable
class RootState {
  final User? user;

  final bool isLoading;
  final String errorMessage;

  RootState({
    required this.user,
    required this.isLoading,
    required this.errorMessage,
  });
}
