import 'package:flutter/material.dart';

class AudioLoadingMessage extends StatelessWidget {
  const AudioLoadingMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Icon(Icons.mic),
          ),
        ],
      ),
    );
  }
}
