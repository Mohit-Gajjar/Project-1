import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  createUniversity(createdUniversityMap) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .add(createdUniversityMap);
  }

  createAdmin(userMap) {
    FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("admin_users")
        .add(userMap);
  }

  getAdminBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("admin_users")
        .where("email", isEqualTo: email)
        .get();
  }

  Future<Stream<QuerySnapshot>> getTimeTable(String day) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .where(day, isEqualTo: true)
        .snapshots();
  }

  createStudentData(createdStudentInfo, String id) {
    FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .doc(id)
        .set(createdStudentInfo);
  }

  editStudentData(editStudentData, String id) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .doc(id)
        .update(editStudentData);
  }

  updateLectures(updateLecture, String id) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .doc(id)
        .update(updateLecture);
  }

  attendence(markedAttendenceData, String id, String attendenceId) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .doc(id)
        .collection("Attendence")
        .doc(attendenceId)
        .set(markedAttendenceData);
  }

  getAttendenceBy(String id) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .doc(id)
        .collection("Attendence")
        .snapshots();
  }

  getStudentInfo(String id, String enrollmentno) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .doc(id)
        .collection("Attendence")
        .where("enrollmentNo", isEqualTo: enrollmentno)
        .snapshots();
  }

  getLecturesById(String id) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .doc(id)
        .get();
  }

  editTeacherData(editTeacherData, String id) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .doc(id)
        .update(editTeacherData);
  }

  getStudentId(String email) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

  getTeacherId(String email) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

  getStudentBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

  getStudents() async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .orderBy("TimeOfCreationOfStudent", descending: true)
        .where("role", isEqualTo: "Student")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getSubject(String department) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("subjects")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getLectures(String department) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .where("department", isEqualTo: department)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getTeachers() async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .where("role", isEqualTo: "Teacher")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUniversity(String department) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("University")
        .where("Department_Name", isEqualTo: department)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getStudentByEnroll(String enroll) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .where("StudentEnrollmentNo", isEqualTo: enroll)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getStudentByLoginEmail(String email) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .where("LoginEmail", isEqualTo: email)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getSubjectByCode(String code) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("subjects")
        .where("Subject_Code", isEqualTo: code)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getLecturesByName(String name) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .where("Lecture_Name", isEqualTo: name)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getAvaliableLectures() async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .where("onGoing", isEqualTo: true)
        .snapshots();
  }

  createTeacherData(createdTeacherInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .doc(id)
        .set(createdTeacherInfo);
  }

  createAnouncements(createdAnouncementData) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .doc("anouncements_section")
        .collection("anouncements")
        .add(createdAnouncementData);
  }

  getAnouncements(String key) async {
    return FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .doc("anouncements_section")
        .collection("anouncements")
        .snapshots();
  }

  getTeacherBy(String email) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
  }

  createSubjectData(createdSubjectMap) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("subjects")
        .add(createdSubjectMap);
  }

  createLectureData(createdLecturesMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .doc(id)
        .set(createdLecturesMap);
  }

  Future<int> noOfTeachers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .get();
    var count = snapshot.size;
    print("Number of Teachers " + count.toString());
    return count;
  }

  Future<int> noOfStudent() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .get();
    var count = snapshot.size;
    print("Number of Students " + count.toString());
    return count;
  }

  Future<int> noOfSubjects() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .doc("users")
        .collection("subjects")
        .get();
    var count = snapshot.size;
    print("Number of Subjects " + count.toString());
    return count;
  }

  Future<int> noOfLectures() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .doc("users")
        .collection("lectures")
        .get();
    var count = snapshot.size;
    print("Number of Lectures " + count.toString());
    return count;
  }

  Future<String> getTeacherSubject(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .doc("users")
        .collection("teacher_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
    var subject = snapshot.docs[0]["assigned_subject"];
    return subject;
  }

  Future<String> getUniName(String department) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .where("Department_Name", isEqualTo: department)
        .get();
    var name = snapshot.docs[0]["University_Name"];
    return name;
  }

  Future<String> getUniSem(String department) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .where("Department_Name", isEqualTo: department)
        .get();
    var semester = snapshot.docs[0]["Semester"];
    return semester;
  }

  Future<String> getUniDep(String department) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .where("Department_Name", isEqualTo: department)
        .get();
    var deparment = snapshot.docs[0]["Department_Name"];
    return deparment;
  }

  Future<String> getUniCourse(String department) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .where("Department_Name", isEqualTo: department)
        .get();
    var course = snapshot.docs[0]["Course_Name"];
    return course;
  }

  Future<String> getStudentEnrollment(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("University")
        .doc("users")
        .collection("student_users")
        .where("LoginEmail", isEqualTo: email)
        .get();
    var enrollment = snapshot.docs[0]["StudentEnrollmentNo"];
    return enrollment;
  }
}
