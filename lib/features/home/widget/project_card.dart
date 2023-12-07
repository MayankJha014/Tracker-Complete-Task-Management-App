import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/model/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel projectdata;
  final String profilePic;
  bool projectColor;
  ProjectCard(
      {super.key,
      required this.profilePic,
      required this.projectColor,
      required this.projectdata});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
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
    if (widget.projectdata.stepper!.isEmpty) {
      return;
    }

    for (int i = 0; i < widget.projectdata.stepper!.length; i++) {
      if (widget.projectdata.stepper![i].status == 'Completed') {
        completedStat++;
        setState(() {});
      }
    }
    setState(() {
      percent = completedStat / widget.projectdata.stepper!.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.7,
      height: size.height * 0.175,
      decoration: BoxDecoration(
          color: widget.projectColor ? Pallet.darkButtonColor : Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.projectdata.projectName,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.projectdata.category,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(widget.profilePic),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Progress",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: widget.projectdata.stepper!.isEmpty
                                  ? Text("0/0",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12,
                                      ))
                                  : Text(
                                      "$completedStat / ${widget.projectdata.stepper!.length}",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      LinearPercentIndicator(
                        width: size.width * 0.35,
                        animation: true,
                        lineHeight: 6.0,
                        animationDuration: 2000,
                        curve: Curves.easeInOut,
                        percent: percent,
                        backgroundColor: Colors.blue[900],
                        barRadius: const Radius.circular(16),
                        progressColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 2,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white54,
                radius: 17,
                child: Text(
                  '+10',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
