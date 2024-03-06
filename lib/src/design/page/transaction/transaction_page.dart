import 'package:flutter/material.dart';
import 'package:yan_demo_fcm/driven/abstract/current_page_state.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends CurrentPageState<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
