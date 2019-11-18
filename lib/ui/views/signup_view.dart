import 'package:flutter/material.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/widgets/signup_form.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Start sharing moments privately, with\n',
                      style: theme.textTheme.title,
                    ),
                    TextSpan(
                      text: 'Lovebook',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 48),
            SignupForm(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account? ',
                  style: theme.textTheme.subtitle,
                ),
                InkWell(
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onTap: () {
                    Routes.sailor.pop();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
