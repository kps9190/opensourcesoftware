import 'package:flutter/material.dart';
import './business_server_stub/business_edit_stub.dart';
import 'widgets/edit_item_card.dart';
import 'widgets/card_container.dart';

class BusinessEdit extends StatefulWidget {
  const BusinessEdit({super.key});

  @override
  State<BusinessEdit> createState() => _BusinessEditState();
}

class _BusinessEditState extends State<BusinessEdit> {
  String businessName = '';
  String businessDescription = '';
  String businessHours = '';
  String address = '';
  String imagePath = '';

  bool get isCompleteEnabled =>
      businessName.isNotEmpty &&
      businessDescription.isNotEmpty &&
      businessHours.isNotEmpty &&
      address.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _loadBusinessInfo();
  }

  Future<void> _loadBusinessInfo() async {
    final data = await BusinessEditStub().getBusinessInfo();
    setState(() {
      businessName = data['name'];
      businessDescription = data['description'];
      businessHours = data['hours'];
      address = data['address'];
      imagePath = data['imagePath'];
    });
  }

  Future<void> _changeImage() async {
    final updatedPath = await BusinessEditStub().updateImage();
    setState(() {
      imagePath = updatedPath;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('사진 변경 완료')));
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

  Future<void> _saveChanges() async {
    if (!isCompleteEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('빈칸을 채워주세요')));
      return;
    }

    final success = await BusinessEditStub().updateBusinessInfo({
      'name': businessName,
      'description': businessDescription,
      'hours': businessHours,
      'address': address,
      'imagePath': imagePath,
    });

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('수정 완료!')));
    }
  }

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: _changeImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text('사진 변경'),
                    ),
                  ),
                ],
              ),
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
              onPressed: _saveChanges,
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
}
