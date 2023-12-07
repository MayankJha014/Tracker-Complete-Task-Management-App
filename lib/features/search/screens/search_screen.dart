import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/core/common/error_text.dart';
import 'package:tracker/core/common/loader.dart';
import 'package:tracker/features/auth/controller/auth_controller.dart';
import 'package:tracker/features/search/controller/search_controller.dart';

import 'package:tracker/model/user_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<UserModel>? userList;

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Add Friends",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: size.height * 0.9,
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            30,
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
                    height: 20,
                  ),
                  ref.watch(addFriendProvider(searchController.text)).when(
                        data: (value) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.length,
                              itemBuilder: (context, int index) {
                                final user = value[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundImage:
                                            NetworkImage(user.profilePic),
                                        // fit: BoxFit.fill,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            user.name,
                                            style: GoogleFonts.patuaOne(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                          Text(
                                            user.email,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () async {},
                                        child: const CircleAvatar(
                                          radius: 18,
                                          backgroundColor: Colors.black,
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.person_add_alt_1,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        error: (error, stack) =>
                            ErrorText(error: error.toString()),
                        loading: () => const Loader(),
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
        ),
      ],
    );
  }
}
