part of 'customize_bloc.dart';

enum CustomizeStatus {
  unknown,
  initialized,
  appClicked,
  browseClicked,
}

class CustomizeState extends Equatable {
  const CustomizeState._({
    required this.status,
    this.isVsCodeSelected,
    this.isGitSelected,
    this.isIntellijIdeaSelected,
    this.isAndroidStudioSelected,
    this.showAdvanced,
    this.installationPath,
    this.installationPathError,
  });

  const CustomizeState.unknown() : this._(status: CustomizeStatus.unknown);

  final CustomizeStatus status;
  final bool? isVsCodeSelected;
  final bool? isGitSelected;
  final bool? isIntellijIdeaSelected;
  final bool? isAndroidStudioSelected;
  final bool? showAdvanced;
  final String? installationPath;
  final String? installationPathError;

  @override
  List<Object?> get props => <Object?>[
        status,
        isVsCodeSelected,
        isGitSelected,
        isIntellijIdeaSelected,
        isAndroidStudioSelected,
        showAdvanced,
        installationPath,
        installationPathError,
      ];

  CustomizeState copyWith({
    CustomizeStatus? status,
    bool? isVsCodeSelected,
    bool? isGitSelected,
    bool? isIntellijIdeaSelected,
    bool? isAndroidStudioSelected,
    bool? showAdvanced,
    String? installationPath,
    String? installationPathError,
  }) {
    return CustomizeState._(
      status: status ?? this.status,
      isVsCodeSelected: isVsCodeSelected ?? this.isVsCodeSelected,
      isGitSelected: isGitSelected ?? this.isGitSelected,
      isIntellijIdeaSelected:
          isIntellijIdeaSelected ?? this.isIntellijIdeaSelected,
      isAndroidStudioSelected:
          isAndroidStudioSelected ?? this.isAndroidStudioSelected,
      showAdvanced: showAdvanced ?? this.showAdvanced,
      installationPath: installationPath,
      installationPathError: installationPathError,
    );
  }
}
