import 'package:FMS/utlis/utlis.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/response/status.dart';
import '../../../res/color/colors.dart';
import '../../../res/components/general_exception.dart';
import '../../../res/components/internet_exception_widget.dart';
import '../../../res/routes/routes_name.dart';
import '../../../view_models/controller/task/task_controller.dart';
import '../../report/report.dart';
import '../../widget/loading_task_detail.dart';

class MaintainTask extends StatelessWidget {
  final String? taskId;
  final taskController = Get.find<TaskController>();
  MaintainTask({super.key, required this.taskId});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColor.whiteColor,
            onPressed: () {
              Get.toNamed(RouteName.taskScreen);
            },
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xff0e4e86),
                Color(0xff1461a2),
                Color(0xff2e7abb),
              ],
            )),
          ),
          title: const Text(
            "Chi tiết nhiệm vụ",
            style: TextStyle(
              color: AppColor.whiteColor,
              letterSpacing: 1,
            ),
          ),
        ),
        body: Obx(
          () {
            switch (taskController.rxRequestDetailStatus.value) {
              case StatusAPI.LOADING:
                return const LoadingTaskPage();
              case StatusAPI.COMPLETED:
                final taskInfo = taskController.taskDetail.value.data;
                String? jsonDateString = taskInfo?.requestDate;
                String nonNullableString =
                    jsonDateString ?? "2023-09-19T08:53:33.0000694";
                DateTime date = DateTime.parse(nonNullableString);
                String formattedDate = DateFormat('dd-MM-yyyy').format(date);
                IconData statusIcon;
                IconData submitIcon;
                Color statusColor;
                Color submitColor;
                Text submitText;
                switch (taskInfo?.status) {
                  case 1:
                    statusIcon = Icons.insights;
                    statusColor = Colors.orange;
                    submitColor = Colors.blue;
                    submitIcon = Icons.check;
                    submitText = const Text(
                      "Chấp Nhận Nhiệm Vụ",
                      style: TextStyle(color: AppColor.whiteColor),
                    );
                    break;
                  case 2:
                    statusIcon = Icons.timelapse;
                    statusColor = Colors.amber;
                    submitColor = Colors.green;
                    submitIcon = Icons.document_scanner_rounded;
                    submitText = const Text(
                      "Báo Cáo Nhiệm Vụ",
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    );
                    break;
                  case 3:
                    statusIcon = Icons.schedule_send;
                    statusColor = Colors.blue;
                    submitColor = Colors.blueGrey;
                    submitIcon = Icons.schedule_send;
                    submitText = const Text(
                      " Đã Báo Cáo Nhiệm Vụ",
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    );
                    break;
                  case 4:
                    statusIcon = Icons.assignment_turned_in;
                    statusColor = Colors.green;
                    submitColor = Colors.grey;
                    submitIcon = Icons.assignment_turned_in;
                    submitText = const Text(
                      "Đã Hoàn Thành",
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    );
                    break;
                  case 5:
                    statusIcon = Icons.highlight_off;
                    statusColor = Colors.grey;
                    submitColor = Colors.blue;
                    submitIcon = Icons.highlight_off;
                    submitText = const Text(
                      "Chấp Nhận Nhiệm Vụ",
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    );
                    break;
                  default:
                    statusIcon = Icons.error;
                    statusColor = Colors.red;
                    submitColor = Colors.blue;
                    submitIcon = Icons.check;
                    submitText = const Text(
                      "Chấp Nhận Nhiệm Vụ",
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 620,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff0c4377),
                                    Color(0xff114c81),
                                    Color(0xff134777),
                                    Color(0xff1960a1),
                                  ],
                                ),
                              ),
                              height: taskController.isExpanded.value ? 320 : 220,
                              child: Column(
                                children: [
                                  Theme(
                                    data: ThemeData().copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      onExpansionChanged: (value) {
                                        taskController.isExpanded.value = value;
                                      },
                                      leading: const Icon(
                                          Icons.add_chart_outlined,
                                          size: 30,
                                          color: Colors.white),
                                      title: Text(
                                        "${taskInfo?.typeObj?.displayName}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      trailing: const Icon(Icons.info,
                                          color: AppColor.whiteColor),
                                      expandedAlignment: Alignment.topLeft,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          height: 100,
                                          child: SingleChildScrollView(
                                            child: Text(
                                              "${taskInfo?.description}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 175,
                                        child: ListTile(
                                          leading: const Icon(Icons.room,
                                              color: Colors.white, size: 25),
                                          title: Text(
                                            'Phòng ${taskInfo?.currentRoom?.roomCode}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 185,
                                        child: ListTile(
                                          leading: const Icon(Icons.event,
                                              color: Colors.white, size: 25),
                                          title: Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    height: 30,
                                    child: ListTile(
                                      leading: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color: Colors.white),
                                        child: Icon(statusIcon,
                                            color: statusColor, size: 20),
                                      ),
                                      title: Text(
                                        'Trạng thái: ${taskInfo?.statusObj?.displayName}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ListTile(
                                      leading: const Icon(Icons.key_rounded,
                                          color: Colors.white, size: 25),
                                      title: Text(
                                        "Mã: ${taskInfo?.requestCode}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 12),
                              child: Text("Thông Tin Thiết Bị Cần Bảo Trì:",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                            Container(
                              height: 200,
                              padding: const EdgeInsets.all(15),
                              child: Accordion(
                                paddingListTop: 0,
                                paddingListBottom: 0,
                                maxOpenSections: 1,
                                headerBackgroundColorOpened: Colors.black54,
                                headerPadding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 15),
                                children: [
                                  AccordionSection(
                                    isOpen: false,
                                    leftIcon: const Icon(Icons.compare_rounded,
                                        color: Colors.white),
                                    header: Text('${taskInfo?.asset?.assetName}',
                                        style: const TextStyle(
                                            color: AppColor.whiteColor,
                                            fontSize: 18)),
                                    headerBackgroundColor: Colors.black38,
                                    headerBackgroundColorOpened:
                                    const Color(0xff1960a1),
                                    contentBorderColor: Colors.black54,
                                    content: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                "Mã Thiết bị: ${taskInfo?.asset?.assetCode}",
                                                style: const TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            child: Text(
                                                "Số lượng: ${taskInfo?.asset?.quantity}",
                                                style: const TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontSize: 18)),
                                          ),
                                          SizedBox(
                                            child: Text(
                                                "Vị trí: Phòng ${taskInfo?.currentRoom?.roomCode}",
                                                style: const TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontSize: 18)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        String nonID = taskInfo?.id ??
                            "00000000-0000-0000-0000-000000000000";
                        switch (taskInfo?.status) {
                          case 1:
                            taskController.acceptTask(nonID);
                            break;
                          case 2:
                            Get.to(() => ReportPage());
                            break;
                          case 3:
                            Utils.snackBar(
                                "Thông báo:", "Nhiệm vụ đã được báo cáo");
                            break;
                          case 4:
                            Utils.snackBar(
                                "Thông báo:", "Nhiệm vụ đã hoàn thành");
                            break;
                          case 5:
                            Utils.snackBar(
                                "Thông báo:", "Nhiệm vụ đã bị hủy bỏ");
                            break;
                          default:
                          // Handle the default case if needed
                            break;
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: submitColor,
                            borderRadius: BorderRadius.circular(15)),
                        margin: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(submitIcon, color: AppColor.whiteColor),
                            submitText
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              case StatusAPI.ERROR:
                if (taskController.error.value == 'No internet') {
                  return InternetExceptionWidget(
                    onPress: () {
                      taskController.refreshApi();
                    },
                  );
                } else {
                  return GeneralExceptionWidget(onPress: () {
                    taskController.refreshApi();
                  });
                }
            }
          },
        ),
      ),
    );
  }
}
