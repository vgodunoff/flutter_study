import 'package:flutter/material.dart';

/*
https://stacksecrets.com/flutter/flutter-textfield-decoration-in-depth

There are different types of border properties that we can use to decorate the 
border of a TextField in Flutter. 
    Namely:

enabledBorder:
Decoration when text field is not in focus but is enabled

disabledBorder:
Decoration when text field is disabled

errorBorder:
Decoration to show during error

focusedBorder:
Decoration when text field is in focus

focusedErrorBorder:
Decoration when focused text field has error

border:
Decoration based on the app’s ThemeData
Changing the decoration color via the border property of Textfield has no effect

*/
class ExTextFieldBorder extends StatelessWidget {
  const ExTextFieldBorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(1.0),
                ),
                hintText: "Enabled decoration text ...",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Focus decoration text ...",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Disabled decoration text ...",
              ),
              enabled: false,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 4.0,
                      color: Colors.brown,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Error decoration text ...",
                  errorText: "Ooops, something is not right!",
                  errorStyle: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Border decoration text ...",
              ),
            )
          ],
        ),
      ),
    );
  }
}
