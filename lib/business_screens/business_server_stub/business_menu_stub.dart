class BusinessMenuStub {
  // 싱글톤
  static final BusinessMenuStub _instance = BusinessMenuStub._internal();
  factory BusinessMenuStub() => _instance;
  BusinessMenuStub._internal();

  // 초기 메뉴 데이터
  final List<Map<String, dynamic>> _menus = [
    {
      "id": 1,
      "imagePath": "assets/images/bagel.jpg",
      "title": "금오 베이글",
      "description": "따뜻하고 맛있는 베이글",
      "price": 5000,
    },
  ];

  // 메뉴 목록 가져오기
  Future<List<Map<String, dynamic>>> getMenus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List<Map<String, dynamic>>.from(_menus);
  }

  // 메뉴 추가
  Future<Map<String, dynamic>> addMenu({
    required String title,
    required String description,
    required int price,
    required String imagePath,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newMenu = {
      "id": _menus.isEmpty ? 1 : _menus.last['id'] + 1,
      "title": title,
      "description": description,
      "price": price,
      "imagePath": imagePath,
    };
    _menus.add(newMenu);
    return newMenu;
  }

  // 메뉴 수정
  Future<bool> updateMenu(int id, Map<String, dynamic> updatedData) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _menus.indexWhere((menu) => menu['id'] == id);
    if (index == -1) return false;
    _menus[index] = {..._menus[index], ...updatedData};
    return true;
  }

  // 메뉴 삭제
  Future<bool> deleteMenu(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _menus.removeWhere((menu) => menu['id'] == id);
    return true;
  }
}
