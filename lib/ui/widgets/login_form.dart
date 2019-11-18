import 'package:flutter/material.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/ui/views/base_view.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _pwFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _currentUser = {'email': '', 'password': ''};

  @override
  void dispose() {
    _pwFocusNode.dispose();
    super.dispose();
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    } else if (!validator.email(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 8) {
      return 'Please enter at least 8 characters';
    }
    return null;
  }

  void _focusOnPwordField(_) {
    FocusScope.of(context).requestFocus(_pwFocusNode);
  }

  void _submitForm(AuthModel model) async {
    final isValid = _form.currentState.validate();

    if (!isValid) return;

    _form.currentState.save();

    final email = _currentUser['email'];
    final password = _currentUser['password'];

    print('email: $email\tpassword: $password');
    await model.loginEmailPassword(email, password);
  }

  void _saveEmail(String email) {
    _currentUser['email'] = email;
  }

  void _savePassword(String password) {
    _currentUser['password'] = password;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<AuthModel>(
      builder: (ctx, model, child) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: _focusOnPwordField,
                autocorrect: false,
                validator: _validateEmail,
                onSaved: _saveEmail,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                textInputAction: TextInputAction.done,
                focusNode: _pwFocusNode,
                autocorrect: false,
                obscureText: true,
                validator: _validatePassword,
                onSaved: _savePassword,
                onFieldSubmitted: (_) {
                  _submitForm(model);
                },
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  textColor: theme.textTheme.button.color,
                  color: theme.primaryColor,
                  child: model.state == ViewState.Idle
                      ? Text(
                          'Log In',
                          style: TextStyle(fontSize: 16),
                        )
                      : Container(
                          height: 18,
                          width: 18,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          )),
                  onPressed: () {
                    _submitForm(model);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
