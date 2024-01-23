import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ocr_app/controllers/translate_screen.dart';
import 'package:share_plus/share_plus.dart';

class ExtractionScreen extends StatelessWidget {
  final String text;

  const ExtractionScreen({super.key, required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracted Text'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
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
          ),],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [ 
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
                  scrollPhysics: const BouncingScrollPhysics(),
                  maxLines: 20,
                  controller: TextEditingController(text: text),
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Extracted Text',
                  ),
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* FloatingActionButton(
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: 'Share text',
                onPressed: () async {
                  await Share.share(text);
                }, 
                child: const Icon(Icons.share),
              ),
              const SizedBox(width: 10.0,), */
              FloatingActionButton(
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: 'Translate text',
                onPressed: () async {
                  // ignore: unnecessary_null_comparison
                  if (text == null) return;
                  _translateText(context, text);
                }, 
                child: const Icon(Icons.translate),
              ),
              /* const SizedBox(width: 10.0,),
              FloatingActionButton(
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                tooltip: 'Copy text',
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
              ), */
            ],
          ),
        ]
      ),
    );
  }

  static Future<void> _translateText(BuildContext context, String recognizedText) async {

    final navigator = Navigator.of(context);
    LanguageIdentifier? langIdentifier;

    try {
      final langIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
      final languageCode = await langIdentifier.identifyLanguage(recognizedText);
      // final List<IdentifiedLanguage> possibleLanguages = await langIdentifier.identifyPossibleLanguages(recognizedText);
      // langIdentifier.close();
      
      final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.values.firstWhere(
          (element) => element.bcpCode == languageCode
        ), 
        targetLanguage: TranslateLanguage.english
      );
      final translatedText = await translator.translateText(recognizedText);
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => TranslateScreen(originalText: recognizedText, text: translatedText,),
        ),
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occured when translating text.'),
        ),
      );
    } finally {
      // ignore: unnecessary_null_comparison
      if (langIdentifier != null) {
        langIdentifier.close();
      }
    }

  }
}