import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/raw_material.dart';
import 'package:scraplink/widget/raw_material_item_card.dart';

class MaterialsWidget extends StatelessWidget {
  const MaterialsWidget({
    super.key,
    this.selectedLocation,
    this.selectedType,
    this.isInventory = false,
  });

  final String? selectedLocation;
  final String? selectedType;
  final bool isInventory;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getRawMaterial(isInventory: isInventory),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<RawMaterial> materials = snapshot.data!;
        if (selectedLocation != null) {
          materials = materials
              .where(
                  (element) => element.fkVendorId.location == selectedLocation)
              .toList();
        }
        if (selectedType != null) {
          materials = materials
              .where((element) => element.type == selectedType)
              .toList();
        }
        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.75),
            itemCount: materials.length,
            itemBuilder: (context, index) => RawMaterialItemCard(
                rawMaterial: materials[index], isInventory: isInventory),
          ),
        );
      },
    );
  }
}
