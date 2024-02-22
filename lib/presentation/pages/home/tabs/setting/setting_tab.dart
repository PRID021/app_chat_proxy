import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../../../router/app_router.dart';
import '../../../../../utils/components/comom_app_bar.dart';
import '../../../login/authenticate_provider.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const CommonAppBar(
            title: "Setting",
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SettingSection(),
              ElevatedButton(
                onPressed: () {
                  context.router.push(ChatRoute(title: "From Home"));
                },
                child: const Text("Q?A"),
              ),
              const Spacer(),
              const Divider(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer(builder: (context, ref, _) {
                  return TextButton(
                    onPressed: () {
                      ref
                          .read(authenticateNotifierProvider.notifier)
                          .clearStorage();
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.logout), Gap(8), Text("Logout")],
                    ),
                  );
                }),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class SettingSection extends StatelessWidget {
  const SettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Appearance"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Light mode"),
                  SizedBox(
                    height: 32,
                    child: LiteRollingSwitch(
                      width: 88,
                      value: true,
                      colorOn: Theme.of(context).colorScheme.primary,
                      colorOff: Theme.of(context).colorScheme.tertiary,
                      textOn: 'Light',
                      textOff: 'Dark',
                      iconOn: Icons.sunny,
                      iconOff: Icons.mode_night_rounded,
                      textSize: 12,
                      onChanged: (bool state) {},
                      onTap: () {},
                      onDoubleTap: () {},
                      onSwipe: () {},
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Language"),
                  SizedBox(
                    height: 32,
                    child: LiteRollingSwitch(
                      width: 64,
                      value: true,
                      colorOn: Theme.of(context).colorScheme.primary,
                      colorOff: Theme.of(context).colorScheme.tertiary,
                      textOn: 'En',
                      textOff: 'Vi',
                      iconOn: Icons.done,
                      iconOff: Icons.remove_circle_outline,
                      textSize: 12,
                      onChanged: (bool state) {},
                      onTap: () {},
                      onDoubleTap: () {},
                      onSwipe: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
