import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/core/contants/constants.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var user = ref.read(userProvider)!;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Chat",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            actions: const [
              Icon(
                Icons.add,
              )
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 30,
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
              const SizedBox(
                height: 30,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Pallet.greyColor,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              user.profilePic,
                            ),
                            radius: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Active',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.camera_alt_rounded,
                            size: 25,
                            color: Pallet.greyColor,
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
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
