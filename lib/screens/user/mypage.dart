import 'package:flutter/material.dart';
import '../../widget/bottom_nav_bar.dart';
import '../loginpage/main_login_screen.dart';

Map<String, dynamic>? currentUser;

final List<Map<String, dynamic>> waitingJson = [
  {
    "waiting_id": 1,
    "user_id": 12,
    "business_id": 2607890123,
    "people": 2,
    "team_no": 14,
    "status": "waiting",
    "expected_min": 25,
    "note": "",
    "created_at": "2025-01-13 12:41",
    "updated_at": "2025-01-13 12:41",
  },
  {
    "waiting_id": 2,
    "user_id": 12,
    "business_id": 2405678901,
    "people": 1,
    "team_no": 7,
    "status": "called",
    "expected_min": 5,
    "note": "",
    "created_at": "2025-01-12 18:20",
    "updated_at": "2025-01-12 18:45",
  },
];

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen>
    with TickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = currentUser != null;

    final String titleText = isLoggedIn
        ? "${currentUser!['nickname']}님"
        : "로그인 해 주세요";

    final List<Map<String, dynamic>> myWaitings = isLoggedIn
        ? waitingJson
              .where((w) => w["user_id"] == currentUser!["user_id"])
              .toList()
        : <Map<String, dynamic>>[];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          titleText,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (!isLoggedIn)
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text("로그인", style: TextStyle(color: Colors.blue)),
            ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _WaitingSummary(waitingList: myWaitings),
          ),

          if (isLoggedIn)
            TabBar(
              controller: _tab,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.deepOrange,
              tabs: const [
                Tab(text: "내 정보"),
                Tab(text: "앱 설정"),
              ],
            ),

          Expanded(
            child: isLoggedIn
                ? TabBarView(
                    controller: _tab,
                    children: [_MyInfoTab(), _AppSettingTab()],
                  )
                : const Center(
                    child: Text(
                      "로그인 후 이용할 수 있습니다.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ),
        ],
      ),

      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

class _WaitingSummary extends StatelessWidget {
  final List<Map<String, dynamic>> waitingList;
  const _WaitingSummary({required this.waitingList});

  @override
  Widget build(BuildContext context) {
    if (waitingList.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: _boxStyle(),
        child: const Text("현재 대기 중인 예약이 없습니다.", style: TextStyle(fontSize: 16)),
      );
    }

    return Column(children: waitingList.map((w) => _WaitingBox(w)).toList());
  }

  BoxDecoration _boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

class _WaitingBox extends StatelessWidget {
  final Map<String, dynamic> w;
  const _WaitingBox(this.w);

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

    switch (w["status"]) {
      case "waiting":
        statusText = "대기 중";
        statusColor = Colors.blue;
        break;
      case "called":
        statusText = "입장 호출됨";
        statusColor = Colors.green;
        break;
      case "entered":
        statusText = "입장 완료";
        statusColor = Colors.deepPurple;
        break;
      case "cancelled":
        statusText = "취소됨";
        statusColor = Colors.grey;
        break;
      default:
        statusText = "알 수 없음";
        statusColor = Colors.black54;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "번호표 ${w["team_no"]}번",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(Icons.people, size: 18),
              const SizedBox(width: 6),
              Text("${w["people"]}명"),
              const SizedBox(width: 16),

              const Icon(Icons.timer, size: 18, color: Colors.deepOrange),
              const SizedBox(width: 6),
              Text("예상 ${w["expected_min"]}분"),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(statusText, style: TextStyle(color: statusColor)),
          ),
        ],
      ),
    );
  }
}

class _MyInfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text("이메일"),
          subtitle: Text(currentUser!["email"]),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("닉네임"),
          subtitle: Text(currentUser!["nickname"]),
        ),
      ],
    );
  }
}

class _AppSettingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text("푸시 알림"),
        ),
      ],
    );
  }
}
