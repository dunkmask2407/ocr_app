import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class TranslateScreen extends StatelessWidget {
    final String text;
    final String originalText;
    // ignore: prefer_typing_uninitialized_variables
    final sourceLang;
    // ignore: prefer_typing_uninitialized_variables
    final targetLang;

  const TranslateScreen({super.key, required this.originalText, required this.text, required this.sourceLang, required this.targetLang,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translated Text',),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true ,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          }, 
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await Share.share(text);
            }, 
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: text));
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Text copied to clipboard.'),
                ),
              );
            }, 
          ),],
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
                    scrollController: ScrollController(),
                    // scrollPhysics: const BouncingScrollPhysics(),
                    maxLines: 10,
                    controller: TextEditingController(text: originalText),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Original in ${sourceLang.toUpperCase()}',
                    ),
                  ),
                  const SizedBox(height: 50.0,),
                  TextField(
                    scrollController: ScrollController(),
                    // scrollPhysics: const BouncingScrollPhysics(),
                    maxLines: 10,
                    controller: TextEditingController(text: text),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Translated in ${targetLang.toUpperCase()}',
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