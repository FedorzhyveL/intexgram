part of 'pages_cubit.dart';

abstract class PagesState extends Equatable {
  const PagesState();

  @override
  List<Object> get props => [];
}

class PagesInitial extends PagesState {}

class PageReady extends PagesState {
  final PersonEntity user;

  const PageReady(this.user);
  @override
  List<Object> get props => [user];
}
