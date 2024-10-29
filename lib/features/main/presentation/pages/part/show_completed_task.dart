import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/common/widget/custom_toast.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowCompletedUsers extends StatelessWidget {
  final TaskResponse taskModel;

  const ShowCompletedUsers({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: ListView.separated(

        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: wi(20),
          vertical: he(30)
        ),
        itemCount: taskModel.completedStudents.length,
        itemBuilder: (context, index) {
          var studentModel = taskModel.completedStudents[index];

          var completedTask = studentModel.completedTasksIds
              .firstWhere((task) => task.task.id == taskModel.id);

          return Row(
            children: [
              Text(
                "${studentModel.name}\n${studentModel.email}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              SizedBox(
                height: he(30),
                width: wi(30),
                child: IconButton.filled(
                  onPressed: () async {
                    if (completedTask.fileUrl.isNotEmpty) {
                      final uri = Uri.parse(completedTask.fileUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {

                        // Handle the error when the URL can't be launched
                        customToast(message: 'Could not open the file URL.', bgColor: Colors.red);

                      }
                    } else {
                      customToast(message: 'No file URL available for this task.', bgColor: Colors.red);

                    }
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    AppIcons.icOpenEye,
                    width: wi(24),
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding:  EdgeInsets.symmetric(vertical: he(10)),
            child: customDivider,
          );
        },
      ),
    );
  }
}
