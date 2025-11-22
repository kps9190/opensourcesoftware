import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './business_server_stub/business_menu_stub.dart';
import 'widgets/card_container.dart';

class BusinessMenu extends StatefulWidget {
  const BusinessMenu({super.key});

  @override
  State<BusinessMenu> createState() => _BusinessMenuState();
}

class _BusinessMenuState extends State<BusinessMenu> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String _imagePath = 'assets/images/bagel.jpg';

  List<Map<String, dynamic>> _menus = [];

  @override
  void initState() {
    super.initState();
    _loadMenus();
  }

  Future<void> _loadMenus() async {
    final menus = await BusinessMenuStub().getMenus();
    setState(() {
      _menus = menus;
    });
  }

  Future<void> _addMenu() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final priceText = _priceController.text.trim();

    if (title.isEmpty || description.isEmpty || priceText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('모든 항목을 입력하세요')));
      return;
    }

    final price = int.tryParse(priceText);
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('유효한 가격을 입력하세요')));
      return;
    }

    await BusinessMenuStub().addMenu(
      title: title,
      description: description,
      price: price,
      imagePath: _imagePath,
    );

    _titleController.clear();
    _descriptionController.clear();
    _priceController.clear();

    _loadMenus();
  }

  Future<void> _editMenu(int id) async {
    final menu = _menus.firstWhere((m) => m['id'] == id);
    final titleController = TextEditingController(text: menu['title']);
    final descriptionController = TextEditingController(
      text: menu['description'],
    );
    final priceController = TextEditingController(
      text: menu['price'].toString(),
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('메뉴 수정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: '메뉴 이름'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: '메뉴 설명'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: '가격'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                final updatedTitle = titleController.text.trim();
                final updatedDescription = descriptionController.text.trim();
                final updatedPrice = int.tryParse(priceController.text.trim());

                if (updatedTitle.isEmpty ||
                    updatedDescription.isEmpty ||
                    updatedPrice == null ||
                    updatedPrice <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('모든 항목을 올바르게 입력하세요')),
                  );
                  return;
                }

                await BusinessMenuStub().updateMenu(id, {
                  'title': updatedTitle,
                  'description': updatedDescription,
                  'price': updatedPrice,
                });

                Navigator.pop(context);
                _loadMenus();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMenu(int id) async {
    await BusinessMenuStub().deleteMenu(id);
    _loadMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('메뉴 관리'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '새 메뉴 추가',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('이미지 선택은 스텁입니다')),
                      );
                    },
                    child: Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: '메뉴 이름'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: '메뉴 설명'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: '가격'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: _addMenu,
                    icon: const Icon(Icons.add),
                    label: const Text('메뉴 추가'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CardContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '등록된 메뉴',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _menus.length,
                        itemBuilder: (context, index) {
                          final menu = _menus[index];
                          return _MenuItemCard(
                            imagePath: menu['imagePath'],
                            title: '${menu['title']} - ${menu['price']}원',
                            subtitle: menu['description'],
                            onEdit: () => _editMenu(menu['id']),
                            onDelete: () => _deleteMenu(menu['id']),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// BusinessMenu 안에서만 사용되는 private 위젯
class _MenuItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MenuItemCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
