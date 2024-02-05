import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const title = 'Receive Sharing Intent Web Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedMediaFile? _media;

  @override
  void initState() {
    super.initState();
    ReceiveSharingIntent.getInitialMedia().then(_setMediaText);
    ReceiveSharingIntent.getMediaStream().listen(_setMediaText);
  }

  void _setMediaText(List<SharedMediaFile> medias) {
    final media = medias.firstOrNull;
    if (!mounted || media == null) return;
    setState(() => _media = media);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Text: ${_media?.path}'),
            Text('Type: ${_media?.type.value}'),
            Text('Mime: ${_media?.mimeType}'),
            const SizedBox(height: 32),
            Form(
                child: TextFormField(
                  initialValue: 'https://google.com',
                  onSaved: (v) => Share.share(v ?? ''),
                  decoration: InputDecoration(
                    suffixIcon: Builder(builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () => Form.of(context).save(),
                      );
                    }),
                  ),
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
