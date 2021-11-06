import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_installer/core/repository/file_system_repository.dart';

part 'customize_event.dart';
part 'customize_state.dart';

class CustomizeBloc extends Bloc<CustomizeEvent, CustomizeState> {
  final FileSystemRepository fileSystemRepository;

  CustomizeBloc({
    required this.fileSystemRepository,
  }) : super(const CustomizeState.unknown()) {
    on<CustomizeInitializeEvent>(_onCustomizeInitializeEvent);
    on<CustomizeBrowseEvent>(_onCustomizeBrowseEvent);
    on<CustomizeAppClickedEvent>(_onCustomizeAppClickedEvent);
  }

  void _onCustomizeInitializeEvent(
    CustomizeInitializeEvent event,
    Emitter<CustomizeState> emit,
  ) {
    emit(const CustomizeState.unknown().copyWith(
      status: CustomizeStatus.initialized,
    ));
  }

  void _onCustomizeBrowseEvent(
    CustomizeBrowseEvent event,
    Emitter<CustomizeState> emit,
  ) async {
    final String? chosenPath = await fileSystemRepository.getDirectoryPath();

    emit(state.copyWith(
      status: CustomizeStatus.browseClicked,
      installationPath: chosenPath ?? state.installationPath,
      installationPathError:
          chosenPath == null && state.installationPath == null
              ? "You must choose an installation path!"
              : null,
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
        state.copyWith(
          status: CustomizeStatus.appClicked,
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
