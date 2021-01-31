import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:login_firebase/shared/model/user_model.dart';
import 'package:login_firebase/utils/firebase_errors.dart';

class AuthService extends ChangeNotifier {
  AuthService() {
    _loadCurrentUser();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel user;
  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;
  Future<void> sigin(
      {UserModel user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      //  await Future.delayed(Duration(seconds: 4));
      await _loadCurrentUser(firebaseUser: result.user);

      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    } catch (e) {
      onFail(getErrorString(e.toString()));
    }

    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? _auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUsers =
          await _firestore.collection('users').doc(currentUser.uid).get();
      user = UserModel.fromDocument(docUsers);
    }
    notifyListeners();
  }

  Future<void> signup(
      {UserModel user, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      user.id = result.user.uid;
      this.user = user;
      await user.saveData();
      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    } catch (e) {
      onFail(getErrorString(e.toString()));
    }

    loading = false;
  }

  void signOut() {
    _auth.signOut();
    user = null;
    notifyListeners();
  }
}
