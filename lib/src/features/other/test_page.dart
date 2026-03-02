import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  Future<String> _loadMarkdown(BuildContext context) async {
    final locale = Localizations.localeOf(context);
    final path = 'assets/docs/test_${locale.languageCode}.md';
    return rootBundle.loadString(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: FutureBuilder<String>(
        future: _loadMarkdown(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Markdown(data: snapshot.data!);
        },
      ),
    );
  }
}