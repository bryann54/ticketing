import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticketing/features/shows/presentation/widgets/banner_image_display.dart';
import 'package:ticketing/features/shows/presentation/widgets/banner_image_placeholder.dart';
import 'package:ticketing/features/shows/presentation/widgets/image_source_tile.dart';

class BannerImagePicker extends StatelessWidget {
  final File? selectedImage;
  final String? existingBannerUrl;
  final Function(ImageSource) onPickImage;
  final VoidCallback onRemoveImage;

  const BannerImagePicker({
    super.key,
    this.selectedImage,
    this.existingBannerUrl,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  void _showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                ImageSourceTile(
                  icon: Icons.photo_camera,
                  title: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    onPickImage(ImageSource.camera);
                  },
                ),
                ImageSourceTile(
                  icon: Icons.photo_library,
                  title: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    onPickImage(ImageSource.gallery);
                  },
                ),
                if (selectedImage != null || existingBannerUrl != null)
                  ImageSourceTile(
                    icon: Icons.delete,
                    title: 'Remove Image',
                    isDestructive: true,
                    onTap: () {
                      Navigator.pop(context);
                      onRemoveImage();
                    },
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Banner Image',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(width: 8),
            if (selectedImage == null && existingBannerUrl == null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Optional',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showImageSourceBottomSheet(context),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
                style: BorderStyle.solid,
              ),
              color: Theme.of(context).cardColor,
            ),
            child: selectedImage != null
                ? BannerImageDisplay(imageFile: selectedImage!)
                : existingBannerUrl != null
                    ? BannerImageDisplay(imageUrl: existingBannerUrl!)
                    : const BannerImagePlaceholder(),
          ),
        ),
      ],
    );
  }
}
