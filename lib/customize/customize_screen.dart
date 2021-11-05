import 'package:flutter/material.dart';
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
          children: <Widget>[
            Text(
              "Customize",
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: AppCheckboxTile(
                    title: "VS Code",
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
                Expanded(
                  child: AppCheckboxTile(
                    title: "Git",
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
                Expanded(
                  child: AppCheckboxTile(
                    title: "IntelliJ IDEA",
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
                Expanded(
                  child: AppCheckboxTile(
                    title: "Android Studio",
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
