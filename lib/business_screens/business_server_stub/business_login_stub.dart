class BusinessLoginStub {
  // 싱글톤 인스턴스
  static final BusinessLoginStub _instance = BusinessLoginStub._internal();
  factory BusinessLoginStub() => _instance;
  BusinessLoginStub._internal();

  // ------------------------------------------------------------------
  // 로그인 서버 스텁 코드
  // ------------------------------------------------------------------
  final List<Map<String, dynamic>> users = [
    {
      "businessNumber": "111-11-11111",
      "password": "1234",
      "userId": 1,
      "name": "강다희",
    },
    {
      "businessNumber": "222-22-22222",
      "password": "1234",
      "userId": 2,
      "name": "고명준",
    },
    {
      "businessNumber": "333-33-33333",
      "password": "1234",
      "userId": 3,
      "name": "김명진",
    },
    {
      "businessNumber": "444-44-44444",
      "password": "1234",
      "userId": 4,
      "name": "이홍철",
    },
  ];

  Future<Map<String, dynamic>> loginUser(
    String businessNumber,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final user = users.firstWhere(
        (u) =>
            u['businessNumber'] == businessNumber && u['password'] == password,
      );

      return {"success": true, "name": user['name'], "userId": user['userId']};
    } catch (e) {
      // 찾는 유저가 없으면 예외 발생 → 로그인 실패 반환
      return {"success": false, "message": "없는 아이디 또는 비밀번호"};
    }
  }

  // ------------------------------------------------------------------
  // 사업체 등록 서버 스텁 코드
  // ------------------------------------------------------------------
  Future<Map<String, dynamic>> registerUser(
    String name,
    String phoneNumber,
    String email,
    String businessNumber,
    String address,
    String password,
    String description,
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
      "businessNumber": businessNumber,
      "address": address,
      "password": password,
      "description": description,
    };

    users.add(newUser);

    return {
      "success": true,
      "userId": newUser['userId'],
      "name": newUser['name'],
      "message": "사업체 등록 성공",
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
