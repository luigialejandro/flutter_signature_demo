import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:flutter_signature_demo/main.dart';

class SignaturePreviewPage extends StatefulWidget {
  final dynamic signature;

  const SignaturePreviewPage({
    Key? key,
    @required this.signature,
  }) : super(key: key);

  @override
  State<SignaturePreviewPage> createState() => _SignaturePreviewPageState();
}

class _SignaturePreviewPageState extends State<SignaturePreviewPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: CloseButton(),
          title: Text('Storage Signature'),
          centerTitle: true,
        ),
        body: Center(
          child: Image.memory(widget.signature),
        ),
      );
}
