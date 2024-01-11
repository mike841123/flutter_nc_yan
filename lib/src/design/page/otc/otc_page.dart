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
        title: Text('demo'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    constraints: BoxConstraints(
                      minWidth: 50,
                    ),
                    color: Colors.yellow,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('TEST'),
                    )),
                  ),
addVerticalSpace(30),
                  Container(
                    height: 50,
                    constraints: BoxConstraints(
                      minWidth: 50,
                    ),
                    color: Colors.yellow,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('TEST121212121212'),
                    )),
                  ),
                  addVerticalSpace(30),
                  Container(
                    height: 50,
                    constraints: BoxConstraints(
                      minWidth: 50,
                    ),
                    color: Colors.yellow,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('T'),
                    )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
