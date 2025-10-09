import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/merchant/presentation/bloc/mpesa_setup_bloc.dart';

@RoutePage()
class PaymentSetupScreen extends StatefulWidget {
  const PaymentSetupScreen({super.key});

  @override
  State<PaymentSetupScreen> createState() => _PaymentSetupScreenState();
}

class _PaymentSetupScreenState extends State<PaymentSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _consumerKeyController = TextEditingController();
  final _consumerSecretController = TextEditingController();
  final _shortCodeController = TextEditingController();
  final _passKeyController = TextEditingController();
  final _partyBController = TextEditingController();

  String? _selectedIntegrationType;

  @override
  void dispose() {
    _consumerKeyController.dispose();
    _consumerSecretController.dispose();
    _shortCodeController.dispose();
    _passKeyController.dispose();
    _partyBController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedIntegrationType != null) {
      context.read<MpesaSetupBloc>().add(
            AddMpesaDetailsEvent(
              consumerKey: _consumerKeyController.text.trim(),
              consumerSecret: _consumerSecretController.text.trim(),
              shortCode: _shortCodeController.text.trim(),
              passKey: _passKeyController.text.trim(),
              integrationType: _selectedIntegrationType!,
              partyB: _partyBController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MpesaSetupBloc, MpesaSetupState>(
      listener: (context, state) {
        if (state is MpesaSetupSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('M-Pesa details added successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.router.maybePop();
        } else if (state is MpesaSetupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add M-Pesa Business Details',style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,

            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(
                    controller: _consumerKeyController,
                    label: 'Consumer key *',
                    hintText: 'Enter consumer key',
                    description:
                        'This is the consumer key for your mpesa account. Provided by safaricom',
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _consumerSecretController,
                    label: 'Consumer secret *',
                    hintText: 'Enter consumer secret',
                    description:
                        'This is the consumer secret for your mpesa account. Provided by safaricom',
                    isSecret: true,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _shortCodeController,
                    label: 'Short code *',
                    hintText: '0',
                    description:
                        'This is the shortcode for your mpesa account. Provided by safaricom',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passKeyController,
                    label: 'Pass key *',
                    hintText: 'Enter pass key',
                    description:
                        'This is the pass key for your mpesa account. Provided by safaricom',
                    isSecret: true,
                  ),
                  const SizedBox(height: 20),
                  _buildIntegrationTypeDropdown(),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _partyBController,
                    label: 'Party B *',
                    hintText: 'Enter party B',
                    description:
                        'This is the party B for your mpesa account. Provided by safaricom',
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: state is MpesaSetupLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: state is MpesaSetupLoading
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
                            'Add M-Pesa Details',
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required String description,
    bool isSecret = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            children: [
              TextSpan(text: label.split('*')[0]),
              const TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isSecret,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildIntegrationTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            children: [
              TextSpan(text: 'Integration type '),
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedIntegrationType,
          decoration: InputDecoration(
            hintText: 'Select integration type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'till',
              child: Text('Till Number'),
            ),
            DropdownMenuItem(
              value: 'paybill',
              child: Text('PayBill'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _selectedIntegrationType = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please select integration type';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        const Text(
          'This is the integration type for your mpesa account. Provided by safaricom',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
