import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/base_response.dart';
import '../../../onboarding/ppi/domain/ppi_user_response.dart';
import '../../../onboarding/ppi/repository/ppi_response_repository.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final PpiResponseRepository _ppiResponseRepository;

  HomeScreenBloc({required PpiResponseRepository ppiResponseRepository})
      : _ppiResponseRepository = ppiResponseRepository,
        super(const HomeScreenState()) {
    on<GetUserSnapShots>(_onGetUserSnapshots);
  }

  _onGetUserSnapshots(
      GetUserSnapShots event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    var response = await _ppiResponseRepository.getUserSnapShotFromLocal();
    if (response == null) {
      emit(state.copyWith(response: BaseResponse.error()));
    } else {
      emit(state.copyWith(response: BaseResponse.complete<SnapShot>(response)));
    }
  }
}
