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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: CloseButton(),
          title: Text('Valida tu firma'),
          centerTitle: true,
          backgroundColor: Color(0xff731F3E),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () => setState(() {
                _isLoading = true;
              }),

              /*Center(
                child: CircularProgressIndicator(
                  color: Color(0xff731F3E),
                ),
              ), */
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Center(
                child: Image.memory(widget.signature),
              ),
      );
}
