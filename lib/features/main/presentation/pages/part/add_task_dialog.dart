import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/di.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/custom_toast.dart';
import 'package:stu_teach/features/common/widget/text_field_widget.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tarifController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _tarifController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String fileUrl  = '';
  String fileType  = '';

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: BlocConsumer<UploadFileCubit, UploadFileState>(
        listener: (context, fileState) {
          if (fileState is UploadFileSuccess) {
            fileUrl = fileState.url;
            fileType = fileState.fileType;
            debugPrint('File uploaded successfully: ${fileState.url}');
          } else if (fileState is UploadFileFailure) {
            debugPrint('Upload failed: ${fileState.failure}');
          }
        },
        builder: (context, fileState) {
          final fileBloc = BlocProvider.of<UploadFileCubit>(context);
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20).copyWith(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Add Task",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the task name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: "Enter tarif",
                      textEditingController: _tarifController,
                      textInputType: TextInputType.text,
                      label: "Tarif",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the tarif';
                        }
                        return null;
                      },
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
                            text: fileState is UploadFileSuccess
                                ? "File Uploaded"
                                : "Upload File",
                            isLoading: fileState is UploadFileLoading,
                            onTap: () => fileBloc.selectAndUploadFile(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Add Task",
                      onTap: () async {
                        if (_formKey.currentState?.validate() == true) {
                          if (selectedDate == null) {
                            customToast(
                              message: "Please select a date",
                              bgColor: Colors.red,
                            );
                          } else {
                            if (fileState is UploadFileInitial) {
                              await fileBloc.selectAndUploadFile();
                            }

                            // Create an instance of AddTaskRequestModel
                            final taskRequest = AddTaskRequestModel(
                              title: _nameController.text.trim(),
                              tarif: _tarifController.text.trim(),
                              date: selectedDate!.toIso8601String(),
                              userIds: [],
                              fileUrl: fileUrl,
                              id: '',
                              finishedCount: 0, fileType: fileType,
                            );

                            // Access TaskCubit
                            final taskCubit = BlocProvider.of<TaskCubit>(context);

                            // Add task using TaskCubit
                            await taskCubit.addTask(taskRequest);

                            // Listen to the state and show a success or failure message
                            taskCubit.stream.listen((state) async {
                              if (state is TaskAdded) {
                                fileBloc.reset();
                                await taskCubit.fetchAllTasks();

                                customToast(
                                  message: "Task added successfully",
                                  bgColor: AppColors.primaryColor,
                                );

                                Navigator.of(context).pop(); // Close the dialog
                              } else if (state is TaskError) {
                                customToast(
                                  message: "Failed to add task: ${state.failure}",
                                  bgColor: Colors.red,
                                );
                              }
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
