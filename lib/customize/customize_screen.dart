import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_installer/core/fi_constants.dart';
import 'package:flutter_installer/customize/bloc/customize_bloc.dart';
import 'package:flutter_installer/customize/widgets/app_checkbox_tile.dart';
import 'package:provider/provider.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({Key? key}) : super(key: key);

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<CustomizeBloc>().add(
          const CustomizeInitializeEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(FIConstants.unit),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Customize",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
            const SizedBox(height: FIConstants.unit),
            Text(
              "Choose the installation path:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: BlocBuilder<CustomizeBloc, CustomizeState>(
                    buildWhen: (
                      CustomizeState oldState,
                      CustomizeState newState,
                    ) {
                      return newState.status == CustomizeStatus.browseClicked;
                    },
                    builder: (BuildContext context, CustomizeState state) {
                      return Text(
                        state.installationPathError ??
                            state.installationPath ??
                            "e.g. my_awesome_path/for/fluter",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: state.installationPathError != null
                                  ? Colors.red
                                  : null,
                            ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CustomizeBloc>().add(
                            const CustomizeBrowseEvent(),
                          );
                    },
                    child: Text(
                      "Browse",
                      style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: FIConstants.unit),
            Text(
              "Choose apps you need:",
              style: Theme.of(context).textTheme.headline6,
            ),
            BlocBuilder<CustomizeBloc, CustomizeState>(
              buildWhen: (
                CustomizeState oldState,
                CustomizeState newState,
              ) {
                return newState.status == CustomizeStatus.appClicked;
              },
              builder: (BuildContext context, CustomizeState state) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: AppCheckboxTile(
                        title: "VS Code",
                        value: state.isVsCodeSelected ?? false,
                        onChanged: (bool? newValue) {
                          context.read<CustomizeBloc>().add(
                                CustomizeAppClickedEvent(
                                  isVsCodeSelected: newValue,
                                ),
                              );
                        },
                      ),
                    ),
                    Expanded(
                      child: AppCheckboxTile(
                        title: "Git",
                        value: state.isGitSelected ?? false,
                        onChanged: (bool? newValue) {
                          context.read<CustomizeBloc>().add(
                                CustomizeAppClickedEvent(
                                  isGitSelected: newValue,
                                ),
                              );
                        },
                      ),
                    ),
                    Expanded(
                      child: AppCheckboxTile(
                        title: "IntelliJ IDEA",
                        value: state.isIntellijIdeaSelected ?? false,
                        onChanged: (bool? newValue) {
                          context.read<CustomizeBloc>().add(
                                CustomizeAppClickedEvent(
                                  isIntellijIdeaSelected: newValue,
                                ),
                              );
                        },
                      ),
                    ),
                    Expanded(
                      child: AppCheckboxTile(
                        title: "Android Studio",
                        value: state.isAndroidStudioSelected ?? false,
                        onChanged: (bool? newValue) {
                          context.read<CustomizeBloc>().add(
                                CustomizeAppClickedEvent(
                                  isAndroidStudioSelected: newValue,
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
