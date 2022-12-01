import 'package:flutter/material.dart';

import '../../models/global_state.dart';
import '../components/exit_alert_dialog.dart';
import '../widgets/scaffold_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final willPop = await showDialog<bool>(context: context, builder: (context) => const ExitAlertDialog(title: "Payment not completed", description: "Are you sure to exit?"));
        return willPop!;
      },
      child: GestureDetector(
        onTap: () {
          GlobalState.set(context, status: Status.mode);
          Navigator.pushNamed(context, "/current_machine");
        },
        child: const ScaffoldPage(
          backgroundColor: Colors.black,
          backgroundImage: DecorationImage(
            image: AssetImage("assets/images/payment.png"),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
