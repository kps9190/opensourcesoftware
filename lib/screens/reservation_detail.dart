import 'package:flutter/material.dart';
import 'wait_cancel.dart';

class ReservationDetailScreen extends StatelessWidget {
  final bool isCanceled; 

  const ReservationDetailScreen({super.key, this.isCanceled = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isCanceled ? '취소된 예약' : '이용예정'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('전화번호로 이용내역을 연동하세요'),
                TextButton(
                  onPressed: () {},
                  child: const Text('자세히'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(isCanceled ? '취소된 예약' : '이용예정'),
            const SizedBox(height: 4),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('금오베이글 금오점 >'),
                Text('접수 일시: 2025.11.12 (수) 20:37'),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('전화'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('위치'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('내 순서'),
                Text(isCanceled ? '취소됨' : '대기확정코드 입력 전'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isCanceled ? '-' : '3번째'),
                if (!isCanceled)
                  TextButton(
                    onPressed: () {},
                    child: const Text('새로고침'),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(isCanceled ? '대기 취소 완료' : '대기 번호 285번'),

            const SizedBox(height: 24),

            const Text('대기 정보'),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('신청 일시'),
                Text('2025.11.12 (수) 20:37'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('입장 예상시간'),
                Text('입장 예정 시간을 알 수 없어요.'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('인원'),
                Text('1명'),
              ],
            ),

            const SizedBox(height: 24),

            const Text('요청사항'),
            const SizedBox(height: 12),

            if (!isCanceled)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('내 순서 미루기'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WaitCancelConfirmScreen(),
                          ),
                        );
                        if (result == true) Navigator.pop(context, true);
                      },
                      child: const Text('대기 취소하기'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
