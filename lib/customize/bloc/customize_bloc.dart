import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customize_event.dart';
part 'customize_state.dart';

class CustomizeBloc extends Bloc<CustomizeEvent, CustomizeState> {
  CustomizeBloc() : super(const CustomizeState.unknown()) {
    on<CustomizeInitializeEvent>(_onCustomizeInitializeEvent);
    on<CustomizeBrowseEvent>(_onCustomizeBrowseEvent);
    on<CustomizeAppClickedEvent>(_onCustomizeAppClickedEvent);
  }

  void _onCustomizeInitializeEvent(
    CustomizeInitializeEvent event,
    Emitter<CustomizeState> emit,
  ) {
    emit(const CustomizeState.initialized());
  }

  void _onCustomizeBrowseEvent(
    CustomizeBrowseEvent event,
    Emitter<CustomizeState> emit,
  ) {}

  void _onCustomizeAppClickedEvent(
    CustomizeAppClickedEvent event,
    Emitter<CustomizeState> emit,
  ) {}
}
