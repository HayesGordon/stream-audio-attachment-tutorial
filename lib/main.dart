import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_list_page.dart';
import 'config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final client = StreamChatClient(streamKey);

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          child: widget!,
          client: client,
        );
      },
      debugShowCheckedModeBanner: false,
      home: const SelectUserPage(),
    );
  }
}

class SelectUserPage extends StatelessWidget {
  const SelectUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Select a user',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SelectUserButton(user: userGordon),
              SelectUserButton(user: userSalvatore),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectUserButton extends StatelessWidget {
  const SelectUserButton({
    Key? key,
    required this.user,
  }) : super(key: key);

  final DemoUser user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final client = StreamChat.of(context).client;
        await client.connectUser(
          User(
            id: user.id,
            extraData: {
              'name': user.name,
              'image': user.image,
            },
          ),
          client.devToken(user.id).rawValue,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ChannelListPage()),
        );
      },
      child: Text(user.name),
    );
  }
}
