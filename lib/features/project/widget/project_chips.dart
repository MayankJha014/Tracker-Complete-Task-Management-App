import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tracker/model/project_model.dart';

class ProjectChips extends StatefulWidget {
  final String profilePic;
  final ProjectModel project;
  bool projectColor;
  ProjectChips({
    super.key,
    required this.profilePic,
    required this.projectColor,
    required this.project,
  });

  @override
  State<ProjectChips> createState() => _ProjectChipsState();
}

class _ProjectChipsState extends State<ProjectChips> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int completedStat = 0;
  double percent = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countData();
  }

  void countData() {
    if (widget.project.stepper!.isEmpty) {
      return;
    }

    for (int i = 0; i < widget.project.stepper!.length; i++) {
      if (widget.project.stepper![i].status == 'Completed') {
        completedStat++;
        setState(() {});
      }
    }
    setState(() {
      percent = completedStat / widget.project.stepper!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.88,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: const Color.fromARGB(255, 7, 39, 88),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.project.projectName,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(
                        color: const Color(0xffB0D97F),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$completedStat/${widget.project.stepper!.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                widget.project.category,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundImage: NetworkImage(
                      widget.profilePic,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  LinearPercentIndicator(
                    width: size.width * 0.6,
                    animation: true,
                    lineHeight: 7.0,
                    animationDuration: 2000,
                    curve: Curves.easeInOut,
                    percent: percent,
                    backgroundColor: const Color(0xff212719),
                    barRadius: const Radius.circular(16),
                    progressColor: const Color(0xffB0D97F),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 6,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white54,
              radius: 15,
              child: Text(
                '+${widget.project.team!.length}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
