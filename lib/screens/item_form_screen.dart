import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/place_location.dart';
import 'package:ethircle_blk_app/widgets/location_field.dart';
import 'package:ethircle_blk_app/services/item_services.dart';
import 'package:ethircle_blk_app/providers/categories_provider.dart';
import 'package:ethircle_blk_app/widgets/image_field.dart';
import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/providers/items_provider.dart';

class ItemFormScreen extends ConsumerStatefulWidget {
  const ItemFormScreen({super.key, this.isEditing});

  final Item? isEditing;
  @override
  ConsumerState<ItemFormScreen> createState() {
    return _ItemFormScreenState();
  }
}

class _ItemFormScreenState extends ConsumerState<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredDescription = "";
  var _enteredWorth = "";
  var _enteredAddress = "";
  PlaceLocation? _selectedLocation;
  Category? _selectedCategory;
  File? _selectedImage;

  void _submitForm() async {
    final formState = _formKey.currentState;

    if (!formState!.validate()) {
      return;
    }

    formState.save();
    final itemsNotifier = ref.read(itemsProvider.notifier);

    // logic to update data
    if (widget.isEditing != null) {
      final prevData = widget.isEditing!;

      // deleting previous image if it exists
      if (_selectedImage != null && prevData.imageUrl != "") {
        await File(prevData.imageUrl).delete();
      }

      String newImageUrl = await ItemServices.saveImage(_selectedImage);

      final updatedItem = Item(
        id: prevData.id,
        name: _enteredName,
        description: _enteredDescription,
        worth: double.parse(_enteredWorth),
        address: _enteredAddress,
        catId: _selectedCategory?.id,
        isFavorite: prevData.isFavorite,
        createdAt: prevData.createdAt,
        updatedAt: DateTime.now(),
        imageUrl: newImageUrl == "" ? prevData.imageUrl : newImageUrl,
        lat: _selectedLocation == null ? prevData.lat : _selectedLocation!.lat,
        long: _selectedLocation == null
            ? prevData.long
            : _selectedLocation!.long,
      );

      itemsNotifier.editItem(updatedItem);
      ItemServices.updateItem(prevData.id!, updatedItem);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Item '${prevData.name}' changed to  '${updatedItem.name}'",
          ),
        ),
      );
      // returns the new update as the screen is popped
      Navigator.of(context).pop(updatedItem);
      return;
    }

    // checking if any new image was updated
    String imagePath = "";
    if (_selectedImage != null) {
      imagePath = await ItemServices.saveImage(_selectedImage!);
    }

    // creating new item
    final newItem = Item.create(
      name: _enteredName,
      description: _enteredDescription,
      worth: double.parse(_enteredWorth),
      address: _enteredAddress,
      imageUrl:
          "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/dell/dell-15-intel-3530/media-gallery/laptop-dell-dc15250nt-bk-plastic-gallery-1.psd?fmt=png-alpha&pscan=auto&scl=1&hei=402&wid=627&qlt=100,1&resMode=sharp2&size=627,402&chrss=full",
      catId: _selectedCategory?.id,
      lat: _selectedLocation?.lat,
      long: _selectedLocation?.long,
    );

    final response = await ItemServices.addItem(newItem);
    newItem.id = response;

    itemsNotifier.addNewItem(newItem);
    formState.reset();

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item '$_enteredName' saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final categories = ref.watch(categoriesProvider);
    final isEditing = widget.isEditing;

    // checking if category of the data to edit is not null and setting the _selected category to the appropriate value
    if (isEditing != null) {
      final categoryExist = categories.any((cat) => cat.id == isEditing.catId);

      setState(() {
        if (categoryExist) {
          _selectedCategory = categories.firstWhere(
            (cat) => cat.id == isEditing.catId,
          );
        } else {
          _selectedCategory = null;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("New Item")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Start Adding New Item",
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: isEditing == null ? "" : isEditing.name,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredName = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: isEditing == null ? "" : isEditing.description,
                  decoration: InputDecoration(
                    label: Text("Description"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  maxLines: 3,
                  onSaved: (newValue) {
                    _enteredDescription = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: isEditing == null
                      ? ""
                      : isEditing.worth.toString(),
                  decoration: InputDecoration(
                    label: Text("Worth"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a worth';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredWorth = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                LocationField(
                  onSelectLocation: (location) {
                    setState(() {
                      _selectedLocation = PlaceLocation(
                        lat: location.lat,
                        long: location.long,
                      );
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: isEditing == null ? "" : isEditing.address,
                  decoration: InputDecoration(
                    label: Text("Address"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a address';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredAddress = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                ImageField(
                  onSelectImage: (image) {
                    setState(() {
                      _selectedImage = image;
                    });
                  },
                ),
                const SizedBox(height: 16),
                categories.isNotEmpty
                    ? DropdownMenuFormField(
                        initialSelection: isEditing != null
                            ? _selectedCategory
                            : null,
                        label: Text("Categories"),
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        width: double.infinity,
                        onSaved: (newValue) {
                          _selectedCategory = newValue;
                        },

                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: null, label: "No Category"),
                          ...categories.map(
                            (cat) =>
                                DropdownMenuEntry(value: cat, label: cat.name),
                          ),
                        ],
                      )
                    : Text("No category"),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _submitForm,
            label: Text(isEditing == null ? "Add Item" : "Update Item"),
            icon: Icon(isEditing == null ? Icons.add : Icons.edit),
          ),
        ],
      ),
    );
  }
}
