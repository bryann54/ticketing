// lib/features/shows/presentation/widgets/banner_image_picker.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Text(
                    'Add event banner',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
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
    final hasImage = selectedImage != null || existingBannerUrl != null;

    return GestureDetector(
      onTap: () => _showImageSourceBottomSheet(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: hasImage ? 220 : 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                hasImage ? Colors.transparent : Theme.of(context).dividerColor,
            width: 1.5,
            style: hasImage ? BorderStyle.none : BorderStyle.solid,
          ),
          color: hasImage ? null : Theme.of(context).cardColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: selectedImage != null
              ? _buildLocalImage(selectedImage!)
              : existingBannerUrl != null
                  ? _buildExistingImage(existingBannerUrl!)
                  : const BannerImagePlaceholder(),
        ),
      ),
    );
  }

  Widget _buildLocalImage(File image) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(
          image,
          fit: BoxFit.cover,
        ),
        _buildEditOverlay(),
      ],
    );
  }

  Widget _buildExistingImage(String url) {
    // Check if it's a network URL
    final isNetwork = url.startsWith('http://') || url.startsWith('https://');

    return Stack(
      fit: StackFit.expand,
      children: [
        if (isNetwork)
          Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
          )
        else
          Image.file(
            File(url),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
          ),
        _buildEditOverlay(),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Builder(
      builder: (context) => Container(
        color:
            Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 8),
              Text(
                'Image unavailable',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditOverlay() {
    return Builder(
      builder: (context) => Positioned(
        top: 12,
        right: 12,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(
            Icons.edit,
            color: Theme.of(context).primaryColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
