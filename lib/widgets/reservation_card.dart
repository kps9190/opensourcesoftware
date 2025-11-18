import 'package:flutter/material.dart';

class ReservationCard extends StatelessWidget {
  final String date;
  final String storeName;
  final String statusText;
  final String waitingNumber;

  final VoidCallback? onDetailPressed;

  final bool isCanceled;

  const ReservationCard({
    super.key,
    required this.date,
    required this.storeName,
    required this.statusText,
    required this.waitingNumber,
    this.onDetailPressed, 
    this.isCanceled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date),
            TextButton(
              onPressed: onDetailPressed,
              child: const Text('상세보기'),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(statusText),
                        const SizedBox(height: 4),
                        Text(storeName),
                        const SizedBox(height: 4),
                        Text(waitingNumber),
                      ],
                    ),
                  ),
                ],
              ),
               
              if (!isCanceled) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('대기확정코드 입력하기'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('순서 미루기'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
