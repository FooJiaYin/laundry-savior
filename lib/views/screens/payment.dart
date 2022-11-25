// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../widgets/scaffold_page.dart';
import 'machine.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    Key? key,
    required this.machine,
  }) : super(key: key);

  final Machine machine;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => MachinePage(widget.machine),
        ),
      ),
      child: const ScaffoldPage(
        backgroundColor: Colors.black,
        backgroundImage: DecorationImage(
          image: AssetImage("assets/images/payment.png"),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
