import 'package:flutter/material.dart';
import '../widgets/reservation_card.dart';
import 'reservation_detail.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final server = Server(); // Stub 서버 인스턴스

  List<Map<String, String>> scheduledReservations = [];
  List<Map<String, String>> canceledReservations = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // 초기 데이터 Stub에서 불러오기
    scheduledReservations = server.getScheduledReservations();
    canceledReservations = server.getCanceledReservations();
  }

  void _cancelReservation(Map<String, String> item) {
    server.cancelReservation(item); // Stub에게 취소 요청

    setState(() {
      scheduledReservations = server.getScheduledReservations();
      canceledReservations = server.getCanceledReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이용내역'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '예정'),
            Tab(text: '완료'),
            Tab(text: '취소'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReservationList(scheduledReservations, isCanceled: false),
          const Center(child: Text('완료된 예약이 없습니다.')),
          _buildReservationList(canceledReservations, isCanceled: true),
        ],
      ),
    );
  }

  Widget _buildReservationList(List<Map<String, String>> list,
      {required bool isCanceled}) {
    if (list.isEmpty) {
      return const Center(child: Text('예약 내역이 없습니다.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ReservationCard(
            date: item['date']!,
            storeName: item['storeName']!,
            statusText: isCanceled ? '취소됨' : item['statusText']!,
            waitingNumber: item['waitingNumber']!,
            isCanceled: isCanceled,
            onDetailPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReservationDetailScreen(isCanceled: isCanceled),
                ),
              );

              if (result == true && !isCanceled) {
                _cancelReservation(item);
                _tabController.animateTo(2);
              }
            },
          ),
        );
      },
    );
  }
}

/* -----------------------------------------------
   Stub Server
   ----------------------------------------------- */

class Server {
  List<Map<String, String>> scheduled = [
    {
      'date': '11.12(수) 20:38',
      'storeName': '런던 베이글 안국점',
      'statusText': '대기  이용예정',
      'waitingNumber': '대기 번호: 245 · 1명',
    },
    {
      'date': '11.14(금) 18:20',
      'storeName': '해목 논현점',
      'statusText': '예약  이용예정',
      'waitingNumber': '예약 번호: 12 · 2명',
    },
     {
      'date': '11.25(월) 19:00',
      'storeName': '이재모피자 본점',
      'statusText': '예약  이용예정',
      'waitingNumber': '예약 번호: 5 · 2명',
    },
  ];

  List<Map<String, String>> canceled = [];

  List<Map<String, String>> getScheduledReservations() => scheduled;

  List<Map<String, String>> getCanceledReservations() => canceled;

  // 예약 취소 처리
  void cancelReservation(Map<String, String> item) {
    if (scheduled.contains(item)) {
      scheduled.remove(item);
      canceled.add(item);
    }
  }
}
