import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pavega_assignment/presentation/record/components/recording_settings.dart';
import 'package:pavega_assignment/presentation/record/record_tab_controller.dart';
import 'package:pavega_assignment/utils/constants/colors.dart';
import 'package:pavega_assignment/utils/constants/font_styles.dart';
import 'drop_down_container.dart';
import 'recording_setting_row.dart';
import 'recording_setting_widget.dart';

class SettingsBottomSheet extends StatelessWidget {
  final WidgetRef ref;
  final bool isDark;
  const SettingsBottomSheet({
    Key? key,
    required this.isDark,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Recording Settings', style: FontStyles.montserratBold19()),
          const SizedBox(height: 20),
          RecordingSettingRow(
            rowWidgets: [
              RecordingSettingWidget(
                settingName: "Resolution",
                dropDownWidget: DropDownContainer(
                  isDark: isDark,
                  dropDownWidget: Center(
                    child: DropdownButton<RecordingResolution>(
                      style: FontStyles.montserratSemiBold13(),
                      underline: const SizedBox.shrink(),
                      dropdownColor: AppColors.darkGrey,
                      iconEnabledColor: AppColors.white,
                      iconDisabledColor: Colors.grey[300],
                      value: ref.watch(resolutionProvider),
                      items: RecordingResolution.values
                          .map(
                            (resolution) =>
                                DropdownMenuItem<RecordingResolution>(
                              value: resolution,
                              child: Text(
                                resolutionToString(resolution),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (resolution) => ref
                          .watch(resolutionProvider.notifier)
                          .update((state) => resolution!),
                    ),
                  ),
                ),
              ),
              RecordingSettingWidget(
                settingName: "Frame Rate",
                dropDownWidget: DropDownContainer(
                  isDark: isDark,
                  dropDownWidget: Center(
                    child: DropdownButton<int>(
                      style: FontStyles.montserratSemiBold13(),
                      underline: const SizedBox.shrink(),
                      dropdownColor: AppColors.darkGrey,
                      iconEnabledColor: AppColors.white,
                      iconDisabledColor: Colors.grey[300],
                      value: ref.watch(frameRateProvider),
                      items: [30, 60]
                          .map((fps) => DropdownMenuItem<int>(
                                value: fps,
                                child: Text('$fps FPS'),
                              ))
                          .toList(),
                      onChanged: (fps) => ref
                          .watch(frameRateProvider.notifier)
                          .update((state) => fps!),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RecordingSettingRow(
            rowWidgets: [
              RecordingSettingWidget(
                settingName: "Bitrate",
                dropDownWidget: DropDownContainer(
                  isDark: isDark,
                  dropDownWidget: Center(
                    child: DropdownButton<Bitrate>(
                      style: FontStyles.montserratSemiBold13(),
                      underline: const SizedBox.shrink(),
                      dropdownColor: AppColors.darkGrey,
                      iconEnabledColor: AppColors.white,
                      iconDisabledColor: AppColors.white,
                      value: ref.watch(bitrateProvider),
                      items: Bitrate.values
                          .map((bitrate) => DropdownMenuItem<Bitrate>(
                                value: bitrate,
                                child: Text(bitrateToString(bitrate)),
                              ))
                          .toList(),
                      onChanged: (bitrate) => ref
                          .watch(bitrateProvider.notifier)
                          .update((state) => bitrate!),
                    ),
                  ),
                ),
              ),
              RecordingSettingWidget(
                settingName: "Orientation",
                dropDownWidget: DropDownContainer(
                  isDark: isDark,
                  dropDownWidget: Center(
                    child: DropdownButton<RecordingOrientation>(
                      style: FontStyles.montserratSemiBold13(),
                      underline: const SizedBox.shrink(),
                      dropdownColor: AppColors.darkGrey,
                      iconEnabledColor: AppColors.white,
                      iconDisabledColor: Colors.grey[300],
                      value: ref.watch(orientationProvider),
                      items: RecordingOrientation.values
                          .map(
                            (orientation) =>
                                DropdownMenuItem<RecordingOrientation>(
                              value: orientation,
                              child: Text(
                                orientationToString(orientation),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (orientation) => ref
                          .watch(orientationProvider.notifier)
                          .update((state) => orientation!),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                if (ref.read(isTimerStoppedProvider)) {
                  startScreenRecord();
                  TimerService.instance.startTimer(ref);
                  ref
                      .read(isTimerStoppedProvider.notifier)
                      .update((state) => false);
                }

                Navigator.pop(context);
              },
              child: const Text('Start Recording'),
            ),
          ),
        ],
      ),
    );
  }
}
