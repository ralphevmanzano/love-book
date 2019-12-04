import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:love_book/core/models/user.dart';
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
  DateTime _selectedDate = DateTime.now();

  final _pwController = TextEditingController();
  final _bdayController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _bdayFocusNode = FocusNode();
  final _pwFocusNode = FocusNode();
  final _confirmPwFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  User _currentUser = User();
  String _currentPassword = '';

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
    _bdayFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1901, 1),
      lastDate: _selectedDate,
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      _bdayController.text = Jiffy(picked).yMMMMd;
    }
  }

  void _updateCurrentPassword() {
    if (!_pwFocusNode.hasFocus) {
      _savePassword(_pwController.text);
    }
  }

  String _validateName(String val) {
    String value = val.trim();
    if (value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 3) {
      return 'Please enter your full name';
    }
    return null;
  }

  String _validateEmail(String val) {
    String value = val.trim();
    print(value);
    if (value.isEmpty) {
      return 'This field is required';
    } else if (!validator.email(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String _validateBirthday(String val) {
    if (val.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String _validatePassword(String val) {
    String value = val.trim();
    if (value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 8) {
      return 'Please enter at least 8 characters';
    }
    return null;
  }

  String _validateConfirmPassword(String val) {
    String value = val.trim();
    if (value.isEmpty) {
      return 'This field is required';
    } else if (value != _pwController.text) {
      return 'Passwords do not match!';
    }
//    }
    return null;
  }

  void _saveName(String name) {
    _currentUser.name = name.trim();
  }

  void _saveEmail(String email) {
    _currentUser.email = email.trim();
  }

  void _saveBday(String bday) {
    _currentUser.birthday = Timestamp.fromDate(_selectedDate);
  }

  void _savePassword(String password) {
    _currentPassword = password;
  }

  void _submitForm(AuthModel model) async {
    final isValid = _form.currentState.validate();

    if (!isValid) return;

    _form.currentState.save();

    print('${_currentUser.toString()} \t password: $_currentPassword');
    await model.register(_currentUser, _currentPassword);
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
                  _focusOnNode(_bdayFocusNode);
                },
                autocorrect: false,
                validator: _validateEmail,
                onSaved: _saveEmail,
              ),
              TextFormField(
                controller: _bdayController,
                decoration: InputDecoration(labelText: 'Birthday'),
                textInputAction: TextInputAction.next,
                focusNode: _bdayFocusNode,
                onTap: () => _selectDate(context),
                onFieldSubmitted: (_) {
                  _focusOnNode(_pwFocusNode);
                },
                readOnly: true,
                validator: _validateBirthday,
                onSaved: _saveBday,
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
