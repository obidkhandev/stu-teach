import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_tab_state.dart';

class MainTabCubit extends Cubit<MainTabState> {
  MainTabCubit() : super(const MainTabState(index: 0));

  void changeTabIndex(int index){
    emit(state.copyWith(index: index));
  }
}
