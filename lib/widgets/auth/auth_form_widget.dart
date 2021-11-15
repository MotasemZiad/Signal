import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signal_chat/shared/global_widgets.dart';
import 'package:signal_chat/utils/constants.dart';
import 'package:signal_chat/widgets/user_image_picker.dart';

class AuthFormWidget extends StatefulWidget {
  final void Function(
    String email,
    String? username,
    XFile? userImageFile,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitAuthForm;
  final bool isLoading;
  const AuthFormWidget({
    Key? key,
    required this.submitAuthForm,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String? _email;
  String? _username;
  String? _password;
  XFile? _userImageFile;

  void _pickImage(XFile? pickedImage) {
    _userImageFile = pickedImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      GlobalWidgets.globalWidgets.presentSnackBar(
        context: context,
        content: 'You should pick an image to sign up',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitAuthForm(
        _email!.trim(),
        _username,
        _userImageFile,
        _password!.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(pickImageFunction: _pickImage),
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                    cursorHeight: cursorHeight,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _email = newValue;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text('Username'),
                      ),
                      cursorHeight: cursorHeight,
                      validator: (value) {
                        if (value!.isEmpty || value.length <= 5) {
                          return 'Please Enter at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _username = newValue;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                    obscureText: true,
                    cursorHeight: cursorHeight,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password should be at least 7 characters';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _password = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  widget.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: _trySubmit,
                            child: Text(_isLogin ? 'Login' : 'Register'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _isLogin
                            ? 'Not having an account?'
                            : 'Already have an account?',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin ? 'REGISTER' : 'LOGIN',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
