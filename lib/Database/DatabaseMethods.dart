import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("admin_users").add(userMap);
  }

  getAdminBy(String email) async {
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
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

  Future<Stream<QuerySnapshot>> getStudents() async {
    return FirebaseFirestore.instance
        .collection("student_users")
        .orderBy("TimeOfCreationOfStudent", descending: true)
        .where("role", isEqualTo: "Student")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getTeachers() async {
    return FirebaseFirestore.instance
        .collection("teacher_users")
        .where("role", isEqualTo: "Teacher")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getStudentByEnroll(String enroll) async {
    return FirebaseFirestore.instance
        .collection("student_users")
        .where("StudentEnrollmentNo", isEqualTo: enroll)
        .snapshots();
  }

  Future<int> noOfStudent() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("student_users").get();
    var count = snapshot.size;
    print("Number of users" + count.toString());
    return count;
  }

  createTeacherData(createdTeacherInfo) async {
    return await FirebaseFirestore.instance
        .collection("teacher_users")
        .add(createdTeacherInfo);
  }

  getTeacherBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("teacher_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

// getTeacherName(String email) async {
//   return await FirebaseFirestore.instance.collection("teacher_users")
// }

  Future<int> noOfTeachers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("teacher_users").get();
    var count = snapshot.size;
    print("Number of users" + count.toString());
    return count;
  }
}
