import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/custom_toast.dart';
import 'package:stu_teach/features/common/widget/text_field_widget.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';

class EditTaskDialog extends StatefulWidget {
  final TaskResponse model;

  const EditTaskDialog({super.key, required this.model});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _nameController;
  late TextEditingController _tarifController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  String fileUrl = '';
  String fileType = '';

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.model.title);
    _tarifController = TextEditingController(text: widget.model.tarif);
    selectedDate = DateTime.parse(widget.model.date);
    fileUrl = widget.model.fileUrl;
    fileType = widget.model.urlType;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tarifController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.model.date),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: MultiBlocListener(
        listeners: [
          BlocListener<UploadFileCubit, UploadFileState>(
            listener: (context, fileState) {
              if (fileState is UploadFileSuccess) {
                setState(() {
                  fileUrl = fileState.url;
                });
                customToast(
                    message: "File uploaded successfully",
                    bgColor: AppColors.primaryColor);
              } else if (fileState is UploadFileFailure) {
                customToast(
                    message: "Upload failed: ${fileState.failure}",
                    bgColor: Colors.red);
              }
            },
          ),
          BlocListener<TaskCubit, TaskState>(
            listener: (context, taskState) {
              if (taskState is TaskEdited) {
                context.read<UploadFileCubit>().reset();
                context.read<TaskCubit>().fetchAllTasks();
                customToast(
                    message: "Task edited successfully",
                    bgColor: AppColors.primaryColor);
                Navigator.of(context).pop();
              } else if (taskState is TaskError) {
                customToast(
                    message: "Failed to edit task: ${taskState.failure}",
                    bgColor: Colors.red);
              }
            },
          ),
        ],
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Edit Task",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Enter task name",
                    textEditingController: _nameController,
                    textInputType: TextInputType.text,
                    label: "Task Name",
                    validator: (value) => value?.isEmpty == true
                        ? 'Please enter the task name'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Enter tarif",
                    textEditingController: _tarifController,
                    textInputType: TextInputType.text,
                    label: "Tarif",
                    validator: (value) => value?.isEmpty == true
                        ? 'Please enter the tarif'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: selectedDate != null
                              ? "Date: ${selectedDate!.toLocal().toString().split(' ')[0]}"
                              : "Select Date",
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          text: fileUrl.isNotEmpty
                              ? "File Uploaded"
                              : "Upload File",
                          isLoading: context.watch<UploadFileCubit>().state
                              is UploadFileLoading,
                          onTap: () => context
                              .read<UploadFileCubit>()
                              .selectAndUploadFile(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UploadFileCubit, UploadFileState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: "Edit Task",
                        onTap: () async {
                          if (_formKey.currentState?.validate() == true) {
                            if (selectedDate == null) {
                              customToast(
                                  message: "Please select a date",
                                  bgColor: Colors.red);
                            } else {
                              if (state is UploadFileSuccess) {
                                final taskRequest = AddTaskRequestModel(
                                  title: _nameController.text.trim(),
                                  tarif: _tarifController.text.trim(),
                                  date: selectedDate!.toIso8601String(),
                                  userIds: widget.model.userIds,
                                  fileUrl: state.url,
                                  id: widget.model.id,
                                  finishedCount: widget.model.finishedCount,
                                  fileType: state.fileType,
                                  completedStudents: widget.model.completedStudents
                                );

                                // Edit task using TaskCubit
                                context
                                    .read<TaskCubit>()
                                    .editTask(widget.model.id, taskRequest);
                              } else {
                                customToast(
                                  message: "Please waiting",
                                  bgColor: Colors.red,
                                );
                              }
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
