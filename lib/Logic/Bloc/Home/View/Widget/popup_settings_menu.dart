library popup_settings_menu;

import 'package:final_project/Logic/Bloc/Home/View/Widget/src/setting/slider_label_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Settings/settings_bloc.dart';

class PopUpSettingsMenu extends StatelessWidget {
  final Widget icon;
  const PopUpSettingsMenu({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return PopupMenuButton(
          icon: icon,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          position: PopupMenuPosition.under,
          itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
            PopupMenuItem(child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return ListTile(
                  leading: (state.themeModeStatus == AppThemeMode.lightMode
                      ? Icon(
                          Icons.light_mode_outlined,
                          color: Theme.of(context).colorScheme.onBackground,
                        )
                      : Icon(
                          Icons.dark_mode_outlined,
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                  title: const Text('Dark Mode ON/OFF'),
                  subtitle: const Text('Change UI theme'),
                  trailing: Switch(
                    value: (state.themeModeStatus == AppThemeMode.lightMode)
                        ? false
                        : true,
                    onChanged: (value) {
                      BlocProvider.of<SettingsBloc>(context).add(
                          ThemeModeChanged(
                              themeModeStatus: (value == true)
                                  ? AppThemeMode.darkMode
                                  : AppThemeMode.lightMode));
                    },
                  ),
                );
              },
            )),
            const PopupMenuDivider(),
            PopupMenuItem(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Font Size'),
                    BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, state) {
                        return Slider(
                          value: context
                              .read<SettingsBloc>()
                              .state
                              .fontSizeSliderValue,
                          min: 0.0,
                          max: 100.0,
                          onChanged: (value) {
                            BlocProvider.of<SettingsBloc>(context)
                                .add(FontSizeChanged(sliderValue: value));
                          },
                          label: SliderLabelGenerator.generator(
                            fontSize: context
                                .read<SettingsBloc>()
                                .state
                                .fontSizeSliderValue
                                .toString(),
                          ),
                          divisions: 3,
                        );
                      },
                    ),
                  ],
                )),
            //PopupMenuDivider(),
            PopupMenuItem(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Internationalization'),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<SettingsBloc, SettingsState>(
                              builder: (context, state) {
                                return SegmentedButton(
                                  multiSelectionEnabled: false,
                                  onSelectionChanged: (internationalization) {
                                    BlocProvider.of<SettingsBloc>(context).add(
                                        InternationalizationChanged(
                                            internationalization:
                                                internationalization));
                                  },
                                  //selectedIcon: const Icon(Icons.done),
                                  segments: const [
                                    ButtonSegment(
                                      value: AppInternatinalization.english,
                                      icon:
                                          null, //Icon(Icons.language_outlined),
                                      label: Text('En'),
                                      enabled: true,
                                    ),
                                    ButtonSegment(
                                      value: AppInternatinalization.sinhala,
                                      icon:
                                          null, //Icon(Icons.language_outlined),
                                      label: Text('සිංහල'),
                                      enabled: true,
                                    ),
                                    ButtonSegment(
                                      value: AppInternatinalization.tamil,
                                      icon:
                                          null, //Icon(Icons.language_outlined),
                                      label: Text('தமிழ்'),
                                      enabled: true,
                                    ),
                                  ],
                                  selected: context
                                      .read<SettingsBloc>()
                                      .state
                                      .internationalization,
                                  emptySelectionAllowed: true,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
