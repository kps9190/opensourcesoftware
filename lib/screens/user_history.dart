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

  List<Map<String, String>> scheduledReservations = [
    {
      'date': '11.12(수) 20:38',
      'storeName': '금오베이글 금오점',
      'statusText': '대기  이용예정',
      'waitingNumber': '대기 번호: 245 · 1명',
    },
  ];

  List<Map<String, String>> canceledReservations = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _cancelReservation(Map<String, String> item) {
    setState(() {
      scheduledReservations.remove(item);
      canceledReservations.add(item);
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
