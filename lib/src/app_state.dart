import 'package:equatable/equatable.dart';

import 'auth/models/user.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final User user;

  const AppState({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this(status: AppStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
