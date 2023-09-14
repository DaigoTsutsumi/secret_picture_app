import 'package:flutter/material.dart';

class TermsFile extends StatefulWidget {
  const TermsFile({Key? key}) : super(key: key);

  @override
  State<TermsFile> createState() => _TermsFileState();
}

class _TermsFileState extends State<TermsFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('規約'),
      ),
    );
  }
}
