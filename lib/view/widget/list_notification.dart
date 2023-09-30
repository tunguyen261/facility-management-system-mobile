import 'package:FMS/data/response/status.dart';
import 'package:FMS/res/color/colors.dart';
import 'package:FMS/view_models/controller/notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../res/components/general_exception.dart';
import '../../res/components/internet_exception_widget.dart';

class NotificationPopUp extends StatelessWidget {
  NotificationPopUp({super.key});
  final notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(color: AppColor.primaryColor),
                    Text("Thông Báo",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            Obx(() {
              switch (notificationController.rxRequestStatus.value) {
                case Status.LOADING:
                  return Center(
                      child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const CircularProgressIndicator(
                        color: AppColor.primaryColor),
                  ));
                case Status.COMPLETED:
                  return
                    SizedBox(
                      height: 600,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: notificationController
                            .notificationList.value.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final notification = notificationController
                              .notificationList.value.data![index];
                          final isRead = notification.isRead == true;
                          String? jsonDateString = notification.createdAt;
                          DateTime date = DateTime.parse(jsonDateString!);
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(date);
                          return GestureDetector(
                            onTap: () {
                              print("TAP! TAP !${notification.itemId}");
                            },
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: isRead
                                    ? const Color(0xA6B7AAAA)
                                    : AppColor.primaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(notification.title!.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: AppColor.whiteColor)),
                                        Text(notification.shortContent!.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColor.whiteColor),
                                            maxLines: 2),

                                        Text("ID: ${notification.itemId!.toString()}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColor.whiteColor),
                                            maxLines: 1),
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                      thickness: 1,
                                      color: AppColor.whiteColor),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(formattedDate,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.whiteColor)),
                                      const SizedBox(height: 20),
                                      if (!isRead)
                                        const Icon(Icons.notification_important,
                                            color: AppColor.whiteColor),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                case Status.ERROR:
                  if (notificationController.error.value == 'No internet') {
                    return InternetExceptionWidget(
                      onPress: () {
                        notificationController.refreshApi();
                      },
                    );
                  } else {
                    return GeneralExceptionWidget(onPress: () {
                      notificationController.refreshApi();
                    }); // Return the Text widget
                  }
              }
            })
          ],
        ),
      ),
    );
  }
}
