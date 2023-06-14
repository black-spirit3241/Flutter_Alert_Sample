import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const AlertApp());
}


class AlertApp extends StatelessWidget{
  const AlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Alert Demo'),),
        body:const PopupDialog(),
      ),
    );
  }

}

class PopupDialog extends StatelessWidget{
  const PopupDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed:(){ ShowBasicAlert(context);}, child:const Text('Basic Alert')),
            ElevatedButton(
              child:const Text('Basic Waiting Alert'),
              onPressed: () => _onBasicWaitingAlertPressed(context),
            ),
            ElevatedButton(
              child:const Text('Custom Animation Alert'),
              onPressed: () => _onCustomAnimationAlertPressed(context),
            ),
            ElevatedButton(
              child:const Text('Alert with Button'),
              onPressed: () => _onAlertButtonPressed(context),
            ),
            ElevatedButton(
              child:const Text('Alert with Buttons'),
              onPressed: () => _onAlertButtonsPressed(context),
            ),
            ElevatedButton(onPressed: () => _ShowSnackBar(context,ContentType.help,'I need Help!'), child: const Text('Show Help Snackbar')),
            ElevatedButton(onPressed: ()=> _ShowBanner(context), child: const Text('Show Banner')),
            ElevatedButton(onPressed: () => _ShowSnackBar(context,ContentType.failure,'Something Wrong'), child: const Text('Show Fail Snackbar')),
          ],
        ),
      ),
    ),
    );
  }
}


void ShowBasicAlert(BuildContext context){
  Alert(context:context,title:'Basic Alert',desc: 'Flutter is more awesome with RFlutter Alert.').show();
}

_onBasicWaitingAlertPressed(context) async {
  await Alert(
    context: context,
    title: "FLUTTER ALERT",
    desc: "Flutter is more awesome with RFlutter Alert.",
  ).show();

  // Code will continue after alert is closed.
  Fluttertoast.showToast(
      msg: "This is Center Short Toast",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

_onCustomAnimationAlertPressed(context) {
  Alert(
    context: context,
    title: "RFLUTTER ALERT",
    desc: "Flutter is more awesome with RFlutter Alert.",
    alertAnimation: fadeAlertAnimation,
  ).show();
}

Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    ) {
  return Align(
    child: FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}


// Alert with single button.
_onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: "RFLUTTER ALERT",
    desc: "Flutter is more awesome with RFlutter Alert.",
    buttons: [
      DialogButton(
        child:const Text(
          "COOL",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => _onCustomAnimationAlertPressed(context),
        width: 120,
      )
    ],
  ).show();
}

// Alert with multiple and custom buttons
_onAlertButtonsPressed(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "RFLUTTER ALERT",
    desc: "Flutter is more awesome with RFlutter Alert.",
    buttons: [
      DialogButton(
        child: Text(
          "FLAT",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "GRADIENT",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0),
        ]),
      )
    ],
  ).show();
}

_ShowSnackBar(context,contentType,message){
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Oh Shit!',
      message:message,
      contentType: contentType,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

_ShowBanner(context){
  final materialBanner = MaterialBanner(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    backgroundColor: Colors.transparent,
    forceActionsBelow: true,
    content: AwesomeSnackbarContent(
      title: 'Oh Hey!!',
      message:
      'This is an example error message that will be shown in the body of materialBanner!',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
      // to configure for material banner
      inMaterialBanner: true,
    ),
    actions: const [SizedBox.shrink()],
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(materialBanner);
}



