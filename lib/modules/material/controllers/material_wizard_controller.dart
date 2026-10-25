import 'package:get/get.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';
import 'package:smart_contractor_app/modules/material/models/material_template_model.dart';

class MaterialWizardController extends GetxController {
  int currentStep = 1; // Step 1: বাছুন, Step 2: তালিকা, Step 3: তথ্য, Step 4: PDF

  // Selection Data
  String selectedCategoryName = 'প্লাম্বিং';
  MaterialTemplateModel? selectedTemplate;
  List<MaterialItemModel> selectedItems = [];

  // PDF & Details Options
  bool showPricesInPdf = true;
  bool showBrandsAndNotesInPdf = true;
  String clientNoteForPdf = 'কেনা আগে মাপ মিলিয়ে নিন';

  // Contractor & Client Info
  String contractorName = 'রহমান কন্ট্রাক্টর সার্ভিস';
  String contractorPhone = '01712-345678';
  String contractorAddress = 'মিরপুর-১০, ঢাকা';

  String clientName = 'আব্দুল করিম';
  String clientPhone = '01812-345678';
  String clientAddress = 'মিরপুর-১০, ঢাকা';
  String jobName = 'করিমের বাসা • ২য় তলা';

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
