import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/presentation/pages/message_page/bloc/chatlist_bloc.dart';
import 'package:freelance/presentation/pages/message_page/chat/personal_chat.dart';
import 'package:intl/intl.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatListBloc>().add(GetChatList());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Messsages'),
        ),
        body: BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
            if (state is ChatListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatListed) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.user.length,
                  itemBuilder: (context, index) {
                    DateTime timestamp = (state.time[index]).toDate();
                    String formattedTime =
                        DateFormat('h:mm a').format(timestamp);
                    final user = state.user[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: user.profilePhoto != null
                              ? NetworkImage(user.profilePhoto!)
                              : const AssetImage("assets/images/profilenew.jpg")
                                  as ImageProvider,
                        ),
                        title: Text(user.firstName),
                        subtitle: Text(" $formattedTime "),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    recieverId: state.user[index].id,
                                    recieverEmail: state.user[index].firstName,
                                    user: state.user[index],
                                  )));
                        },
                      ),
                    );
                  },
                ),
              );
            } else if (state is ChatListError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('No Messages'));
          },
        ));
  }
}
