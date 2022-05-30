import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signal_chat/helpers/firestore_helper.dart';
import 'package:signal_chat/shared/global_widgets.dart';
import 'package:signal_chat/utils/constants.dart';
import 'package:signal_chat/widgets/auth/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String? username,
    XFile? userImageFile,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // upload an image to firebase storage
        final ref = FirebaseStorage.instance
            .ref('images/${userCredential.user!.uid}.jpg');

        await ref.putFile(File(userImageFile!.path));

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection(FirestoreHelper.usersCollection)
            .doc(userCredential.user!.uid)
            .set({
          'username': username,
          'email': email,
          'imageUrl': url,
        });
      }
    } on PlatformException catch (e) {
      String message = 'An error occurred, please check out your credentials!';

      if (e.message != null) {
        message = e.message!;
      }

      GlobalWidgets.globalWidgets.presentSnackBar(
        context: context,
        content: message,
        backgroundColor: Theme.of(context).errorColor,
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: AuthFormWidget(
        submitAuthForm: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
