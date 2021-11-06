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
  ) {
    // TODO: call browse from
    emit(const CustomizeState.browseClicked(
      installationPath: "the best installation path ever for flutter",
    ));
  }

  void _onCustomizeAppClickedEvent(
    CustomizeAppClickedEvent event,
    Emitter<CustomizeState> emit,
  ) {
    if (event.isVsCodeSelected != null ||
        event.isGitSelected != null ||
        event.isIntellijIdeaSelected != null ||
        event.isAndroidStudioSelected != null) {
      emit(
        CustomizeState.appClicked(
          isVsCodeSelected: event.isVsCodeSelected ?? state.isVsCodeSelected,
          isGitSelected: event.isGitSelected ?? state.isGitSelected,
          isIntellijIdeaSelected:
              event.isIntellijIdeaSelected ?? state.isIntellijIdeaSelected,
          isAndroidStudioSelected:
              event.isAndroidStudioSelected ?? state.isAndroidStudioSelected,
        ),
      );
    }
  }
}
