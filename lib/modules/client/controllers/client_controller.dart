import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientModelData {
  final String id;
  final String name;
  final String phoneAndJobs;
  final String location;
  final String dueText;

  const ClientModelData({
    required this.id,
    required this.name,
    required this.phoneAndJobs,
    required this.location,
    required this.dueText,
  });
}

class ClientController extends GetxController {
  // Clients List State
  late TextEditingController searchController;

  final List<ClientModelData> allClients = const [
    ClientModelData(
      id: '1',
      name: 'আব্দুল করিম',
      phoneAndJobs: '01812-345678 • ২টি কাজ',
      location: 'মিরপুর, ঢাকা',
      dueText: 'পাওনা ৳১০,০০০',
    ),
    ClientModelData(
      id: '2',
      name: 'সেলিম মিয়া',
      phoneAndJobs: '01711-987654 • ১টি কাজ',
      location: 'মিরপুর, ঢাকা',
      dueText: 'পাওনা ৳০',
    ),
    ClientModelData(
      id: '3',
      name: 'হানিফ স্টোর',
      phoneAndJobs: '01912-554433 • ১টি কাজ',
      location: 'মিরপুর, ঢাকা',
      dueText: 'পাওনা ৳০',
    ),
    ClientModelData(
      id: '4',
      name: 'রহিমা বেগম',
      phoneAndJobs: '01612-112233 • ১টি কাজ',
      location: 'উত্তরা, ঢাকা',
      dueText: 'পাওনা ৳৬,৫০০',
    ),
  ];

  List<ClientModelData> get filteredClients {
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) return allClients;

    return allClients.where((client) {
      return client.name.toLowerCase().contains(query) ||
          client.phoneAndJobs.contains(query) ||
          client.location.toLowerCase().contains(query);
    }).toList();
  }

  // Client Management Screen State
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController noteController;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    searchController.addListener(() => update());

    nameController = TextEditingController(text: 'আব্দুল করিম');
    phoneController = TextEditingController(text: '01812-345678');
    addressController = TextEditingController(text: 'মিরপুর-১০, ঢাকা');
    noteController = TextEditingController();
  }

  @override
  void onClose() {
    searchController.dispose();

    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    noteController.dispose();

    super.onClose();
  }
}
