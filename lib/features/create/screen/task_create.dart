import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/core/contants/utils.dart';
import 'package:tracker/features/create/controller/task_controller.dart';

class TaskCreate extends ConsumerStatefulWidget {
  const TaskCreate({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskCreateState();
}

class _TaskCreateState extends ConsumerState<TaskCreate> {
  final TextEditingController projectNameEditing = TextEditingController();
  final TextEditingController categoryEditing = TextEditingController();
  final TextEditingController dateEditing = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    projectNameEditing.dispose();
    dateEditing.dispose();
  }

  String repeat = 'Custom';
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  void initState() {
    dateEditing.text = "Choose starting date";
    super.initState();
  }

  void createTask() {
    if (projectNameEditing.text.isEmpty) {
      return showSnackBar(
        context,
        "Please fill Task Name",
      );
    }
    if (dateEditing.text == "Choose starting date") {
      return showSnackBar(
        context,
        "Please fill Date",
      );
    }
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int endTimeInt = (endTime.hour * 60 + endTime.minute) * 60;
    if (startTimeInt > endTimeInt) {
      return showSnackBar(
        context,
        "Please choose Time correctly",
      );
    }

    ref.read(taskControllerProvider.notifier).addTask(
          context,
          projectNameEditing.text,
          dateEditing.text,
          startTime.toString(),
          endTime.toString(),
          repeat,
        );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Task",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.9,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Name",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xff848A94),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: projectNameEditing,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          15,
                        ),
                      ),
                    ),
                    hintText: 'Task Name',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Date",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xff848A94),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateEditing.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
                child: Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallet.greyColor,
                    ),
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: Text(
                    dateEditing.text,
                    style: dateEditing.text == "Choose starting date"
                        ? GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Pallet.greyColor,
                            fontSize: 15,
                          )
                        : GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start Time",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xff848A94),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: startTime,
                            initialEntryMode: TimePickerEntryMode.dialOnly,
                          );
                          if (timeOfDay != null) {
                            print(timeOfDay);
                            setState(() {
                              startTime = timeOfDay;
                              print(startTime);
                            });
                          }
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white38,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      startTime.format(context),
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.white54,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Time",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xff848A94),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: endTime,
                            initialEntryMode: TimePickerEntryMode.dialOnly,
                          );
                          if (timeOfDay != null) {
                            print(timeOfDay);
                            setState(() {
                              endTime = timeOfDay;
                              print(startTime);
                            });
                          }
                        },
                        child: Container(
                          width: 150,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white38,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      endTime.format(context),
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.white54,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Repeat",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xff848A94),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          repeat = 'Custom';
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: repeat == 'Custom'
                                ? Pallet.darkButtonColor
                                : Colors.white38,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Custom",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          repeat = 'Daily';
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: repeat == 'Daily'
                                ? Pallet.darkButtonColor
                                : Colors.white38,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Daily",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () => createTask(),
                  child: Container(
                    width: size.width * 0.75,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Pallet.darkButtonColor,
                    ),
                    child: Center(
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
