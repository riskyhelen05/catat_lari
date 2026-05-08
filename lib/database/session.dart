class Session {
  static int? userId;
  static String? username;
  static String? email;

  static void setUser(Map<String, dynamic> user) {
    userId = user['id'];
    username = user['username'];
    email = user['email']; // ✅ FIX
  }

  static void clear() {
    userId = null;
    username = null;
    email = null; // ✅ FIX
  }

  static bool isLoggedIn() {
    return userId != null;
  }
}