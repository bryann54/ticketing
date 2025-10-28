// lib/features/shows/presentation/screens/add_show_screen.dart

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticketing/core/di/injector.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';
import 'package:ticketing/features/shows/presentation/widgets/date_time_step.dart';
import 'package:ticketing/features/shows/presentation/widgets/details_step.dart';
import 'package:ticketing/features/shows/presentation/widgets/review_step.dart';
import 'package:ticketing/features/shows/presentation/widgets/step_indicator.dart';
import 'package:ticketing/features/shows/presentation/widgets/type_venue_step.dart';
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
  int _currentStep = 0;

  final List<String> _stepTitles = [
    'Details',
    'Type & Venue',
    'Date & Time',
    'Review'
  ];

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

  bool get _canProceedToNextStep {
    switch (_currentStep) {
      case 0:
        return _nameController.text.trim().isNotEmpty;
      case 1:
        if (_selectedShowType == 'ON_VENUE') {
          return _selectedVenueId != null;
        }
        return true;
      case 2:
        return true;
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (!_canProceedToNextStep) {
      _showValidationError();
      return;
    }

    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _showValidationError() {
    String message = '';
    switch (_currentStep) {
      case 0:
        message = 'Please enter an event name';
        break;
      case 1:
        if (_selectedShowType == 'ON_VENUE' && _selectedVenueId == null) {
          message = 'Please select a venue';
        }
        break;
    }
    if (message.isNotEmpty) {
      _showSnackBar(message, isError: true);
    }
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
          _existingBannerUrl = null;
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
    setState(() {
      _isLoading = true;
    });

    try {
      final showDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      String? bannerUrl;
      if (_selectedImageFile != null) {
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return DetailsStep(
          nameController: _nameController,
          selectedImage: _selectedImageFile,
          existingBannerUrl: _existingBannerUrl,
          onPickImage: _pickImage,
          onRemoveImage: _removeImage,
        );
      case 1:
        return TypeVenueStep(
          selectedShowType: _selectedShowType,
          selectedVenueId: _selectedVenueId,
          venues: widget.venues,
          onShowTypeChanged: (value) {
            setState(() {
              _selectedShowType = value;
              if (value == 'OFF_VENUE') {
                _selectedVenueId = null;
              }
            });
          },
          onVenueChanged: (value) {
            setState(() {
              _selectedVenueId = value;
            });
          },
        );
      case 2:
        return DateTimeStep(
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          onSelectDate: _selectDate,
          onSelectTime: _selectTime,
        );
      case 3:
        return ReviewStep(
          showName: _nameController.text,
          showType: _selectedShowType!,
          venue: _selectedVenueId != null
              ? widget.venues.firstWhere(
                  (v) => v.id == _selectedVenueId,
                  orElse: () => VenueModel.empty(),
                )
              : null,
          date: _selectedDate,
          time: _selectedTime,
          selectedImage: _selectedImageFile,
          existingBannerUrl: _existingBannerUrl,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.showToEdit != null;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => AutoRouter.of(context).maybePop(),
        ),
        title: Text(
          isEditing ? 'Edit Event' : 'Create Event',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
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
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: StepIndicator(
                    currentStep: _currentStep,
                    steps: _stepTitles,
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      key: ValueKey<int>(_currentStep),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildStepContent(),
                    ),
                  ),
                ),
                _buildNavigationButtons(),
              ],
            ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Back'),
                ),
              ),
            if (_currentStep > 0) const SizedBox(width: 12),
            Expanded(
              flex: _currentStep > 0 ? 1 : 1,
              child: FilledButton(
                onPressed: _isLoading
                    ? null
                    : _currentStep == _stepTitles.length - 1
                        ? _submitForm
                        : _nextStep,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _currentStep == _stepTitles.length - 1
                            ? (widget.showToEdit != null
                                ? 'Save Event'
                                : 'Create Event')
                            : 'Continue',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
