import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/app_mode_provider.dart';

class AppModeButton extends ConsumerWidget {
  const AppModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    final appModeNotifier = ref.read(appModeProvider.notifier);

    return IconButton(
      onPressed: () {
        appModeNotifier.toggleMode();
      },
      icon: Icon(
        appMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}
