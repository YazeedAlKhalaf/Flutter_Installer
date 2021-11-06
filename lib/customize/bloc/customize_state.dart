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
  // const CustomizeState.initialized()
  //     : this._(
  //         status: CustomizeStatus.initialized,
  //         isVsCodeSelected: false,
  //         isGitSelected: false,
  //         isIntellijIdeaSelected: false,
  //         isAndroidStudioSelected: false,
  //         showAdvanced: false,
  //       );
  // const CustomizeState.appClicked({
  //   bool? isVsCodeSelected,
  //   bool? isGitSelected,
  //   bool? isIntellijIdeaSelected,
  //   bool? isAndroidStudioSelected,
  // }) : this._(
  //         status: CustomizeStatus.appClicked,
  //         isVsCodeSelected: isVsCodeSelected,
  //         isGitSelected: isGitSelected,
  //         isIntellijIdeaSelected: isIntellijIdeaSelected,
  //         isAndroidStudioSelected: isAndroidStudioSelected,
  //       );
  // const CustomizeState.browseClicked({
  //   String? installationPath,
  //   String? installationPathError,
  // }) : this._(
  //         status: CustomizeStatus.browseClicked,
  //         installationPath: installationPath,
  //         installationPathError: installationPathError,
  //       );

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
