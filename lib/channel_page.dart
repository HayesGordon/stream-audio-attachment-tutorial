import 'dart:io';

import 'package:audio_attachment_tutorial/audio_loading_message.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'audio_player_message.dart';
import 'record_button.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  void _recordingFinishedCallback(String path) {
    final uri = Uri.parse(path);
    File file = File(uri.path);
    file.length().then(
      (fileSize) {
        StreamChannel.of(context).channel.sendMessage(
              Message(
                attachments: [
                  Attachment(
                    type: 'voicenote',
                    file: AttachmentFile(
                      size: fileSize,
                      path: uri.path,
                    ),
                  )
                ],
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              messageBuilder: (context, details, messages, defaultMessage) {
                return defaultMessage.copyWith(
                  customAttachmentBuilders: {
                    'voicenote': (context, defaultMessage, attachments) {
                      final url = attachments.first.assetUrl;
                      if (url == null) {
                        return const AudioLoadingMessage();
                      }
                      return AudioPlayerMessage(
                        source: AudioSource.uri(Uri.parse(url)),
                        id: defaultMessage.id,
                      );
                    }
                  },
                );
              },
            ),
          ),
          MessageInput(
            actions: [
              RecordButton(
                recordingFinishedCallback: _recordingFinishedCallback,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
