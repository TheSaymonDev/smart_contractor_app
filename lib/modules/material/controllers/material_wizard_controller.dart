import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';
import 'package:smart_contractor_app/modules/material/models/material_template_model.dart';

class MaterialWizardController extends GetxController {
  int currentStep = 1; // Step 1: বাছুন, Step 2: তালিকা, Step 3: তথ্য, Step 4: PDF

  // Search Controllers
  late TextEditingController categoriesSearchController;
  late TextEditingController templateListSearchController;
  late TextEditingController myTemplatesSearchController;

  // Template Detail Option Checkboxes
  bool checkPipeClamp = true;
  bool checkUnion = true;

  // Custom Template State
  late TextEditingController customTemplateNameController;
  String customWorkType = 'পাইপ ফিটিংস';

  // Direct List State
  late TextEditingController directWorkNameController;
  late TextEditingController directAddressController;
  String directClientName = 'আব্দুল করিম';
  String directWorkType = 'প্লাম্বিং';

  // Item Add/Edit State
  late TextEditingController itemSearchController;
  late TextEditingController itemNameController;
  late TextEditingController itemSizeController;
  late TextEditingController itemBrandController;
  late TextEditingController itemQuantityController;
  late TextEditingController itemPriceController;
  late TextEditingController itemNoteController;
  String itemUnit = 'ফুট';

  // Merge Screen State
  bool mergeItem1 = true;
  bool mergeItem2 = true;

  // Selection Data
  String selectedCategoryName = 'প্লাম্বিং';
  MaterialTemplateModel? selectedTemplate;
  List<MaterialItemModel> selectedItems = [];

  // PDF & Details Options
  bool showPricesInPdf = false;
  bool showBrandsAndNotesInPdf = true;
  late TextEditingController clientNoteController;

  // Contractor & Client Info
  String contractorName = 'রহমান কন্ট্রাক্টর সার্ভিস';
  String contractorPhone = '01712-345678';
  String contractorAddress = 'মিরপুর-১০, ঢাকা';

  String clientName = 'আব্দুল করিম';
  String clientPhone = '01812-345678';
  String clientAddress = 'মিরপুর-১০, ঢাকা';
  String jobName = 'করিমের বাসা • ২য় তলা';

  @override
  void onInit() {
    super.onInit();
    categoriesSearchController = TextEditingController();
    categoriesSearchController.addListener(() => update());

    templateListSearchController = TextEditingController();
    templateListSearchController.addListener(() => update());

    myTemplatesSearchController = TextEditingController();
    myTemplatesSearchController.addListener(() => update());

    customTemplateNameController =
        TextEditingController(text: '২ বাথরুমের পানির লাইন');

    directWorkNameController =
        TextEditingController(text: 'ট্যাংকের নতুন লাইন');
    directAddressController = TextEditingController(text: 'মিরপুর-১০, ঢাকা');

    itemSearchController = TextEditingController();
    itemNameController = TextEditingController(text: 'PPR পাইপ');
    itemSizeController = TextEditingController(text: '২০ মিমি');
    itemBrandController = TextEditingController(text: 'RFL');
    itemQuantityController = TextEditingController(text: '১০০');
    itemPriceController = TextEditingController();
    itemNoteController = TextEditingController();

    clientNoteController =
        TextEditingController(text: 'কেনার আগে মাপ মিলিয়ে নিন');
  }

  @override
  void onClose() {
    categoriesSearchController.dispose();
    templateListSearchController.dispose();
    myTemplatesSearchController.dispose();

    customTemplateNameController.dispose();

    directWorkNameController.dispose();
    directAddressController.dispose();

    itemSearchController.dispose();
    itemNameController.dispose();
    itemSizeController.dispose();
    itemBrandController.dispose();
    itemQuantityController.dispose();
    itemPriceController.dispose();
    itemNoteController.dispose();

    clientNoteController.dispose();

    super.onClose();
  }

  void setStep(int step) {
    currentStep = step;
    update();
  }

  void setSelectedCategory(String category) {
    selectedCategoryName = category;
    update();
  }

  void selectTemplate(MaterialTemplateModel template) {
    selectedTemplate = template;
    selectedItems = List.from(template.items);
    currentStep = 2;
    update();
  }

  void mergeTemplate(MaterialTemplateModel template) {
    for (var newItem in template.items) {
      int existingIndex = selectedItems.indexWhere((existing) =>
          existing.name.trim().toLowerCase() == newItem.name.trim().toLowerCase() &&
          existing.unit.trim().toLowerCase() == newItem.unit.trim().toLowerCase() &&
          existing.size.trim().toLowerCase() == newItem.size.trim().toLowerCase());

      if (existingIndex != -1) {
        final existingItem = selectedItems[existingIndex];
        selectedItems[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + newItem.quantity,
        );
      } else {
        selectedItems.add(newItem);
      }
    }
    update();
  }

  void setCheckPipeClamp(bool val) {
    checkPipeClamp = val;
    update();
  }

  void setCheckUnion(bool val) {
    checkUnion = val;
    update();
  }

  void setCustomWorkType(String type) {
    customWorkType = type;
    update();
  }

  void setDirectClientName(String name) {
    directClientName = name;
    update();
  }

  void setDirectWorkType(String type) {
    directWorkType = type;
    update();
  }

  void setItemUnit(String unit) {
    itemUnit = unit;
    update();
  }

  void setMergeItem1(bool val) {
    mergeItem1 = val;
    update();
  }

  void setMergeItem2(bool val) {
    mergeItem2 = val;
    update();
  }

  void setShowPricesInPdf(bool val) {
    showPricesInPdf = val;
    update();
  }

  void setShowBrandsAndNotesInPdf(bool val) {
    showBrandsAndNotesInPdf = val;
    update();
  }

  void addItem(MaterialItemModel item) {
    selectedItems.add(item);
    update();
  }

  void updateItem(int index, MaterialItemModel item) {
    if (index >= 0 && index < selectedItems.length) {
      selectedItems[index] = item;
      update();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < selectedItems.length) {
      selectedItems.removeAt(index);
      update();
    }
  }

  double get grandTotal {
    return selectedItems.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
