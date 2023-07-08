import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initial()) {
    on<ListViewEvent>(_onListChanged);
    on<ChartViewEvent>(_onChartChanged);
    on<TransactionLoading>(_onLoading);
  }
}

Future<void> _onListChanged(
  ListViewEvent event,
  Emitter<ProfileState> emit,
) async {
  emit(const ProfileState.loadListView());
}

Future<void> _onChartChanged(
  ChartViewEvent event,
  Emitter<ProfileState> emit,
) async {
  emit(const ProfileState.loadChartView());
}

Future<void> _onLoading(
  TransactionLoading event,
  Emitter<ProfileState> emit,
) async {
  emit(const ProfileState.loading());
}
