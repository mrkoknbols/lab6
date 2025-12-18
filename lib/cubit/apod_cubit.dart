import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/apod_service.dart';
import 'apod_state.dart';
import '../models/apod_model.dart';

class APODCubit extends Cubit<APODState> {
  APODCubit() : super(APODInitial());

  Future<void> fetchAPOD({String? date}) async {
    emit(APODLoading());
    try {
      final APODModel apod = await APODService.fetchAPOD(date: date);
      emit(APODLoaded(apod));
    } catch (e) {
      emit(APODError(e.toString()));
    }
  }
}