import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_color.dart';


class OtcPage extends StatefulWidget {
  const OtcPage({super.key});

  @override
  CurrentPageState<OtcPage> createState() => _OtcPageState();
}

class _OtcPageState extends CurrentPageState<OtcPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image to base64 Encoding'),
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
