import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/order_bloc.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderBloc(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.6,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(context),
                        const SizedBox(height: 16),
                        _deliveryInfo(),
                        _itemRow(context),
                        _cookingInstructions(),
                        const Divider(),
                        _promoCodeSection(),
                        const Divider(),
                        _tipValetSection(context),
                        const Divider(),
                        _chargesSection(),
                        const Divider(),
                        _covidCheckbox(),
                        const Divider(),
                        _deliveryInstructionsSection(),
                        _yourDetailsSection(),
                        _climateInfoSection(),
                        const SizedBox(height: 80), // space for button
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // confirm order logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Confirm Order"),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _header(BuildContext context) {
    return AppBar(
      title: const Text('Eat Healthy'),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _deliveryInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Delivery at Home - Flat no: 301...",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text("Delivery in 42 mins"),
      ],
    );
  }

  Widget _itemRow(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Text("Plant Protein Bowl", style: TextStyle(fontSize: 16))),
        Container(
          width: 110,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.remove, color: Colors.red),
              Text('1'),
              Icon(Icons.add, color: Colors.red),
            ],
          ),
        ),
        const SizedBox(width: 10),
        const Text("₹279"),
      ],
    );
  }

  Widget _cookingInstructions() {
    return const TextField(
      decoration: InputDecoration(
        labelText: "Add cooking instructions (optional)",
      ),
    );
  }

  Widget _promoCodeSection() {
    return ListTile(
      title: const Text("Select a promo code"),
      trailing: const Text("View offers", style: TextStyle(color: Colors.red)),
      subtitle: const Text("Save ₹59.70 with code ZOMSAFETY"),
    );
  }

  Widget _tipValetSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Please tip your valet",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [20, 30, 50].map((amount) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: OutlinedButton(
                onPressed: () {
                  context.read<OrderBloc>().add(SetTipEvent(amount));
                },
                child: Text("₹$amount"),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _chargesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _priceRow("Item Total", "₹279.00"),
        _priceRow("Delivery Charge", "₹50"),
        _priceRow("Taxes", "₹5.00"),
        _priceRow("Donate ₹3", "Add", isAction: true),
        Divider(),
        _priceRow("Grand Total", "₹334.00", bold: true),
      ],
    );
  }

  static Widget _priceRow(String label, String value,
      {bool isAction = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  color: isAction ? Colors.red : Colors.black)),
        ],
      ),
    );
  }

  Widget _covidCheckbox() {
    return Row(
      children: const [
        Checkbox(value: false, onChanged: null),
        Expanded(child: Text("This order is related to a COVID-19 emergency")),
      ],
    );
  }

  Widget _deliveryInstructionsSection() {
    return ListTile(
      title: const Text("Delivery instructions"),
      subtitle: const Text("Hand me the Order"),
      trailing: const Text("Change", style: TextStyle(color: Colors.red)),
    );
  }

  Widget _yourDetailsSection() {
    return ListTile(
      title: const Text("Your details"),
      subtitle: const Text("Divya Sigatapu, 9109109109"),
      trailing: const Text("Change", style: TextStyle(color: Colors.red)),
    );
  }

  Widget _climateInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ListTile(
          title: Text("Climate conscious delivery",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
              "We fund environmental projects to offset the carbon footprint of our deliveries."),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
              "Orders once placed cannot be cancelled and are non-refundable.",
              style: TextStyle(color: Colors.red, fontSize: 12)),
        ),
      ],
    );
  }
}
