import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import '../../../../driven/abstract/current_page_state.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/depth_chart.dart';
import 'package:k_chart/entity/index.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/renderer/index.dart';
import 'package:k_chart/utils/data_util.dart';
import 'package:k_chart/utils/index.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  CurrentPageState<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends CurrentPageState<MarketPage> {
  List<KLineEntity>? datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  bool isChinese = true;
  bool _hideGrid = false;
  bool _showNowPrice = true;
  List<DepthEntity>? _bids, _asks;
  bool isChangeUI = false;
  bool _isTrendLine = false;
  bool _priceLeft = true;
  VerticalTextAlignment _verticalTextAlignment = VerticalTextAlignment.left;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/depth.json').then((result) {
      final parseJson = json.decode(result);
      final tick = parseJson['tick'] as Map<String, dynamic>;
      final List<DepthEntity> bids = (tick['bids'] as List<dynamic>).map<DepthEntity>((item) => DepthEntity(item[0] as double, item[1] as double)).toList();
      final List<DepthEntity> asks = (tick['asks'] as List<dynamic>).map<DepthEntity>((item) => DepthEntity(item[0] as double, item[1] as double)).toList();
      initDepth(bids, asks);
    });
  }

  void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids!.insert(0, item);
    });

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks!.add(item);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("ETH/USDT",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "HelveticaNeue",
              fontStyle: FontStyle.normal,
              fontSize: 17.sp,
            ),
            textAlign: TextAlign.center),
        elevation: 0,
        backgroundColor: const Color(0xff2e2e2e),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 90.h,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, top: 16.h, bottom: 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("36954.61",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w700, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 21.sp),
                            textAlign: TextAlign.left),
                        addVerticalSpace(14.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp),
                                text: "≈269768.65 CNY",
                              ),
                              const TextSpan(text: " "),
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13.sp,
                                  fontFamily: 'HelveticaNeue',
                                  fontWeight: FontWeight.w700,
                                ),
                                text: "-0.56%",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120.w,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w, top: 10.h, bottom: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("高",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.left),
                              addHorizontalSpace(20.w),
                              Text("37388",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("低",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.left),
                              addHorizontalSpace(20.w),
                              Text("37388",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("24H量",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.left),
                              addHorizontalSpace(20.w),
                              Text("37388",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 390.w,
              height: 38.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: const BoxDecoration(color: Color(0xff2e2e2e)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabBarBtn("分时", false),
                  tabBarBtn("1分钟", true),
                  tabBarBtn("5分钟", false),
                  tabBarBtn("1小时", false),
                  tabBarBtn("1天", false),
                  tabBarBtn("更多", false),
                  InkWell(
                    onTap: () {

                    },
                    child: tabBarBtn("指標", false),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  height: 320.h,
                  width: double.infinity,
                  child: KChartWidget(
                    datas,
                    chartStyle,
                    chartColors,
                    isLine: isLine,
                    onSecondaryTap: () {
                      print('Secondary Tap');
                    },
                    isTrendLine: _isTrendLine,
                    mainState: _mainState,
                    volHidden: _volHidden,
                    secondaryState: _secondaryState,
                    fixedLength: 2,
                    timeFormat: TimeFormat.YEAR_MONTH_DAY,
                    translations: kChartTranslations,
                    showNowPrice: _showNowPrice,
                    //`isChinese` is Deprecated, Use `translations` instead.
                    isChinese: isChinese,
                    hideGrid: _hideGrid,
                    isTapShowInfoDialog: false,
                    verticalTextAlignment: _verticalTextAlignment,
                    maDayList: [1, 100, 1000, 10000],
                  ),
                ),
                // Positioned(
                //   child: Container(
                //     width: 390.w,
                //     height: 20.h,
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
            if (showLoading) Container(width: double.infinity, height: 450, alignment: Alignment.center, child: const CircularProgressIndicator()),
            buildButtons(),
            if (_bids != null && _asks != null)
              Container(
                height: 230,
                width: double.infinity,
                child: DepthChart(_bids!, _asks!, chartColors),
              )
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        button("Time Mode", onPressed: () => isLine = true),
        button("K Line Mode", onPressed: () => isLine = false),
        button("TrendLine", onPressed: () => _isTrendLine = !_isTrendLine),
        button("Line:MA", onPressed: () => _mainState = MainState.MA),
        button("Line:BOLL", onPressed: () => _mainState = MainState.BOLL),
        button("Hide Line", onPressed: () => _mainState = MainState.NONE),
        button("Secondary Chart:MACD", onPressed: () => _secondaryState = SecondaryState.MACD),
        button("Secondary Chart:KDJ", onPressed: () => _secondaryState = SecondaryState.KDJ),
        button("Secondary Chart:RSI", onPressed: () => _secondaryState = SecondaryState.RSI),
        button("Secondary Chart:WR", onPressed: () => _secondaryState = SecondaryState.WR),
        button("Secondary Chart:CCI", onPressed: () => _secondaryState = SecondaryState.CCI),
        button("Secondary Chart:Hide", onPressed: () => _secondaryState = SecondaryState.NONE),
        button(_volHidden ? "Show Vol" : "Hide Vol", onPressed: () => _volHidden = !_volHidden),
        button("Change Language", onPressed: () => isChinese = !isChinese),
        button(_hideGrid ? "Show Grid" : "Hide Grid", onPressed: () => _hideGrid = !_hideGrid),
        button(_showNowPrice ? "Hide Now Price" : "Show Now Price", onPressed: () => _showNowPrice = !_showNowPrice),
        button("Customize UI", onPressed: () {
          setState(() {
            this.isChangeUI = !this.isChangeUI;
            if (this.isChangeUI) {
              chartColors.selectBorderColor = Colors.red;
              chartColors.selectFillColor = Colors.red;
              chartColors.lineFillColor = Colors.red;
              chartColors.kLineColor = Colors.yellow;
            } else {
              chartColors.selectBorderColor = Color(0xff6C7A86);
              chartColors.selectFillColor = Color(0xff0D1722);
              chartColors.lineFillColor = Color(0x554C86CD);
              chartColors.kLineColor = Color(0xff4C86CD);
            }
          });
        }),
        button("Change PriceTextPaint",
            onPressed: () => setState(() {
                  _priceLeft = !_priceLeft;
                  if (_priceLeft) {
                    _verticalTextAlignment = VerticalTextAlignment.left;
                  } else {
                    _verticalTextAlignment = VerticalTextAlignment.right;
                  }
                })),
      ],
    );
  }

  Widget tabBarBtn(String title, bool isSelected) {
    return Stack(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              color: const Color(0xff808080),
              fontWeight: FontWeight.w400,
              fontFamily: "HelveticaNeue",
              fontStyle: FontStyle.normal,
              fontSize: 14.sp,
            ),
          ),
        ),
        isSelected
            ? Positioned(
                bottom: 0,
                child: Container(
                    width: 33,
                    height: 2,
                    decoration: const BoxDecoration(
                      color: Color(0xff00cfbe),
                    )),
              )
            : empty()
      ],
    );
  }

  Widget button(String text, {VoidCallback? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          setState(() {});
        }
      },
      child: Text(text),
      style: TextButton.styleFrom(
        primary: Colors.white,
        minimumSize: const Size(88, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void getData(String period) {
    final Future<String> future = getChatDataFromJson();
    future.then((String result) {
      solveChatData(result);
    }).catchError((_) {
      showLoading = false;
      setState(() {});
      print('### datas error $_');
    });
  }

  // 如果你不能翻墙，可以使用这个方法加载数据
  Future<String> getChatDataFromJson() async {
    return rootBundle.loadString('assets/chatData.json');
  }

  void solveChatData(String result) {
    final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
    final list = parseJson['data'] as List<dynamic>;
    datas = list.map((item) => KLineEntity.fromJson(item as Map<String, dynamic>)).toList().reversed.toList().cast<KLineEntity>();
    DataUtil.calculate(datas!);
    showLoading = false;
    setState(() {});
  }
}
