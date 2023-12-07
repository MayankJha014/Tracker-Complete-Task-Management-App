import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/core/common/error_text.dart';
import 'package:tracker/core/common/loader.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/features/create/controller/task_controller.dart';
import 'package:tracker/features/project/widget/project_chips.dart';
import 'package:tracker/features/project/widget/task_chips.dart';

class ProjectScreen extends ConsumerStatefulWidget {
  const ProjectScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends ConsumerState<ProjectScreen> {
  int activeChips = 0;

  List chips = [
    'Recent',
    'Completed',
    'All',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = ref.read(userProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: AppBar(
                  centerTitle: true,
                  title: Text(
                    "Projects",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.add,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Center(
                child: SizedBox(
                  width: size.width * 0.9,
                  height: 50,
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      labelText: "Search",
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ListView.builder(
                  itemCount: chips.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          activeChips = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 5.0,
                          top: 25,
                          left: 5,
                          bottom: 10,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white24,
                          ),
                          child: Text(
                            chips[index],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: activeChips == index
                                  ? Colors.white
                                  : Pallet.greyColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ref.watch(getProjectProvider(user!.uid)).when(
                    data: (value) {
                      return SizedBox(
                        width: size.width * 0.88,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return activeChips == 1
                                ? value[index].status == "Completed"
                                    ? ProjectChips(
                                        project: value[index],
                                        profilePic: user.profilePic,
                                        projectColor: true,
                                      )
                                    : const SizedBox()
                                : ProjectChips(
                                    project: value[index],
                                    profilePic: user.profilePic,
                                    projectColor: true,
                                  );
                          },
                        ),
                      );
                    },
                    error: (error, stack) {
                      print(error);
                      return ErrorText(
                        error: error.toString(),
                      );
                    },
                    loading: () => const Loader(),
                  ),
            ],
          ),
        ),
        Positioned(
          top: 80,
          right: 40,
          child: Image.asset(
            'assets/auth/Ellipse.png',
            scale: 2.0,
          ),
        )
      ],
    );
  }
}
