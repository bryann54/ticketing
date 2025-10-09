// lib/features/account/presentation/screens/account_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:ticketing/common/notifiers/locale_provider.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/common/res/l10n.dart';
import 'package:ticketing/common/utils/functions.dart';
import 'package:ticketing/features/account/presentation/bloc/account_bloc.dart';
import 'package:ticketing/features/account/presentation/widgets/account_header.dart';
import 'package:ticketing/features/account/presentation/widgets/account_navigation_menu.dart';
import 'package:ticketing/features/account/presentation/widgets/error_retry_widget.dart';
import 'package:ticketing/features/account/presentation/widgets/logout_button_widget.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_bloc.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_event.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_state.dart';



@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MerchantBloc merchantBloc = context.read<MerchantBloc>();
    final LocaleProvider provider =
        Provider.of<LocaleProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (merchantBloc.state.status == MerchantStatus.initial) {
        merchantBloc.add(GetMerchantDetailsEvent());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.getString(context, 'account'.capitalize(0)),
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
              LogOutButton()
          ],
        ),
       centerTitle: true,
     
      ),
      body: RefreshIndicator(
         onRefresh: () async {
          merchantBloc.add(GetMerchantDetailsEvent());
        },
        child: BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is ChangeLanguageSuccess) {
              provider.setLocale(Locale(state.langCode));
            }
          },
          child: BlocBuilder<MerchantBloc, MerchantState>(
            builder: (context, merchantState) {
              final isLoading = merchantState.status == MerchantStatus.loading;
        
              return SingleChildScrollView(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    _buildMerchantHeader(
                        context, merchantState, merchantBloc, isLoading),
                    const SizedBox(height: 24),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: AccountNavigationMenu(),
                    ),
                      const SizedBox(height: 54),
               
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMerchantHeader(
    BuildContext context,
    MerchantState state,
    MerchantBloc bloc,
    bool isLoading,
  ) {
    if (isLoading && state.merchant == null) {
      return const Center(
        heightFactor: 3,
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (state.status == MerchantStatus.error && state.merchant == null) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: ErrorRetryWidget(
          error: state.errorMessage ??
              AppLocalizations.getString(context, 'merchant_load_error'),
          onRetry: () => bloc.add(GetMerchantDetailsEvent()),
        ),
      );
    }

    if (state.merchant != null) {
      return AccountHeaderSection(
        merchant: state.merchant!,
        userEmail: state.merchant!.businessEmail ?? 'user@business.com',
      );
    }

    return const SizedBox.shrink();
  }
}
