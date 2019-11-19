import 'package:flutter/material.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _pwController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _pwFocusNode = FocusNode();
  final _confirmPwFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _currentUser = {'name': '', 'email': '', 'password': ''};

  @override
  void initState() {
    _pwFocusNode.addListener(_updateCurrentPassword);
    super.initState();
  }

  @override
  void dispose() {
    _pwFocusNode.removeListener(_updateCurrentPassword);
    _pwFocusNode.dispose();
    _emailFocusNode.dispose();
    _confirmPwFocusNode.dispose();
    super.dispose();
  }

  void _updateCurrentPassword() {
    if (!_pwFocusNode.hasFocus) {
      _savePassword(_pwController.text);
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 3) {
      return 'Please enter your full name';
    }
    return null;
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

  String _validateConfirmPassword(String value) {
//    if (_confirmPwFocusNode.hasFocus) {
    if (value.isEmpty) {
      return 'This field is required';
    } else if (value != _pwController.text) {
      return 'Passwords do not match!';
    }
//    }
    return null;
  }

  void _saveName(String name) {
    _currentUser['name'] = name;
  }

  void _saveEmail(String email) {
    _currentUser['email'] = email;
  }

  void _savePassword(String password) {
    _currentUser['password'] = password;
  }

  void _submitForm(AuthModel model) async {
    final isValid = _form.currentState.validate();

    if (!isValid) return;

    _form.currentState.save();

    print(
        'name: ${_currentUser['name']}\temail: ${_currentUser['email']}\tpw: ${_currentUser['password']}');
    await model.register(
        _currentUser['name'], _currentUser['email'], _currentUser['password']);
    Routes.sailor.pop();
  }

  void _focusOnNode(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Form(
        key: _form,
        child: Consumer<AuthModel>(
          builder: (ctx, model, child) => Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  _focusOnNode(_emailFocusNode);
                },
                autocorrect: false,
                validator: _validateName,
                onSaved: _saveName,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (_) {
                  _focusOnNode(_pwFocusNode);
                },
                autocorrect: false,
                validator: _validateEmail,
                onSaved: _saveEmail,
              ),
              TextFormField(
                controller: _pwController,
                decoration: InputDecoration(labelText: 'Password'),
                textInputAction: TextInputAction.next,
                focusNode: _pwFocusNode,
                obscureText: true,
                onFieldSubmitted: (_) {
                  _focusOnNode(_confirmPwFocusNode);
                },
                autocorrect: false,
                validator: _validatePassword,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                textInputAction: TextInputAction.done,
                focusNode: _confirmPwFocusNode,
                autovalidate: true,
                obscureText: true,
                onFieldSubmitted: (_) {
                  _submitForm(model);
                },
                autocorrect: false,
                validator: _validateConfirmPassword,
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
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        )
                      : Container(
                          height: 18,
                          width: 18,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 2,
                          )),
                  onPressed: () {
                    _submitForm(model);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
