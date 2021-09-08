class UserId {
  String userId;
  UserId({required this.userId});
}

class PostFix {
  String postFix = "";
  void savePostFix(String postfix) {
    postFix = this.postFix;
  }

  String getPostfix() {
    return postFix;
  }
}
