import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/core/contants/utils.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/features/create/controller/task_controller.dart';
import 'package:tracker/features/search/screens/search_screen.dart';

class ProjectCreation extends ConsumerStatefulWidget {
  const ProjectCreation({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProjectCreationState();
}

class _ProjectCreationState extends ConsumerState<ProjectCreation> {
  final TextEditingController projectNameEditing = TextEditingController();
  final TextEditingController startdateEditing = TextEditingController();
  final TextEditingController enddateEditing = TextEditingController();
  final TextEditingController categoryEditing = TextEditingController();

  String board = 'Urgent';
  List<String> team = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    projectNameEditing.dispose();
    categoryEditing.dispose();
    startdateEditing.dispose();
    enddateEditing.dispose();
  }

  @override
  void initState() {
    startdateEditing.text = "Choose starting date";
    enddateEditing.text = "Choose starting date";
    super.initState();
  }

  void handleSubmit() {
    if (startdateEditing.text.isEmpty) {
      return showSnackBar(
        context,
        "Please fill Start Date",
      );
    }
    if (enddateEditing.text.isEmpty) {
      return showSnackBar(
        context,
        "Please fill End Date",
      );
    }
    if (projectNameEditing.text.isEmpty) {
      return showSnackBar(
        context,
        "Please fill Project Name",
      );
    }
    if (categoryEditing.text.isEmpty) {
      return showSnackBar(
        context,
        "Please fill Category",
      );
    }
    print(startdateEditing.text.compareTo(enddateEditing.text));
    if ((startdateEditing.text.compareTo(enddateEditing.text)) > 0) {
      return showSnackBar(
        context,
        "Please choose correct start & end date",
      );
    }
    ref.read(taskControllerProvider.notifier).createProject(
          context,
          projectNameEditing.text,
          categoryEditing.text,
          team,
          startdateEditing.text,
          enddateEditing.text,
          board,
        );
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.read(userProvider)!;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Project",
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
                "Project Name",
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
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                  hintText: 'Project Name',
                  hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Category",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xff848A94),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: categoryEditing,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                  hintText: 'Category',
                  hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Team Member",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xff848A94),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            team.add(user.uid);
                          });
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user.profilePic,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Mayank",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xff848A94),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const SearchScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "Start Date",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xff848A94),
                            ),
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
                                startdateEditing.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                          child: Container(
                            width: size.width * 0.45,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Pallet.greyColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    startdateEditing.text,
                                    maxLines: 1,
                                    style: startdateEditing.text ==
                                            "Choose starting date"
                                        ? GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            color: Pallet.greyColor,
                                            fontSize: 15,
                                          )
                                        : GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                          ),
                                  ),
                                ),
                                const Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "End Date",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xff848A94),
                            ),
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
                                enddateEditing.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                          child: Container(
                            width: size.width * 0.45,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Pallet.greyColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    enddateEditing.text,
                                    maxLines: 1,
                                    style: enddateEditing.text ==
                                            "Choose starting date"
                                        ? GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            color: Pallet.greyColor,
                                            fontSize: 15,
                                          )
                                        : GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                          ),
                                  ),
                                ),
                                const Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Board",
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
                          board = 'Urgent';
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: board == 'Urgent'
                                ? Pallet.darkButtonColor
                                : Colors.white38,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Urgent",
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
                          board = 'Ongoing';
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: board == 'Ongoing'
                                ? Pallet.darkButtonColor
                                : Colors.white38,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Ongoing",
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
                  onTap: handleSubmit,
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
