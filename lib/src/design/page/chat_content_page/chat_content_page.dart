import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../domain/response/chat_page_response/history_msg_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import '../../model/user_cubit/user_cubit.dart';
import 'chat_content_cubit.dart';

class ChatContentPage extends StatefulWidget {
  const ChatContentPage({super.key});

  @override
  CurrentPageState<ChatContentPage> createState() => _ChatContentPageState();
}

class _ChatContentPageState extends CurrentPageState<ChatContentPage> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController pwController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<RoutesCubit>(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
          title: Text("賣家",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "HelveticaNeue",
                fontStyle: FontStyle.normal,
                fontSize: 17.sp,
              ),
              textAlign: TextAlign.center),
          backgroundColor: const Color(0xff2e2e2e),
        ),
        body: BlocListener<ChatContentCubit, ChatContentState>(
          listenWhen: (previous, current) => previous.msgStatus != current.msgStatus,

          /// 當監聽到傳送訊息成功 scroll移到最底下
          listener: (context, state) {
            if(state.msgStatus == MsgStatus.success) {
              print("123");
              scrollController.jumpTo(0);
            }

          },
          child: BlocBuilder<ChatContentCubit, ChatContentState>(
            builder: (context, state) {
              List<HistoryMsgResult> list = state.historyMsgResponse;
              print(list.length);
              String username = BlocProvider.of<UserCubit>(context).getUser()?.username ?? "";
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 80.h + MediaQuery.of(context).padding.bottom),
                    child: ListView.separated(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      itemCount: list.length,
                      shrinkWrap: true,
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: list[index].nameFrom != username ? Alignment.centerLeft : Alignment.centerRight,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            textDirection: list[index].nameFrom != username ? TextDirection.ltr : TextDirection.rtl,
                            children: [
                              list[index].nameFrom != username
                                  ? Container(
                                      width: 60.r,
                                      height: 60.r,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 5.w,
                                          )),
                                    )
                                  : empty(),
                              addHorizontalSpace(4.w),
                              Column(
                                crossAxisAlignment: list[index].nameFrom != username ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(minWidth: 30.w, maxWidth: 300.w),
                                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
                                    child: Text(list[index].content,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.sp),
                                        textAlign: TextAlign.left),
                                  ),
                                  addVerticalSpace(4.h),
                                  Text(list[index].sendTimeStr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "HelveticaNeue",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50.h,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SafeArea(
                      child: Container(
                        height: 70.h,
                        color: Color(0xff2e2e2e),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 20.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: pwController,
                                    style: TextStyle(
                                      fontFamily: 'MicrosoftYaHei',
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                    ),
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 12.w, right: 12.w),
                                      hintText: '輸入對話文字',
                                      hintStyle: TextStyle(color: Color(0xff333333), fontSize: 14.sp),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(
                                        fontFamily: 'MicrosoftYaHei',
                                        color: const Color(0xffbbbdc0),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent, width: 2.w),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        //focus輸入匡線顏色
                                        borderSide: BorderSide(color: const Color(0xffE58D24), width: 2.w),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.pets,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ChatContentCubit>(context).sendMsg(pwController.text);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
