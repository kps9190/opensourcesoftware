class BusinessEditStub {
  // 싱글톤
  static final BusinessEditStub _instance = BusinessEditStub._internal();
  factory BusinessEditStub() => _instance;
  BusinessEditStub._internal();

  // 초기 사업체 정보
  Map<String, dynamic> _businessData = {
    'name': '금오 베이글',
    'description': '세상에서 가장 맛있는 초특급 럭셔리 베이글 맛집',
    'hours': '오늘 08:00 ~ 18:00',
    'address': '경북 구미시 대학로 61',
    'imagePath': 'assets/images/london_bagel_museum.jpg',
  };

  // 사업체 정보 가져오기
  Future<Map<String, dynamic>> getBusinessInfo() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Map<String, dynamic>.from(_businessData);
  }

  // 사업체 정보 수정
  Future<bool> updateBusinessInfo(Map<String, dynamic> newData) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _businessData = Map<String, dynamic>.from(newData);
    return true;
  }

  // 이미지 변경 (임시 이미지로 고정)
  Future<String> updateImage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _businessData['imagePath'] = 'assets/images/london_bagel_museum.jpg';
    return _businessData['imagePath'];
  }
}
