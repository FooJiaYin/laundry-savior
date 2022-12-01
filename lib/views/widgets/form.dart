import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../utils/time.dart';
import '../../utils/validation.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      alignment: Alignment.centerLeft,
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

TextStyle inputTextStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

class EmailField extends StatelessWidget {
  const EmailField(
    this.controller, {
    Key? key,
    this.validation,
    this.errorText,
    this.setState,
  }) : super(key: key);

  final TextEditingController controller;
  final bool? validation;
  final String? errorText;
  final setState;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: inputTextStyle,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: S.of(context).email_hint,
        errorText: (validation ?? controller.isEmail) ? null : errorText ?? S.of(context).email_hint,
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField(
    this.controller, {
    Key? key,
    this.validation,
    this.errorText,
    this.setState,
  }) : super(key: key);

  final TextEditingController controller;
  final bool? validation;
  final String? errorText;
  final setState;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: inputTextStyle,
      obscureText: _hidePassword,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (_) => widget.setState(() {}),
      decoration: InputDecoration(
        hintText: S.of(context).password_hint,
        errorText: (widget.validation ?? widget.controller.isValidPassword) ? null : widget.errorText ?? S.of(context).password_hint,
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            _hidePassword = !_hidePassword;
          }),
          icon: Icon(
            _hidePassword ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}

class BasicTextField extends StatelessWidget {
  const BasicTextField(
    this.controller, {
    Key? key,
    this.validation,
    this.errorText,
    this.setState,
  }) : super(key: key);
  final TextEditingController controller;
  final bool? validation;
  final String? errorText;
  final setState;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: inputTextStyle,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
        setState(() {});
      },
      decoration: InputDecoration(
        // hintText: S.of(context).text_hint,
        errorText: (validation ?? controller.isBlank) ? null : errorText ?? "  ",
      ),
    );
  }
}

class DateField extends StatefulWidget {
  const DateField({
    Key? key,
    this.initialDate,
    this.validation,
    this.errorText,
    this.onChanged,
  }) : super(key: key);
  final bool? validation;
  final String? errorText;
  final DateTime? initialDate;
  final onChanged;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final _controller = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  selectDate() async {
    final date = await showDatePicker(context: context, initialDate: _selectedDate ?? DateTime.now(), firstDate: DateTime(1900, 1, 1), lastDate: DateTime.now());
    if (date == null) return;
    else _selectedDate = date;
    widget.onChanged(_selectedDate);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: selectDate,
      controller: TextEditingController(text: _selectedDate == null ? "" : DateFormat("yyyy / MM / dd").format(_selectedDate!)),
      style: inputTextStyle,
      showCursor: true,
      readOnly: true,
      decoration: InputDecoration(
        errorText: (widget.validation ?? _selectedDate != null) ? null : widget.errorText ?? "  ",
      ),
    );
  }
}
