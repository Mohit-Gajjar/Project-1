import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("admin_users").add(userMap);
  }

  getUserBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("admin_users")
        .where("email", isEqualTo: email)
        .get();
  }

  createStudentData(createdStudentInfo) async {
    return await FirebaseFirestore.instance
        .collection("student_users")
        .add(createdStudentInfo);
  }

  getStudentBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("student_users")
        .where("StudentEnrollmentNo", isEqualTo: email)
        .get();
  }

  Future<int> noOfStudent() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("student_users").get();
    var count = snapshot.size;
    print("Number of users" + count.toString());
    return count;
  }
}
