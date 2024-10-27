part of 'main_tab_cubit.dart';

class MainTabState extends Equatable {
  final int index;

  const MainTabState({required this.index});

  @override
  List<Object> get props => [index];

  MainTabState copyWith({int? index}) {
    return MainTabState(
      index: index ?? this.index,
    );
  }

}
