import 'package:flutter/material.dart';
import 'package:scraplink/api/api_service.dart';
import 'package:scraplink/api/model/raw_material.dart';
import 'package:scraplink/widget/raw_material_item_card.dart';

class MaterialsWidget extends StatefulWidget {
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
  State<MaterialsWidget> createState() => _MaterialsWidgetState();
}

class _MaterialsWidgetState extends State<MaterialsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getRawMaterial(isInventory: widget.isInventory),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<RawMaterial> materials = snapshot.data!;
        if (widget.selectedLocation != null) {
          materials = materials
              .where((element) =>
                  element.fkVendorId.location == widget.selectedLocation)
              .toList();
        }
        if (widget.selectedType != null) {
          materials = materials
              .where((element) => element.type == widget.selectedType)
              .toList();
        }
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.75),
              itemCount: materials.length,
              itemBuilder: (context, index) => RawMaterialItemCard(
                  rawMaterial: materials[index],
                  isInventory: widget.isInventory),
            ),
          ),
        );
      },
    );
  }
}
