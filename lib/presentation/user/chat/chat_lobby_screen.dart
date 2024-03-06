import 'package:co_pet/presentation/user/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatLobbyScreen extends StatefulWidget {
  const ChatLobbyScreen({super.key});

  @override
  State<ChatLobbyScreen> createState() => _ChatLobbyScreenState();
}

class _ChatLobbyScreenState extends State<ChatLobbyScreen> {
  bool loading = true;

  Widget chatCard(types.Room room) {
    debugPrint("room firstname ${room.users[0].firstName}");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(room: room),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: Color.fromARGB(255, 187, 187, 187), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CircleAvatar(
                radius: 20.sp,
                child: const Icon(Icons.person),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    room.name.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make Konsultation"),
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<types.Room>>(
        stream: FirebaseChatCore.instance.rooms(),
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            loading = false;
            return const SpinKitWave(
              color: Color.fromARGB(255, 0, 162, 255),
              size: 50,
            );
          } else if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final room = snapshot.data![index];
                debugPrint("roem ${room.users[0].firstName}");
                return chatCard(room);
              },
            );
          }

          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              bottom: 200,
            ),
            child: const Text('No Chats'),
          );
        },
      ),
    );
  }
}
