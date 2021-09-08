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

  // Future sendEmailAndPass(String sender, String password, String reciver,
  //     String reciverName, String loginEmail) async {
  //   final String accessToken =
  //       SmtpServer("smtp-relay.sendinblue.com","asmsproject.build@gmail.com","9OWznEXQhM812xfa") as String;
  //   final smtpServer = gmailSaslXoauth2(sender, accessToken);
  //   // final message = Message()
  //   //   ..from = Address(sender, "Admin")
  //   //   ..recipients = [reciver]
  //   //   ..subject =
  //   //       "\nHello $reciverName \n\n\nHere is your Email and Password:\n Email: $loginEmail \ nPassword: $password\n\n\n\n\nASMS TEAM";
  //   // try {
  //   //   await send(message,smtpServer);
  //   //   print(
  //   //       '--------------------------------------------\n55555555555555555555555555555');
  //   // } on MailerException catch (e) {
  //   //   print(e);
  //   // }
  //   final equivalentMessage = Message()
  //     ..from = Address(sender, 'Admin 😀')
  //     ..recipients.add(Address(reciver))
  //     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
  //     ..text = 'This is the plain text.\nThis is line 2 of the text part.';

  //   final sendReport2 = await send(equivalentMessage, smtpServer);

  //   // Sending multiple messages with the same connection
  //   //
  //   // Create a smtp client that will persist the connection
  //   var connection = PersistentConnection(smtpServer);

  //   // send the equivalent message
  //   await connection.send(equivalentMessage);

  //   // close the connection
  //   await connection.close();
  // }
}
