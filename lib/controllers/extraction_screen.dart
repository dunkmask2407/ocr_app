import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ExtractionScreen extends StatelessWidget {
  final String text;

  const ExtractionScreen({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [ 
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Text(text),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: 'Share text',
                onPressed: () async {
                  await Share.share(text);
                }, 
                child: const Icon(Icons.share),
              ),
              const SizedBox(width: 20.0,),
              FloatingActionButton(
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: 'Copy text',
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: text));
                }, 
                child: const Icon(Icons.copy),
              ),
            ],
          ),
        ]
      ),
    );
  }
}