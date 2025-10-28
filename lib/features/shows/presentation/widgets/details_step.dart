// lib/features/shows/presentation/widgets/steps/details_step.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticketing/features/shows/presentation/widgets/banner_image_picker.dart';
import 'package:ticketing/features/shows/presentation/widgets/show_name_field.dart';

class DetailsStep extends StatelessWidget {
  final TextEditingController nameController;
  final File? selectedImage;
  final String? existingBannerUrl;
  final Function(ImageSource) onPickImage;
  final VoidCallback onRemoveImage;

  const DetailsStep({
    super.key,
    required this.nameController,
    required this.selectedImage,
    required this.existingBannerUrl,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What\'s your event called?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Give your event a memorable name and add a cover image',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 32),
          ShowNameField(controller: nameController),
          const SizedBox(height: 32),
          BannerImagePicker(
            selectedImage: selectedImage,
            existingBannerUrl: existingBannerUrl,
            onPickImage: onPickImage,
            onRemoveImage: onRemoveImage,
          ),
        ],
      ),
    );
  }
}
