// user_server_stub/login_stub.dart
class UserLoginStub {
  // 싱글톤 인스턴스
  static final UserLoginStub _instance = UserLoginStub._internal();
  factory UserLoginStub() => _instance;
  UserLoginStub._internal();

  // ------------------------------------------------------------------
  // 로그인 서버 스텁 코드
  // ------------------------------------------------------------------
  final List<Map<String, dynamic>> users = [
    {
      "email": "test1@naver.com",
      "password": "1234",
      "userId": 1,
      "name": "강다희",
      "phoneNumber": "010-1111-1111",
    },
    {
      "email": "test1@gmail.com",
      "password": "1234",
      "userId": 2,
      "name": "고명준",
      "phoneNumber": "010-2222-2222",
    },
    {
      "email": "test2@naver.com",
      "password": "1234",
      "userId": 3,
      "name": "김명진",
      "phoneNumber": "010-3333-3333",
    },
    {
      "email": "test2@gmail.com",
      "password": "1234",
      "userId": 4,
      "name": "이홍철",
      "phoneNumber": "010-4444-4444",
    },
  ];

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final user = users.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
      );

      return {"success": true, "name": user['name'], "userId": user['userId']};
    } catch (e) {
      // 찾는 유저가 없으면 예외 발생 → 로그인 실패 반환
      return {"success": false, "message": "없는 아이디 또는 비밀번호"};
    }
  }

  // ------------------------------------------------------------------
  // 회원가입 서버 스텁 코드
  // ------------------------------------------------------------------
  Future<Map<String, dynamic>> registerUser(
    String name,
    String phoneNumber,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final exists = users.any((u) => u['email'] == email);
    if (exists) {
      return {"success": false, "message": "이미 존재하는 이메일입니다."};
    }

    final newUser = {
      "userId": users.length + 1,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "password": password,
    };

    users.add(newUser);

    return {
      "success": true,
      "userId": newUser['userId'],
      "name": newUser['name'],
      "message": "회원가입 성공",
    };
  }

  // ------------------------------------------------------------------
  // 인증번호 요청 스텁 코드
  // ------------------------------------------------------------------
  Future<Map<String, dynamic>> sendVerifyCode(String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {"success": true, "code": "2222"};
  }
}
