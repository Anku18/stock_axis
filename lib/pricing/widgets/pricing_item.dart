import 'package:flutter/material.dart';

class PricingItem<T> extends StatelessWidget {
  final String title;
  final String subTitle;
  final String description;
  final IconData leadingIcon;
  final List<T> itemList;
  final Function(T?) onSelected;
  const PricingItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.leadingIcon,
    required this.itemList,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                leadingIcon,
                color: Colors.orange.withOpacity(0.8),
                size: 30,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.info_outline, color: Colors.grey),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<T>(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.green, //if selected green else grey
                ),
              ),
            ),
            hint: const Text('Select a Plan (inclusive of GST)'),
            items: itemList
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e,
                    child: Text(e.toString()),
                  ),
                )
                .toList(),
            onChanged: (val) {
              onSelected(val as T);
            },
          ),
        ],
      ),
    );
  }
}
