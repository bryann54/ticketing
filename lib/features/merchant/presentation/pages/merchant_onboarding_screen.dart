// lib/features/auth/presentation/pages/merchant_onboarding_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_bloc.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_event.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_state.dart';
import 'package:ticketing/features/auth/presentation/widgets/auth_button.dart';
import 'package:ticketing/features/auth/presentation/widgets/auth_text_field.dart';

@RoutePage()
class MerchantOnboardingScreen extends StatefulWidget {
  const MerchantOnboardingScreen({super.key});

  @override
  State<MerchantOnboardingScreen> createState() =>
      _MerchantOnboardingScreenState();
}

class _MerchantOnboardingScreenState extends State<MerchantOnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _businessEmailController =
      TextEditingController();
  final TextEditingController _businessTelephoneController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkFormValidity);
    _businessEmailController.addListener(_checkFormValidity);
    _businessTelephoneController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _nameController.removeListener(_checkFormValidity);
    _businessEmailController.removeListener(_checkFormValidity);
    _businessTelephoneController.removeListener(_checkFormValidity);
    _nameController.dispose();
    _businessEmailController.dispose();
    _businessTelephoneController.dispose();
    super.dispose();
  }

  void _checkFormValidity() {
    final bool allFieldsFilled = _nameController.text.isNotEmpty &&
        _businessEmailController.text.isNotEmpty &&
        _businessTelephoneController.text.isNotEmpty;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final bool isEmailValid =
        emailRegex.hasMatch(_businessEmailController.text);

    final bool isTelephoneValid =
        _businessTelephoneController.text.length >= 10;

    final bool newCanSubmit =
        allFieldsFilled && isEmailValid && isTelephoneValid;
    if (_canSubmit != newCanSubmit) {
      setState(() {
        _canSubmit = newCanSubmit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MerchantBloc, MerchantState>(
      listener: (context, state) {
        if (state.status == MerchantStatus.success) {
          context.router.replaceNamed('/main');
        } else if (state.status == MerchantStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
              backgroundColor: Colors.red.withValues(alpha: 0.9),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      child: Scaffold(
       
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                        children:[
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/tickoyako.png'), 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                         GestureDetector(
                          onTap: () => context.router.maybePop(),
                          child: Text(
                            'Skip',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ]
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Create business account',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Set up your business profile to start managing events',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Business Name Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business name *',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AuthTextField(
                        controller: _nameController,
                        label: 'Enter business name',
                        icon: Icons.business_outlined,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Business name is required';
                          }
                          return null;
                        },
                        onChanged: (value) => _checkFormValidity(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This will be your public display name.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  )
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 24),

                  // Business Email Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business email *',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AuthTextField(
                        controller: _businessEmailController,
                        label: 'business@email.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Business email is required';
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          return emailRegex.hasMatch(value!)
                              ? null
                              : 'Enter a valid email address';
                        },
                        onChanged: (value) => _checkFormValidity(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This will be the primary contact email.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  )
                      .animate(delay: 400.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 24),

                  // Business Telephone Field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business telephone *',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AuthTextField(
                        controller: _businessTelephoneController,
                        label: 'Enter phone number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Business telephone is required';
                          }
                          if (value!.length < 10) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        onChanged: (value) => _checkFormValidity(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This will be the primary contact phone number.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  )
                      .animate(delay: 500.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 40),

                  // Divider
                  Divider(
                    color:
                        Theme.of(context).dividerColor.withValues(alpha: 0.3),
                  ).animate(delay: 600.ms).fadeIn(duration: 600.ms),
                  const SizedBox(height: 32),

                  // Create Account Button
                  BlocBuilder<MerchantBloc, MerchantState>(
                    builder: (context, state) {
                      return AuthButton(
                        text: 'Create account',
                        isEnabled: _canSubmit &&
                            state.status != MerchantStatus.loading,
                        isLoading: state.status == MerchantStatus.loading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<MerchantBloc>().add(
                                  CreateMerchantEvent(
                                    name:
                                        _nameController.text.trim(),
                                    businessEmail:
                                        _businessEmailController.text.trim(),
                                    businessTelephone:
                                        _businessTelephoneController.text
                                            .trim(),
                                  ),
                                );
                          }
                        },
                        heroTag: 'create_merchant_button',
                      );
                    },
                  )
                      .animate(delay: 700.ms)
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
