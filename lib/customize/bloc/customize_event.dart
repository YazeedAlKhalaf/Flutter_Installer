part of 'customize_bloc.dart';

abstract class CustomizeEvent extends Equatable {
  const CustomizeEvent();

  @override
  List<Object> get props => [];
}

class CustomizeInitializeEvent extends CustomizeEvent {
  const CustomizeInitializeEvent();
}

class CustomizeBrowseEvent extends CustomizeEvent {
  const CustomizeBrowseEvent();
}

class CustomizeAppClickedEvent extends CustomizeEvent {
  const CustomizeAppClickedEvent({
    this.isVsCodeSelected,
    this.isGitSelected,
    this.isIntellijIdeaSelected,
    this.isAndroidStudioSelected,
  });

  final bool? isVsCodeSelected;
  final bool? isGitSelected;
  final bool? isIntellijIdeaSelected;
  final bool? isAndroidStudioSelected;
}
