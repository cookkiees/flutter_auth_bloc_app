part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  final String? userId;

  const HomeEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class HomeUserInitialEvent extends HomeEvent {
  const HomeUserInitialEvent({String? userId}) : super(userId: userId);
}

class HomeUserRefreshEvent extends HomeEvent {
  const HomeUserRefreshEvent({String? userId}) : super(userId: userId);
}
