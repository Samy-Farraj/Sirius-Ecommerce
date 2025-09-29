import 'package:flutter/material.dart';

class MultiSelectScreen<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final List<String> selectedIds;
  final String Function(T) getId;
  final String Function(T) getDisplayName;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectScreen({
    super.key,
    required this.title,
    required this.items,
    required this.selectedIds,
    required this.getId,
    required this.getDisplayName,
    required this.onSelectionChanged,
  });

  @override
  State<MultiSelectScreen<T>> createState() => _MultiSelectScreenState<T>();
}

class _MultiSelectScreenState<T> extends State<MultiSelectScreen<T>> {
  late List<String> tempSelected;

  @override
  void initState() {
    super.initState();
    tempSelected = List<String>.from(widget.selectedIds);
  }

  void _toggleSelection(String id) {
    setState(() {
      if (tempSelected.contains(id)) {
        tempSelected.remove(id);
      } else {
        tempSelected.add(id);
      }
    });
  }

  void _applySelection() {
    widget.onSelectionChanged(tempSelected);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: _applySelection,
            child: const Text("Done"),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (_, index) {
          final item = widget.items[index];
          final id = widget.getId(item);
          final isSelected = tempSelected.contains(id);

          return ListTile(
            title: Text(widget.getDisplayName(item)),
            trailing: isSelected ? const Icon(Icons.check) : null,
            onTap: () => _toggleSelection(id),
          );
        },
      ),
    );
  }
}
