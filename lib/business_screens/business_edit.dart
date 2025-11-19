import 'package:flutter/material.dart';
import 'widgets/edit_item_card.dart';
import 'widgets/image_button_card.dart';

class BusinessEdit extends StatefulWidget {
  const BusinessEdit({super.key});

  @override
  State<BusinessEdit> createState() => _BusinessEditState();
}

class _BusinessEditState extends State<BusinessEdit> {
  String businessName = '금오 베이글';
  String businessDescription = '세상에서 가장 맛있는 초특급 럭셔리 베이글 맛집';
  String businessHours = '오늘 08:00 ~ 18:00';
  String address = '경북 구미시 대학로 61';

  bool get isCompleteEnabled =>
      businessName.isNotEmpty &&
      businessDescription.isNotEmpty &&
      businessHours.isNotEmpty &&
      address.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('사업체 정보 수정'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageButtonCard(
              imagePath: 'assets/images/london_bagel_museum.jpg',
              buttonText: '사진 변경',
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            EditItemCard(
              title: '업체명',
              value: businessName,
              onEdit: () async {
                final value = await _showEditDialog('업체명', businessName);
                if (value != null) setState(() => businessName = value);
              },
            ),
            const SizedBox(height: 20),
            EditItemCard(
              title: '업체 설명',
              value: businessDescription,
              onEdit: () async {
                final value = await _showEditDialog(
                  '업체 설명',
                  businessDescription,
                );
                if (value != null) setState(() => businessDescription = value);
              },
            ),
            const SizedBox(height: 20),
            EditItemCard(
              title: '영업시간',
              value: businessHours,
              onEdit: () async {
                final value = await _showEditDialog('영업시간', businessHours);
                if (value != null) setState(() => businessHours = value);
              },
            ),
            const SizedBox(height: 20),
            EditItemCard(
              title: '주소',
              value: address,
              onEdit: () async {
                final value = await _showEditDialog('주소', address);
                if (value != null) setState(() => address = value);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (isCompleteEnabled) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('수정 완료!')));
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('빈칸을 채워주세요')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('완료', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showEditDialog(String title, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
