import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/account.dart';
import '../../theme/theme.dart';
import '../../utils/validation.dart';
import '../widgets/button.dart';
import '../widgets/form.dart';
import '../widgets/scaffold_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _email = TextEditingController(text: "");
  final _password = TextEditingController(text: "");
  bool _validateError = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FieldTitle(S.of(context).email),
          EmailField(_email, validation: !_validateError, errorText: " "),
          const SizedBox(height: 24),
          FieldTitle(S.of(context).password),
          PasswordField(_password, validation: !_validateError, errorText: " "),
          const SizedBox(height: 24),
          Button(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false),
            text: S.of(context).sign_in,
          ),
        ],
      ),
    );
  }
}
