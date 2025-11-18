import 'package:flutter/material.dart';
import 'wait_cancel_complete.dart';

class WaitCancelConfirmScreen extends StatefulWidget {
  const WaitCancelConfirmScreen({super.key});

  @override
  State<WaitCancelConfirmScreen> createState() => _WaitCancelConfirmScreenState();
}

class _WaitCancelConfirmScreenState extends State<WaitCancelConfirmScreen> {
  String? selectedReason;

  final List<String> reasons = [
    '대기 시간이 너무 길어요',
    '안내된 시간 내에 방문할 수 없어요',
    '다른 식당에 방문하기로 했어요',
    '단순히 마음이 바뀌었어요',
    '기타 사유',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('대기를 취소하시겠어요?'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('아래 정보 확인 후 방문을 취소해주세요.'),
            const SizedBox(height: 16),

            // 매장 정보
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(border: Border.all()),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('매장명: 금오베이글 금오점'),
                  Text('신청일시: 2025.11.12(수) 20:38'),
                  Text('인원: 1명'),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text('취소 사유를 선택해주세요.'),
            const SizedBox(height: 12),

            // 라디오 버튼 리스트
            Column(
              children: reasons.map((reason) {
                return RadioListTile<String>(
                  title: Text(reason),
                  value: reason,
                  groupValue: selectedReason,
                  onChanged: (value) {
                    setState(() {
                      selectedReason = value;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // 하단 버튼 2개
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('닫기'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedReason == null
                        ? null
                        : () async {
                             final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WaitCancelCompleteScreen(),
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
