part of 'errors.dart';

@immutable
class RemoteException implements Exception {
  final String error;
  const RemoteException({
    required this.error,
  });
}

@immutable
class NetworkException implements Exception {
  const NetworkException();
}
