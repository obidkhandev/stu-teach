import 'package:flutter/cupertino.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_task_item.dart';

class TeacherTasksList extends StatelessWidget {
  const TeacherTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TeacherTaskItem();
      },
      separatorBuilder: (BuildContext context, int index) {
        return customDivider;
      },
    );
  }
}
