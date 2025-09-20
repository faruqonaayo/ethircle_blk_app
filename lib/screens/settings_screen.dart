import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/widgets/password_change.dart';
import 'package:ethircle_blk_app/providers/user_provider.dart';
import 'package:ethircle_blk_app/screens/profile_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final userData = ref.watch(userProvider);

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
      tween: Tween(begin: 160.0, end: 0.0),
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Settings",
            style: textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.person, color: colorScheme.onPrimary),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: textTheme.bodySmall!.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        "${userData?.firstName ?? "..."} ${userData?.lastName ?? "..."}",
                        style: textTheme.bodyLarge!.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout, color: colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 32),

          _SettingsOption(
            label: "User Profile",
            icon: Icons.person_outline,
            onTapOption: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => ProfileScreen()));
            },
          ),
          const SizedBox(height: 16),
          _SettingsOption(
            label: "Change Password",
            icon: Icons.lock_outlined,
            onTapOption: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => PasswordChange(ctx),
              );
            },
          ),
          const SizedBox(height: 16),
          _SettingsOption(label: "FAQ's", icon: Icons.question_mark),
          const SizedBox(height: 16),
          _SettingsOption(label: "About Developer", icon: Icons.code),
        ],
      ),
      builder: (_, value, myChild) =>
          Transform.translate(offset: Offset(value, 0), child: myChild),
    );
  }
}

class _SettingsOption extends StatelessWidget {
  const _SettingsOption({
    required this.label,
    required this.icon,
    this.onTapOption,
  });

  final String label;
  final IconData icon;
  final Function()? onTapOption;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapOption,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        child: Row(
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.onSurface),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
