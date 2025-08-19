import 'package:flutter/material.dart';

class AddShowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEditing;
  final VoidCallback onSave;

  const AddShowAppBar({
    super.key,
    required this.isEditing,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      title: Text(
        isEditing ? 'Edit Show' : 'Create Show',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: FilledButton(
            onPressed: onSave,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(isEditing ? 'Save' : 'Create'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
