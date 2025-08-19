// lib/features/shows/presentation/screens/add_show_screen.dart

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticketing/core/di/injector.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';
import 'package:ticketing/features/shows/presentation/widgets/add_show_appbar.dart';
import 'package:ticketing/features/shows/presentation/widgets/banner_image_picker.dart';
import 'package:ticketing/features/shows/presentation/widgets/date_time_selector.dart';
import 'package:ticketing/features/shows/presentation/widgets/show_name_field.dart';
import 'package:ticketing/features/shows/presentation/widgets/show_type_dropdown.dart';
import 'package:ticketing/features/shows/presentation/widgets/venue_dropdown.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';

@RoutePage()
class AddShowScreen extends StatefulWidget {
  final ShowModel? showToEdit;
  final List<VenueModel> venues;

  const AddShowScreen({
    super.key,
    this.showToEdit,
    required this.venues,
  });

  @override
  State<AddShowScreen> createState() => _AddShowScreenState();
}

class _AddShowScreenState extends State<AddShowScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _showsRepository = getIt<ShowsRepository>();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String? _selectedShowType = 'ON_VENUE';
  int? _selectedVenueId;

  File? _selectedImageFile;
  String? _existingBannerUrl;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  void _initializeFormData() {
    if (widget.showToEdit != null) {
      final show = widget.showToEdit!;
      _nameController.text = show.name;
      _selectedDate = show.date ?? DateTime.now();
      _selectedTime = show.time != null
          ? TimeOfDay.fromDateTime(show.time!)
          : TimeOfDay.now();
      _selectedShowType = show.showType ?? 'ON_VENUE';
      _selectedVenueId = show.venue;
      _existingBannerUrl = show.banner;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxHeight: 1024,
        maxWidth: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImageFile = File(image.path);
          _existingBannerUrl =
              null; // Clear existing URL when new image is selected
        });
      }
    } catch (e) {
      _showSnackBar('Failed to pick image: $e', isError: true);
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImageFile = null;
      _existingBannerUrl = null;
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create the datetime from selected date and time
      final showDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      // Prepare banner URL - in a real app, you would upload the image first
      String? bannerUrl;
      if (_selectedImageFile != null) {
        // TODO: Upload image to your server/cloud storage and get URL
        // For now, we'll use the local path as placeholder
        bannerUrl = _selectedImageFile!.path;
      } else if (_existingBannerUrl != null) {
        bannerUrl = _existingBannerUrl;
      }

      final showModel = ShowModel(
        id: widget.showToEdit?.id,
        name: _nameController.text.trim(),
        date: _selectedDate,
        time: showDateTime,
        banner: bannerUrl,
        showType: _selectedShowType!,
        venue: _selectedVenueId,
      );

      // Call repository method based on whether we're editing or creating
      final result = widget.showToEdit != null
          ? await _showsRepository.editShow(showModel)
          : await _showsRepository.createShow(showModel);

      result.fold(
        (failure) {
          _showSnackBar(
            'Failed to ${widget.showToEdit != null ? 'update' : 'create'} show',
            isError: true,
          );
        },
        (createdShow) {
          _showSnackBar(
            'Show ${widget.showToEdit != null ? 'updated' : 'created'} successfully!',
          );

          // Navigate back and potentially refresh the previous screen
          if (mounted) {
            AutoRouter.of(context).maybePop(createdShow);
          }
        },
      );
    } catch (e) {
      _showSnackBar('An unexpected error occurred: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.showToEdit != null;

    return Scaffold(
      appBar: AddShowAppBar(
        isEditing: isEditing,
        onSave: _isLoading ? () {} : _submitForm,
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Saving show...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Image Picker
                    BannerImagePicker(
                      selectedImage: _selectedImageFile,
                      existingBannerUrl: _existingBannerUrl,
                      onPickImage: _pickImage,
                      onRemoveImage: _removeImage,
                    ),
                    const SizedBox(height: 32),

                    // Show Name Field
                    ShowNameField(
                      controller: _nameController,
                    ),
                    const SizedBox(height: 24),

                    // Show Type Dropdown
                    ShowTypeDropdown(
                      selectedShowType: _selectedShowType,
                      onChanged: (value) {
                        setState(() {
                          _selectedShowType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Venue Dropdown
                    VenueDropdown(
                      venues: widget.venues,
                      selectedVenueId: _selectedVenueId,
                      onChanged: (value) {
                        setState(() {
                          _selectedVenueId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Date & Time Selector
                    DateTimeSelector(
                      selectedDate: _selectedDate,
                      selectedTime: _selectedTime,
                      onSelectDate: _selectDate,
                      onSelectTime: _selectTime,
                    ),

                    // Add some bottom padding for better UX
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
    );
  }
}
