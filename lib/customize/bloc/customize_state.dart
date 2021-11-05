part of 'customize_bloc.dart';

enum CustomizeStatus {
  unknown,
  initialized,
}

class CustomizeState extends Equatable {
  const CustomizeState._({
    required this.status,
    this.isVsCodeSelected,
    this.isGitSelected,
    this.isIntellijIdeaSelected,
    this.isAndroidStudioSelected,
    this.showAdvanced,
  });

  const CustomizeState.unknown()
      : this._(
          status: CustomizeStatus.unknown,
        );
  const CustomizeState.initialized()
      : this._(
          status: CustomizeStatus.initialized,
          isVsCodeSelected: false,
          isGitSelected: false,
          isIntellijIdeaSelected: false,
          isAndroidStudioSelected: false,
          showAdvanced: false,
        );

  final CustomizeStatus status;
  final bool? isVsCodeSelected;
  final bool? isGitSelected;
  final bool? isIntellijIdeaSelected;
  final bool? isAndroidStudioSelected;
  final bool? showAdvanced;

  @override
  List<Object?> get props => <Object?>[
        status,
        isVsCodeSelected,
        isGitSelected,
        isIntellijIdeaSelected,
        isAndroidStudioSelected,
        showAdvanced,
      ];
}
