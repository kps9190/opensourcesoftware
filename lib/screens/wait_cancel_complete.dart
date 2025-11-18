import 'package:flutter/material.dart';

class WaitCancelCompleteScreen extends StatelessWidget {
  const WaitCancelCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('대기가 취소되었습니다'),
              const SizedBox(height: 12),
              const Text('대기가 취소될 수 있는 경우는 아래와 같습니다.'),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all()),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. 대기확정코드를 입력하지 않은 경우'),
                    Text('2. 매장에서 호출 후 시간 내 입장하지 않은 경우'),
                    Text('3. 매장에서 대기를 취소한 경우'),
                    Text('4. 고객님께서 직접 취소 요청을 한 경우'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
