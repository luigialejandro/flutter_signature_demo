import 'package:flutter/material.dart';
import 'package:flutter_signature_demo/signature_preview_page.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SignatureController controller = SignatureController();

  @override
  void initState() {
    super.initState();

    controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Firmado de solicitud Demo'),
        centerTitle: true,
        backgroundColor: Color(0xff731F3E),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: Text(
                'Realiza tu firma lo más parecido a la firma de la identificación dentro del recuadro y pulsa el botón Aceptar.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.45,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Signature(
              controller: controller,
              backgroundColor: Colors.white,
            ),
          ),
          Spacer(),
          buildButtons(context),
          SizedBox(
            height: 15,
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildButtons(BuildContext context) => Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
                title: 'Limpiar',
                icon: Icons.clear,
                color: Color(0xff833F4C),
                onClicked: () => controller.clear()),
            buildButton(
                title: 'Aceptar',
                icon: Icons.check,
                color: Color(0xffD9BCA3),
                onClicked: () async {
                  if (controller.isNotEmpty) {
                    final signature = await exportSignature();

                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SignaturePreviewPage(signature: signature),
                    ));

                    controller.clear();
                  }
                }),
          ],
        ),
      );

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
    required Color color,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            onPrimary: Colors.white,
            textStyle: TextStyle(fontSize: 20)),
        child: Row(
          children: [
            Text(title),
            const SizedBox(width: 10),
            Icon(icon, size: 24),
          ],
        ),
        onPressed: onClicked,
      );

  /*IconButton(
        iconSize: 36,
        icon: Icon(Icons.check, color: Colors.green),
        onPressed: () async {
          if (controller.isNotEmpty) {
            final signature = await exportSignature();

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SignaturePreviewPage(signature: signature),
            ));

            controller.clear();
          }
        },
      );
      */

/*
  Widget buildClear() => IconButton(
        iconSize: 36,
        icon: Icon(Icons.clear, color: Colors.red),
        onPressed: () => controller.clear(),
      );
*/

  Future<dynamic> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    return signature;
  }
}
