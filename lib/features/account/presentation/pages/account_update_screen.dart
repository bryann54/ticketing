// lib/features/account/presentation/screens/account_update_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/common/utils/functions.dart';
import 'package:ticketing/features/merchant/data/models/merchant_model.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_bloc.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_event.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_state.dart';

@RoutePage()
class AccountUpdateScreen extends StatefulWidget {
  const AccountUpdateScreen({super.key});

  @override
  State<AccountUpdateScreen> createState() => _AccountUpdateScreenState();
}

class _AccountUpdateScreenState extends State<AccountUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load current merchant data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final merchantBloc = context.read<MerchantBloc>();
      if (merchantBloc.state.merchant != null) {
        _populateForm(merchantBloc.state.merchant!);
      } else {
        merchantBloc.add(GetMerchantDetailsEvent());
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  void _populateForm(MerchantModel merchant) {
    setState(() {
      _nameController.text = merchant.name;
      _emailController.text = merchant.businessEmail ?? '';
      _telephoneController.text = merchant.businessTelephone ?? '';
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<MerchantBloc>().add(
            UpdateMerchantEvent(
              name: _nameController.text.trim(),
              businessEmail: _emailController.text.trim(),
              businessTelephone: _telephoneController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MerchantBloc, MerchantState>(
      listener: (context, state) {
        if (state.status == MerchantStatus.success && state.merchant != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Business account updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.router.maybePop();
        } else if (state.status == MerchantStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Update failed'),
              backgroundColor: Colors.red,
            ),
          );
        }

        // Populate form when merchant data is loaded
        if (state.merchant != null && _nameController.text.isEmpty) {
          _populateForm(state.merchant!);
        }
      },
      child: BlocBuilder<MerchantBloc, MerchantState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Update business account'.capitalize(0),
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black87),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Business Name Field
                    _buildTextFieldSection(
                      controller: _nameController,
                      label: 'Business name',
                      hintText: 'Enter your business name',
                      description: 'This will be your public display name.',
                      isRequired: true,
                    ),
                    const SizedBox(height: 28),

                    // Business Email Field
                    _buildTextFieldSection(
                      controller: _emailController,
                      label: 'Business email',
                      hintText: 'Enter your business email',
                      description: 'This will be the primary contact email.',
                      isRequired: true,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 28),

                    // Business Telephone Field
                    _buildTextFieldSection(
                      controller: _telephoneController,
                      label: 'Business telephone',
                      hintText: 'Enter your business phone number',
                      description:
                          'This will be the primary contact phone number.',
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                    ),

                    // Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFFE5E7EB),
                      ),
                    ),

                    // Update Button
                    ElevatedButton(
                      onPressed: state.status == MerchantStatus.loading
                          ? null
                          : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        shadowColor:
                            AppColors.primaryColor.withValues(alpha: 0.3),
                      ),
                      child: state.status == MerchantStatus.loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Update Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextFieldSection({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required String description,
    required bool isRequired,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.4,
            ),
            children: [
              TextSpan(text: label),
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Text Field
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return 'This field is required';
            }
            if (label.toLowerCase().contains('email') && value!.isNotEmpty) {
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
            }
            if (label.toLowerCase().contains('telephone') &&
                value!.isNotEmpty) {
              final phoneRegex = RegExp(r'^[0-9+\-\s]+$');
              if (!phoneRegex.hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: 8),

        // Description text
        Text(
          description,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
