import 'package:audio_attachment_tutorial/config.dart';
import 'package:audio_attachment_tutorial/main.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_page.dart';

class ChannelListPage extends StatelessWidget {
  const ChannelListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Chat'),
        actions: [
          GestureDetector(
            onTap: () async {
              await StreamChat.of(context).client.disconnectUser();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SelectUserPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text('Switch user'),
              ),
            ),
          )
        ],
      ),
      body: ChannelsBloc(
        child: ChannelListView(
          emptyBuilder: (conext) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  final channel = StreamChat.of(context).client.channel(
                    "messaging",
                    id: "test-gordon",
                    extraData: {
                      "name": "Flutter Chat",
                      "image":
                          "https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png",
                      "members": [userGordon.id, userSalvatore.id]
                    },
                  );
                  await channel.create();
                },
                child: const Text('Create channel'),
              ),
            );
          },
          filter:
              Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
          sort: const [SortOption('last_message_at')],
          pagination: const PaginationParams(limit: 30),
          channelWidget: const ChannelPage(),
        ),
      ),
    );
  }
}
