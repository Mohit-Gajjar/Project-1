import 'package:asms/Authentication/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserId? _userFromFirebaseUser(User user) {
    return UserId(userId: user.uid);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = userCredential.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {}
  }

  Future createStudentWithEmailPassword(String email, String password) async {
    try {
      UserCredential createdStudentUser = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? studentUser = createdStudentUser.user;
       return _userFromFirebaseUser(studentUser!);
    } catch (e) {}
  }

    Future createTeacherWithEmailPassword(String email, String password) async {
    try {
      UserCredential createdTeacherUser = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? teachertUser = createdTeacherUser.user;
       return _userFromFirebaseUser(teachertUser!);
    } catch (e) {}
  }
}
