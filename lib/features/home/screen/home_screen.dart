import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tracker/core/common/error_text.dart';
import 'package:tracker/core/common/loader.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/features/create/controller/task_controller.dart';
import 'package:tracker/features/home/widget/project_card.dart';
import 'package:tracker/features/home/widget/task_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider)!;
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: const Icon(
              Icons.dark_mode_outlined,
            ),
            actions: const [Icon(Icons.notifications_none)],
            title: Text(
              '${DateFormat('MMMM').format(DateTime.now())},${DateTime.now().day}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      'Let’s make a habits together 🙌',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ref.watch(getProjectProvider(user.uid)).when(
                          data: (value) {
                            return SizedBox(
                              // width: size.width * 0.7,
                              height: size.height * 0.175,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: value.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return user.uid == value[index].adminId
                                      ? ProjectCard(
                                          profilePic: user.profilePic,
                                          projectColor: true,
                                          projectdata: value[index],
                                        )
                                      : ProjectCard(
                                          profilePic: user.profilePic,
                                          projectColor: false,
                                          projectdata: value[index],
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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'In Progress',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ref.watch(getTaskProvider(user.uid)).when(
                        data: (value) {
                          return SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return TaskCard(
                                  task: value[index],
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
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
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
