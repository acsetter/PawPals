import 'package:flutter/material.dart';

import 'package:paw_pals/utils/app_localizations.dart';
import 'package:paw_pals/widgets/forms/recovery_form.dart';
import 'package:paw_pals/widgets/wrappers/form_wrapper.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("page-titles.recovery")),
      ),
      body: const SingleChildScrollView(
        child: FormWrapper(
          children: [
            EmailForm(),
          ],
        ),
      ),
    );
  }
}