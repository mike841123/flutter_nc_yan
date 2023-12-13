import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_color.dart';
import '../../component/custom_appbar.dart';


class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  CurrentPageState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends CurrentPageState<TransactionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image to base64 Encodin1g'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
            )
          ],
        ),
      ),
    );
  }
}
