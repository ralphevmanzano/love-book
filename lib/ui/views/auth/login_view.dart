import 'package:flutter/material.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/widgets/auth/login_form.dart';

class LoginView extends StatelessWidget {
  
  Widget _buildHeader(ThemeData theme) {
    return Container(
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Welcome back to\n',
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
    );
  }

  Widget _buildSignUpText(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Don\'t have an account? ',
          style: theme.textTheme.subtitle,
        ),
        InkWell(
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 14,
              decoration: TextDecoration.underline,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onTap: () {
            Routes.sailor(Routes.SIGNUP_VIEW);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 32),
              _buildHeader(theme),
              SizedBox(height: 48),
              LoginForm(),
              SizedBox(height: 16),
              _buildSignUpText(context, theme),
            ],
          ),
        ),
      ),
    );
  }
}
