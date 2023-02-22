import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intexgram/Presentation/Routes/router.gr.dart';
import 'package:intexgram/Presentation/Screens/list_of_users/bloc/list_of_users_bloc.dart';
import 'package:intexgram/Presentation/theme/palette.dart';
import 'package:intexgram/Presentation/theme/text_styles.dart';
import 'package:intexgram/locator_service.dart';

import 'bloc/list_of_users_state.dart';

class ListOfUsers extends StatefulWidget {
  final String appBarLabel;
  final String docId;
  const ListOfUsers({
    super.key,
    required this.docId,
    required this.appBarLabel,
  });

  @override
  State<ListOfUsers> createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  late final ListOfUsersBloc bloc;
  @override
  void initState() {
    bloc = ListOfUsersBloc(
      serverLocator(),
      serverLocator(),
      widget.docId,
      widget.appBarLabel,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<ListOfUsersBloc, ListOfUsersState>(
        builder: (context, state) {
          return state.when(
            initial: (docId, label) {
              return content(state);
            },
            loaded: (docId, label, users) => content(state),
          );
        },
      ),
    );
  }

  Widget content(ListOfUsersState state) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Palette.appBarColor,
        leading: IconButton(
          onPressed: () {
            serverLocator<FlutterRouter>().pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
            color: Palette.appBarIconColor,
          ),
        ),
        title: Text(
          state.label,
          style: TextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: state is Loaded
          ? state.users.isNotEmpty
              ? Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            serverLocator<FlutterRouter>().push(
                              ProfilePageRoute(
                                userEmail: state.users[index].email,
                              ),
                            );
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 25,
                                  right: 25,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        state.users[index].profilePicturePath,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.users[index].nickName,
                                          style: TextStyles.text,
                                        ),
                                        Text(
                                          state.users[index].userName,
                                          style: TextStyles.text.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                )
              : Center(
                  child: Text(
                    "No ${state.label} found",
                    style: TextStyles.text.copyWith(fontSize: 40),
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
