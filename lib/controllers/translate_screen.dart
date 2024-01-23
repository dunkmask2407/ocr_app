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
        title: const Text('Translated Text',),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true ,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Share.share(text);
            }, 
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: text));
              // ignore: use_build_context_synchronously
              /* ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Text copied to clipboard.'),
                ),
              ); */
            }, 
            icon: const Icon(Icons.copy),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50.0,),
                  TextField(
                    scrollPhysics: const BouncingScrollPhysics(),
                    maxLines: 10,
                    controller: TextEditingController(text: originalText),
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Original Text',
                    ),
                  ),
                  const SizedBox(height: 50.0,),
                  TextField(
                    scrollPhysics: const BouncingScrollPhysics(),
                    maxLines: 10,
                    controller: TextEditingController(text: text),
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Translated Text',
                    ),
                  ),
                ],
              ),
            ),
          ),
          /* Row(
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
          ), */
        ]
      ),
    );
  }
}