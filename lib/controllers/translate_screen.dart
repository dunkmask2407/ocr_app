import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class TranslateScreen extends StatelessWidget {
    final String text;
    final String originalText;

  const TranslateScreen({super.key, required this.originalText, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: TextEditingController(text: originalText),
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Original Text',
                ),
              ),
              const SizedBox(height: 30.0,),
              TextField(
                controller: TextEditingController(text: text),
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Translated Text',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: 'Share translated text',
                onPressed: () async {
                  await Share.share(text);
                }, 
                child: const Icon(Icons.share),
              ),
              const SizedBox(width: 10.0,),
              FloatingActionButton(
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: 'Copy translated text',
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: text));
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Text copied to clipboard.'),
                    ),
                  );
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