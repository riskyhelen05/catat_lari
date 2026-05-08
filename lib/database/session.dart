class Session {
  static int? userId;
  static String? username;
  static String? name;

  static void setUser(Map<String, dynamic> user) {
    userId = user['id'];
    username = user['username'];
    name = user['name'];
  }

  static void clear() {
    userId = null;
    username = null;
    name = null;
  }

  static bool isLoggedIn() {
    return userId != null;
  }
}