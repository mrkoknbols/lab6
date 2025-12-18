import 'package:equatable/equatable.dart';
import '../models/apod_model.dart';

abstract class APODState extends Equatable {
  const APODState();

  @override
  List<Object> get props => [];
}

class APODInitial extends APODState {}

class APODLoading extends APODState {}

class APODLoaded extends APODState {
  final APODModel apod;

  const APODLoaded(this.apod);

  @override
  List<Object> get props => [apod];
}

class APODError extends APODState {
  final String message;

  const APODError(this.message);

  @override
  List<Object> get props => [message];
}