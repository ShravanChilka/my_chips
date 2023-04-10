part of 'errors.dart';

@immutable
abstract class Failure {
  final String error;
  const Failure({
    required this.error,
  });
}

@immutable
class RemoteFailure extends Failure {
  const RemoteFailure({
    required super.error,
  });
}

@immutable
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.error = 'No internet connection!',
  });
}
